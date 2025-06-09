# which-mbt  

A cross-platform Unix `which` command tool implemented in Moonbit, designed to locate installed executables.  

## Supported Platforms  

- Windows  
- macOS  
- Linux  

## Installation  

```bash  
moon update  
moon add FrenchPicnic/which  
```  

## Usage  

Example: Use `which` to find the path of the `moon` executable on your system.  

```moonbit  
/// Locate the path of 'moon'  
let pth = @which.which?("moon")  
match pth {  
  Ok(x) => println(x)  
  Err(e) => println(e)  
}  
```  
This program is expected to output the path of your `moon` executable.  

## Notes  

- The current `WSAM` environment **does not support** accessing the host system environment. Therefore, you must specify the compilation target as `native/llvm` or `js`.  
- For non-Windows platforms, `js` target requires root privileges to execute.  

Example:  
```bash  
moon run xxx.mbt --target native  
```  

## Documentation  

Refer to the [documentation on Mooncake](https://mooncakes.io/docs/FrenchPicnic/which) or read the source code.  
