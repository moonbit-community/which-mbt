///|
priv struct File {
  name : String
  path : Array[String]
  path_split : String
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
  filepath~ : Array[String] = [""],
) -> File raise WhichError {
  let plt = get_platform_ffi()
  if plt == "unknown" || plt.has_prefix("Which") {
    if plt.has_prefix("Which") {
      raise UnSupportedPlatform(plt)
    }
    raise UnknownPlatform("unknown platform")
  }
  {
    name: filename,
    path: if filepath[0] == "" {
      match plt {
        "win32" => ["Path"]
        "linux" | "darwin" => ["PATH"]
        _ => raise UnSupportedPlatform("unknown platform")
      }
    } else {
      filepath
    },
    path_split: if plt == "win32" {
      ";"
    } else {
      ":"
    },
    ext: if plt == "win32" {
      if filename.contains(".") {
        ""
      } else {
        // TODO: use PATHEXT to get the possible ext
        ".exe"
      }
    } else {
      ""
    },
  }
}

///| Find the file in the environment variables
/// use @fs to check if the file exists
fn File::find(self : File) -> Array[String] raise WhichError {
  let result = []
  let xx = @sys.get_env_vars().get(self.path[0])
  if xx is None {
    raise PathNotFound("PATH not found")
  } else {
    let paths = xx.unwrap().split(self.path_split)
    for path in paths {
      /// replace the backslash to forward slash
      let mut pth = path.replace_all(old="\\", new="/").to_string()

      /// incase if user's path is like "/bin/"
      if not(pth.has_suffix("/")) {
        pth = pth + "/"
      }

      /// add the file name and file ext 
      pth += self.name + self.ext

      /// check if the file exists, true then add to the result
      try @fs.is_file(pth) catch {
        _ => continue
      } noraise {
        _ => result.push(pth)
      }
    }
  }
  result
}

///| Find the file in the given path
fn File::find_in(self : File) -> Array[String] raise WhichError {
  let result = []
  for path in self.path {

    /// replace the backslash to forward slash
    let mut pth = path.replace_all(old="\\", new="/")

    /// incase if user's path is like "/bin/"
    if not(pth.has_suffix("/")) {
      pth = pth + "/"
    }

    /// add the file name and file ext 
    pth += self.name + self.ext

    /// check if the file exists, true then add to the result
    try @fs.is_file(pth) catch {
      _ => raise FileNotFound("no such file or directory")
    } noraise {
      _ => result.push(pth)
    }
  }
  result
}
