# which-mbt 

一个 Moonbit 实现的跨平台 Unix "which" 命令工具，用于定位已安装的可执行文件

## 支持平台

- Windows
- macOS
- Linux

## 安装

```bash
moon update 
moon add FrenchPicnic/which
```

## 使用

以`which`为例,查找主机下的moon可执行文件路径

```Moonbit
/// 查找moon的路径
let pth = @which.which?("moon")
match pth {
  Ok(x) => println(x)
  Err(e) => println(e)
}
```
该段程序预期将会输出您的moon可执行文件路径  


## 注意事项

目前的`WSAM`环境**不支持**访问主机系统环境,因此您在编译时需要指定编译选项为`native/llvm`或`js`,而js在非windows的平台下需要以Root执行  

例:`moon run xxx.mbt --target native`

## 文档

查阅[Mooncake上的文档](https://mooncakes.io/docs/FrenchPicnic/which)或阅读源代码