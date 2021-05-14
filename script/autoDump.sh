#!/bin/bash
#########################################################

#dump_syms文件路径
DUMP_SYMS_PATH=./dump_syms

#minidump_stackwalk文件路径
MINIDUMP_STACKWALK_PATH=./minidump_stackwalk

#产生crashdump文件路径
CEASHDUMP_PATH="./crashdump/"

#产生symbols文件路径路径
SYMBOLS_PATH="./crashdump/symbols/"

#########################################################

#创建单个Symbol函数
function CreateSymbol(){
    ${DUMP_SYMS_PATH} ${1} > ${1}.sym
    SYMBOL_CODE=`grep "MODULE*" ${1}.sym | head -1 | cut -d " " -f 4`
    
    if [ ! -n "${SYMBOL_CODE}" ]
    then
        rm ${1}.sym
    else
        mkdir -p ${SYMBOLS_PATH}${2}/${SYMBOL_CODE}
        mv ${1}.sym ${SYMBOLS_PATH}${2}/${SYMBOL_CODE}
        echo 'CREATE ' ${SYMBOLS_PATH}${2}/${SYMBOL_CODE}/${2}'.sym'
    fi
}

#自动创建Symbols函数
function AutoCreateSymbols(){
    for file in `ls ${1}`
    do
        dir_or_file_path=./${file}
        CreateSymbol ${dir_or_file_path} ${file}
    done
}

#创建单个Log函数
function CreateLog(){
    ${MINIDUMP_STACKWALK_PATH} ${CEASHDUMP_PATH}${1} ${SYMBOLS_PATH} > ${CEASHDUMP_PATH}${1}.log
    if [ ! -s ${CEASHDUMP_PATH}${1}.log ]
    then
        rm ${CEASHDUMP_PATH}${1}.log
    fi
}

#自动创建Log函数
function AutoCreateLogs(){
    for dir_or_file_name in `ls crashdump/`
    do
        CreateLog ${dir_or_file_name}
    done
}

#########################################################

#检测symbols文件夹是否已存在
if [ -d ${SYMBOLS_PATH} ]
then
    rm ${SYMBOLS_PATH} -r
fi

#创建symbols文件夹
mkdir ${SYMBOLS_PATH}

#生成Symbols文件
AutoCreateSymbols `pwd`

#生成dump Logs文件
AutoCreateLogs

