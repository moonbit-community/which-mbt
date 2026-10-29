///|
/// Find the first matching file in environment variables based on the given filename
///
/// # Parameters
///
/// - `filename` : The string representing the path to be checked.
///
/// # Returns
///
/// - `String` : the absolute path of the file  
pub fn which(filename : String) -> String raise WhichError {
  which_all(filename)[0]
}

///|
/// Find all matching files in environment variables based on the given filename
pub fn which_all(filename : String) -> Array[String] raise WhichError {
  let matches = File::new(filename).find()
  if matches.is_empty() {
    raise FileNotFound("No such file or directory")
  }
  matches
}

///|
/// Find the first matching file based on the given filename and filepath
///
/// # Parameters
///
/// - `filename` : The string representing the path to be checked.
/// 
/// - `filepath` : A string array containing all paths to be searched.
///
/// # Returns
///
/// - `String` : the absolute path of the file  
pub fn which_in(
  filename : String,
  filepath : Array[String],
) -> String raise WhichError {
  which_in_all(filename, filepath)[0]
}

///|
/// Find all matching file based on the given filename and filepath
/// 
/// # Parameters
///
/// - `filename` : The string representing the path to be checked.
/// 
/// - `filepath` : A string array containing all paths to be searched.
///
/// # Returns
///
/// - `Array[String]` : A string array containing all the file in given filepath  
pub fn which_in_all(
  filename : String,
  filepath : Array[String],
) -> Array[String] raise WhichError {
  let matches = File::new(filename, filepath~).find_in()
  if matches.is_empty() {
    raise FileNotFound("No such file or directory")
  }
  matches
}

// IOError
