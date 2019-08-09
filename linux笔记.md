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