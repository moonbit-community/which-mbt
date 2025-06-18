///|a bad test
test "panic file_not_found" {
  assert_not_eq(which("moon222"), "tt")
}

///|

///|This test may fail if the current directory is not the root of the project.
/// 
/// best way is to run this test is from the root of the project with `--target js` or `--target native`
test "find_file_in_given_path" {
  assert_eq(which_in("hello", ["src/test"]), "src/test/hello.exe")
}

///|
test "find_file" {
  assert_true(which("moon") != "")
}
