///|To fail this test, you need to replace the second `moon` with your moon path
test "moon" {
  assert_not_eq!(which("moon"), "moon")
}

///|

///|This test may fail if the current directory is not the root of the project.
/// 
/// best way is to run this test is from the root of the project with `--target js` or `--target native`
test "file_in_given_path" {
  assert_eq!(which_in("hello", ["src/test"]), "src/test/hello.exe")
}
