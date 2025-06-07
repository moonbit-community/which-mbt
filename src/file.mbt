///|
struct File {
  name : String
  platform : String
  path : Array[String]
  // ext : Array[String]
  ext : String
}

///| Default the File with given `filename` and `filepath`(optional)
/// 
/// if `filepath` is empty, then use the current platform's PATH
/// 
/// if platform is win32 and filename doesn't contain a dot, then use .exe as ext  
/// 
/// TODO(or use PATHEXT to get the possible ext)
fn File::new(
  filename : String,
  filepath~ : Array[String] = [""]
) -> File!WhichError {
  let plt = get_platform_ffi()
  if plt == "unknown" || plt.has_prefix("Which") {
    if plt.has_prefix("Which") {
      raise UnSupportedPlatform(plt)
    }
    raise UnknownPlatform("unknown platform")
  }
  {
    name: filename,
    platform: plt,
    path: if filepath[0] == "" {
      match plt {
        "win32" => ["Path"]
        "linux" | "darwin" => ["PATH"]
        _ => raise UnknownPlatform("unknown platform")
      }
    } else {
      filepath
    },
    ext: if plt == "win32" {
      if filename.contains(".") {
        ""
      } else {
        ".exe"
      }
    } else {
      ""
    },
  }
}

///| Find the file in the environment variables
/// use @fs to check if the file exists
fn File::find(self : File) -> Array[String]!WhichError {
  let result = []
  let xx = @sys.get_env_vars().get(self.path[0])
  if xx is None {
    raise PathNotFound("PATH not found")
  } else {
    let paths = xx.unwrap().split(";")
    for path in paths {
      try @fs.is_file(path.to_string() + "\\" + self.name + self.ext) catch {
        _ => continue
      } else {
        _ =>
          result.push(
            path.to_string().replace_all(old="\\", new="/") +
            "/" +
            self.name +
            self.ext,
          )
      }
    }
  }
  result
}

///| Find the file in the given path
fn File::find_in(self : File) -> Array[String]!WhichError {
  let result = []
  for path in self.path {
    try @fs.is_file(path + "\\" + self.name + self.ext) catch {
      _ => raise FileNotFound("no such file or directory")
    } else {
      _ =>
        result.push(
          path.replace_all(old="\\", new="/") + "/" + self.name + self.ext,
        )
    }
  }
  result
}

///|
/// check if the file is executable
fn File::check_executable(self : File) -> Bool {
  ...
}

///|
/// if file's platform is win32 and the filename doesn't contain a dot(use for ext)  
/// 
/// then read the PATHEXT to get the possible ext and return the ext array
fn File::switch_ext(self : File) -> Array[String] {
  ...
}
