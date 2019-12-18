<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [1.linux rwx 权限解读](#1linux-rwx-%E6%9D%83%E9%99%90%E8%A7%A3%E8%AF%BB)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

### 1.linux rwx 权限解读  
r(Read，读取)：对文件而言，具有读取文件内容的权限；对目录来说，具有浏览目录的权限。  
w(Write,写入)：对文件而言，具有新增,修改,删除文件内容的权限；对目录来说，具有新建，删除，修改，移动目录内文件的权限。  
x(Execute，执行)：对文件而言，具有执行文件的权限；对目录了来说该用户具有进入目录的权限。  
1、目录的只读访问不允许使用cd进入目录，必须要有执行的权限才能进入。  
2、只有执行权限只能进入目录，不能看到目录下的内容，要想看到目录下的文件名和目录名，需要可读权限。  
3、一个文件能不能被删除，主要看该文件所在的目录对用户是否具有写权限，如果目录对用户没有写权限，则该目录下的所有文件都不能被删除，文件所有者除外  
4、目录的w位不设置，即使你拥有目录中某文件的w权限也不能写该文件  

### 查看端口占用情况
查看当前所有使用的端口    
netstat -nultp  
查看固定端口的使用情况  
netstat  -anp  |grep 19092  

### 查看linux版本  
centos:cat /etc/redhat-release
ubuntu:uname -a  
 
### ssh 建立隧道  
请参考这篇[文章](http://www.zsythink.net/archives/2450/)  

ssh -f -N -L  9906:192.168.1.1:22 lxadmin@192.168.1.2  

此时 ssh -p9906 username@localhost 可以通过192.168.1.2 链接到192.168.1.1  

### 一段脚本，包含了替换以及执行命令  
```bash
#!/bin/bash
download="sudo docker_wrapper/docker_wrapper.py pull "
tag="sudo docker tag "
push="sudo docker push "
gcr="gcr.io"
ip="172.31.30.99:5000"
cat dockfile | while read line
do
        downloadline="${download}${line}"
        #替换
        tagline=$(echo $line |sed "s/${gcr}/${ip}/")
        tagx="${tag}${line} ${tagline}"
        pushx="${push}${tagline}"
        #执行字符串代表的命令
        ${downloadline}
        ${tagx}
        ${pushx}
done
```
### 查看当前机器端口连接情况
netstat -anp  | grep ESTABLISHED   


### split 中的坑  
split -b 2k -a 5 -d filename prefix  
-b 按照大小切割，-a 新文件名字prefix有多长， -d 新文件以number为结尾，  
坑：如果按照大小切割，那么最后一行可能被截断，一半在前一个文件，一半在后一个文件  

### xargs cp  
find ./ -name *.jar| grep -v lib | grep target |xargs -i cp {} ~/aa  
