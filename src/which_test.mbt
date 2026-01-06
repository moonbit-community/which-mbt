///|
///a bad test
test "panic file_not_found" {
  if is_unsupported_platform() {
    assert_unsupported_platform(fn() { let _ = which("moon222") })
  } else {
    assert_not_eq(which("moon222"), "tt")
  }
}

///|

///|
///This test may fail if the current directory is not the root of the project.
/// 
/// best way is to run this test is from the root of the project with `--target js` or `--target native`
test "find_file_in_given_path" {
  if is_unsupported_platform() {
    assert_unsupported_platform(fn() {
      let _ = which_in("hello", ["src/test"])
    })
  } else {
    assert_eq(which_in("hello", ["src/test"]), "src/test/hello.exe")
  }
}

///|
test "find_file" {
  if is_unsupported_platform() {
    assert_unsupported_platform(fn() { let _ = which("moon") })
  } else {
    assert_true(which("moon") != "")
  }
}

fn is_unsupported_platform() -> Bool {
  let plt = get_platform_ffi()
  plt == "unknown" || plt.has_prefix("Which")
}

fn assert_unsupported_platform(op : () -> Unit) {
  let mut saw_error = false
  try op() catch {
    e =>
      match e {
        UnSupportedPlatform(_) | UnknownPlatform(_) => saw_error = true
        _ => raise e
      }
  } noraise {
    _ => ()
  }
  assert_true(saw_error)
}
