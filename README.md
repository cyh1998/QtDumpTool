# QtDumpTool

为Qt项目自动生成dump日志的工具

## 项目说明

项目使用谷歌breakpad的qt wrapper，配合脚本文件，实现在Linux下自动生成dump日志文件。 
在程序崩溃时生成微软minidump文件，可追溯每个线程的堆栈信息。

## 使用方法

- Dump生成
  
  1. 在Qt工程的 `pro` 文件中引入依赖文
     
     ```qmake
     include(../dump/CrashManager.pri)
     ```
  
  2. 在 `main.cpp` 中添加头文件并在主函数中初始化
     
     ```cpp
     // 引入CrashDump处理类头文件
     #include "../dump/CrashHandler/CrashHandler.h"
     
     // 初始化并定义dump文件生成路径
     CrashManager::CrashHandler::instance()->Init(QCoreApplication::applicationDirPath() + "/crashdump");
     ```
     
     测试Dump的示例项目在 `test` 目录下，可以参考实现。

- 脚本使用
  
  1. 分析dmp文件需要两个执行程序 `dump_syms` 和 `minidump_stackwalk` ，需要去 `dump/breakpad` 下手动编译
     
     ```shell
     ./configure CXXFLAGS=-std=c++0x
     make
     ```
     
     这里已经编译好，放在了 `script` 目录下，可以直接使用
  
  2. `script` 目录下的 `autoDump.sh` 脚本用于自动生成minidump文件，将上文的两个执行程序和此脚本文件拷贝到Qt工程编译出来的可执行文件目录。当程序出现dump时，使用脚本自动生成minidump文件
     
     ```shell
     ./autoDump.sh
     ``
