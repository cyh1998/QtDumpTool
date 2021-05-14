#include <QCoreApplication>

// 1. 引入CrashDump处理类头文件
#include "../dump/CrashHandler/CrashHandler.h"

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    // 2. 初始化并定义dump文件生成路径
    CrashManager::CrashHandler::instance()->Init(QCoreApplication::applicationDirPath() + "/crashdump");

    // 测试dump
    int *p = nullptr;
    *p = 1;

    return 0;
}
