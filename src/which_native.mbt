///|
fn get_platform_ffi() -> String {
  match get_platform() {
    1 => "win32"
    2 => "linux"
    3 => "darwin"
    _ => "unknown"
  }
}

///|
extern "C" fn get_platform() -> Int = "get_platform"
