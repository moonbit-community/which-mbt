///|
pub type! WhichError {
  /// when path is not found
  PathNotFound(String)
  /// when platform is unknown
  ///
  /// casue
  ///
  UnknownPlatform(String)
  /// when platform is not supported
  UnSupportedPlatform(String)
  /// 
  FileNotFound(String)
} derive(Show)
