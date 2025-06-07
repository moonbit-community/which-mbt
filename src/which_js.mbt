///|
fn get_platform_ffi() -> String {
  get_platform()
}

///|
extern "js" fn get_platform() -> String =
  #| function() {
  #|  return process.platform;
  #| }
