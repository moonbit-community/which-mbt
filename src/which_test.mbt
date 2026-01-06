///|
///a bad test
test "panic file_not_found" {
  let _ = which("moon222")

}

///|

///|
///This test may fail if the current directory is not the root of the project.
/// 
/// best way is to run this test is from the root of the project with `--target js` or `--target native`
test "find_file_in_given_path" {
  let mut saw_unsupported = false
  let mut saw_unexpected = false
  try which_in("hello", ["src/test"]) catch {
    e =>
      match e {
        UnSupportedPlatform(_) | UnknownPlatform(_) => saw_unsupported = true
        _ => saw_unexpected = true
      }
  } noraise {
    v => assert_eq(v, "src/test/hello.exe")
  }
  assert_true(not(saw_unexpected))
  if saw_unsupported {
    assert_true(true)
  }
}

///|
test "find_file" {
  let mut saw_unsupported = false
  let mut saw_unexpected = false
  try which("moon") catch {
    e =>
      match e {
        UnSupportedPlatform(_) | UnknownPlatform(_) => saw_unsupported = true
        _ => saw_unexpected = true
      }
  } noraise {
    v => assert_true(v != "")
  }
  assert_true(not(saw_unexpected))
  if saw_unsupported {
    assert_true(true)
  }
}
