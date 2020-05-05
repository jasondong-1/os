#!/bin/bash
#上一行是声明这个脚本使用的语法是bash shell
function printx(){
echo -e "$1"
}

printx "----接收用户控制台输入---"
read -p "请输入一个文件名: " filename
# echo -e 允许之后的内容存在转义字符，否则转义不起作用
echo -e "您输入的文件名是：${filename}"
printx "----接收用户控制台输入---\n"
# $@ $# $0 $1  $?
echo -e "脚本的所有参数：$@"
echo -e "脚本的参数个数：$#"
echo -e "脚本的名称：$0"
echo -e "脚本的第一个参数：$1"
echo -e "$?"

# function
function show_args(){
printx "shift $1"
shift $1
echo -e "脚本的所有参数：$@"
echo -e "脚本的参数个数：$#"
echo -e "脚本的名称：$0"
echo -e "脚本的第一个参数：$1"
}

printx "----shift的用法,参数变量号码偏移----"
show_args 0 a b c d e f
printx "========"
show_args 1 a b c d e f
printx "========"
show_args 3 a b c d e f
printx "----shift的用法,参数变量号码偏移----\n"

printx "----if else ----"
if [ -f ${filename} ]; then
 printx "$filename 是个文件"
elif [ -d ${filename} ]; then
 printx " ${filename} 是个文件夹"
else
 printx "即将创建文件 ：${filename}" ; touch ${filename}
fi
printx "----if else ----\n"

printx "----case ----"
case $1 in
 "one")
  printx "你的选择是 one"
  ;;
 "two")
  printx "你的选择是 two"
  ;;
 *)
  printx "不支持的选择"
  ;;
esac

printx "----case ----\n"

printx "----while loop----"
i=0
s=0
while [ $i -lt 100 -a $s -lt 1000 ]
do
 s=$(($s+$i))
 i=$(($i+1))
done

printx " while 遍历文件"
cat jj.sh | while read line
do
 echo "${line}"
done

printx "----while loop----\n"

printx "----for loop----"
printx "for 遍历文件，会按空格切分，建议使用while遍历文件"
for line in $(cat jj.sh)
do
 echo $line
done
sum=0
for ((i=0;i<100;i++))
do
 sum=$(($sum+$i))
done
echo -e "sum = $sum"
printx "----for loop----\n"