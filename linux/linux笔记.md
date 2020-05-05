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

### win10端口转发  
netsh interface portproxy add v4tov4 listenport=81 connectport=80 connectaddress= 192.168.0.205 protocol=tcp  


### netstat -an 

### 查看系统是centos还是ubuntu  
lsb_release -a 

### alias unalias
alias llt='ll -rt'
unalias llt

### awk 
语法：cat filename | awk -F "分隔符" '条件1 {动作1} 条件2 {动作2}'  
假设有以下文件：  
```
jason\t1
dong\t2
tom\t5
lee\t6
```
要求如果第二列小于3 则 打印第一列，否则打印第二列  
```
cat ak |awk -F "\t" '$2<3 {print $1} $2>3{print $2}'
```

### chown 改变文件所有者  
递归更改filename 所有者   
chown -R user:group filename  

###  rwx权限解释  
```
对于文件
r:读取文件内容
w:增删改文件内容，但是不能删除文件
x:执行权限

对于目录
r:查看文件夹下的内容
w:新建，删除，重命名文件，文件夹
x:进入目录
```

### crontab 
````
usage:  crontab [-u user] file   #file 里存放的是crontab任务
        crontab [ -u user ] [ -i ] { -e | -l | -r }
                (default operation is replace, per 1003.2)
        -e      (edit user's crontab)
        -l      (list user's crontab)
        -r      (delete user's crontab)
        -i      (prompt before deleting user's crontab)
        
crontab 任务格式
0   12    *    *     *          sh /path/to/script
分  时    日   月    周(周几)    指令
````
例子 
```
0   12    *    *     *          sh /path/to/script  每天十二点 0 分执行命令
0,5   12    *    *     *          sh /path/to/script  每天十二点 0 分 5 分执行命令
0   12-14    *    *     *          sh /path/to/script  每天十二点到14点 0分执行命令
*/5   12    *    *     *          sh /path/to/script   每天12点每隔五分钟执行一次
```

### cut 命令
主要用于按行切割，分析数据，下面展示常用的两种用法  
假设有文件ak，内容如下：  
```
jason\t1
dong\t2
lisa\t5
sam\t6
```
1. cat ak | cut -d 'delimeter' -f fields 按照delimeter进行切割，取出对应的字段   
cat ak cut -f 1,2  
2.cat ak | cut -c number  取出每行中的指定位置的字符  
cat ak | cut -c 2 取出第二个字符  
cat ak | cut -c 2- 从第二个字符开始向后取  
cat ak | cut -c 2-5 取出第2到5个字符  

### date 
date --date='1 day ago' +"%Y%m%d"  

### cal  查看日历

### bc 计算器，quit 退出

### df du
df -h  查看磁盘使用量  
du -h 列出文件夹下所有的文件夹及其大小  
du -ah 列出文件夹下所有文件夹及文件  
du -s 列出当前目录总大小，不列出明细  

### grep  
找出包含某字符的行  
cat ak | grep 'ja'  找出包含ja的行  
cat ak | grep -i 'ja' 找出包含ja的行,忽略大小写  
cat ak | grep -v 'ja' 找出不包含ja的行  

### diff 比较文件的差异  
diff 比较的是两个相似的文件，两个没有关系的文件最好不要拿来比较  
```
jason@DESKTOP-T9SOHC8:~$ cat ak
pumas
are
large
cat
like
jason@DESKTOP-T9SOHC8:~$ cat akl
puma
large cat
like
end
jason@DESKTOP-T9SOHC8:~$ diff ak akl
1,4c1,2
< pumas
< are
< large
< cat
---
> puma
> large cat
5a4
> end
```
如上，分别有ak和akl两个文件，diff ak akl 表示展示的内容表示ak做怎样的改变可以变成akl  
1,4c1,2 表示ak中第1到4行的内容变成akl中第1到2行的内容 c是change 的意思  
5a4 表示在ak的第五行后面添加akl第四行的内容  a 表示add  

再看下面的例子：
```
jason@DESKTOP-T9SOHC8:~$ cat akl
a
jason@DESKTOP-T9SOHC8:~$ diff ak akl
2d1
< b
jason@DESKTOP-T9SOHC8:~$
```
2d1 表示将ak中的第二行删除，将删除后的空内容放到akl的第一行后面  

### 变量的设置与解除  
```
jason@DESKTOP-T9SOHC8:~$ export name=jason #设置环境变量，可以在子进程中使用变量  
jason@DESKTOP-T9SOHC8:~$ bash #进入子进程  
jason@DESKTOP-T9SOHC8:~$ echo $name
jason
jason@DESKTOP-T9SOHC8:~$ exit
exit
jason@DESKTOP-T9SOHC8:~$ unset name #解除变量
jason@DESKTOP-T9SOHC8:~$ echo $name

jason@DESKTOP-T9SOHC8:~$
```

###  free 查看内存使用情况  
```bash
root@DESKTOP-T9SOHC8:/home/jason# free -h
              total        used        free      shared  buff/cache   available
Mem:           7.9G        3.9G        3.8G         17M        223M        3.9G
Swap:           24G         23M         23G
root@DESKTOP-T9SOHC8:/home/jason#
```

### file 查看文件类型 
```bash
root@DESKTOP-T9SOHC8:/home/jason# file aa.zip
aa.zip: Zip archive data, at least v1.0 to extract
root@DESKTOP-T9SOHC8:/home/jason# file ak
ak: ASCII text
root@DESKTOP-T9SOHC8:/home/jason# file ydj
ydj: XML 1.0 document, UTF-8 Unicode text, with CRLF line terminators
root@DESKTOP-T9SOHC8:/home/jason#
```

### which 查看当前用户PATH变量中的所有命令
默认只显示找到的第一个命令，加上-a参数则显示所有找到的结果    
````bash
root@DESKTOP-T9SOHC8:/home/jason# which ls
/bin/ls
root@DESKTOP-T9SOHC8:/home/jason# which -a ls
/bin/ls
root@DESKTOP-T9SOHC8:/home/jason# which -a which
/usr/bin/which
/bin/which
root@DESKTOP-T9SOHC8:/home/jason#
````

### whereis locate 
whereis filename|dirname   查找对应的文件或文件夹   
locate filename  查找包含filename的所并文件  
这两个命令都是在数据库文件中进行查找，所以速度很快，建议优先使用这两个命令，  
最后使用find，find是从硬盘中查询的  
因为whereis 和locate是从数据库文件中查找，而数据库文件每隔一段时间才会更新，  
可能会造成找不到文件的情况，可以用updatedb 来更新数据库文件，可能会持续几分钟  
```bash
root@DESKTOP-T9SOHC8:/home/jason# whereis java
java: /usr/share/java /usr/local/jdk/jdk1.8.0_131/bin/java
root@DESKTOP-T9SOHC8:/home/jason#
```

### find 命令 
find \[path\] -mtime n  查找n天前 1天内修改的文件  
find \[path\] -mtime +n 查找n天前修改的文件  
find \[path\] -mtime -n  查找n天内修改的文件  
find  \[path\] -name filename 在指定路径下查找对应文件  

### head tail
```bash
root@DESKTOP-T9SOHC8:/home/jason# cat ak |head -n 2 #取出文件前两条记录
a
b
root@DESKTOP-T9SOHC8:/home/jason# cat ak |head -n -5 #从头开始取，最后五条数据不要
a
b
c
d
root@DESKTOP-T9SOHC8:/home/jason#
```

```bash
root@DESKTOP-T9SOHC8:/home/jason# cat ak | tail -n 3  #取出最后三条数据  
g
h
i
root@DESKTOP-T9SOHC8:/home/jason# cat ak | tail -n +3  #从第三条开始取，取到末尾
c
d
e
f
g
h
i
```

### jobs 
查看当前bash后台进程  
加入我们增在编辑一个文件，这时候需要去bash中查询一点东西，可以按ctrl+z 将vim 放入后台，  
采用jobs -l 可以查看，用fg %n 来恢复后台的任务  
```bash
root@DESKTOP-T9SOHC8:/home/jason# vim aa.sh

[1]+  Stopped                 vim aa.sh
root@DESKTOP-T9SOHC8:/home/jason# fg %1
```

### md5sum  
当传文件到到其他服务器时，为了查看文件传输是否完整，可以使用该命令  
```bash
root@DESKTOP-T9SOHC8:/home/jason# md5sum ak
338d3385367b26ae48a773f012548ff2  ak
```

### ps -ef 查看系统进程  

### sed 
语法：cat filename | sed '\[n\[,m]] function',function 如下：
```bash
root@DESKTOP-T9SOHC8:/home/jason# cat ak #文件内容
a
b
c
d
e
f
g
h
i
root@DESKTOP-T9SOHC8:/home/jason# cat ak | sed '2,3a hello' #2行到3行后面插入指定内容
a
b
hello
c
hello
d
e
f
g
h
i
root@DESKTOP-T9SOHC8:/home/jason# cat ak | sed '2,3c hello' #2行到3行改变成指定内容
a
hello
d
e
f
g
h
i
root@DESKTOP-T9SOHC8:/home/jason# cat ak | sed '2,3d' #2行到3行斎掉
a
d
e
f
g
h
i
root@DESKTOP-T9SOHC8:/home/jason# cat ak | sed '2,3i hello' #2行到3行之前插入指定内容
a
hello
b
hello
c
d
e
f
g
h
i
root@DESKTOP-T9SOHC8:/home/jason# cat ak | sed -n '2,3p' #打印2到3行内容
b
c
root@DESKTOP-T9SOHC8:/home/jason# cat ak | sed  's/a/puma/g'  #替换，把每行的a替换成puma
puma
b
c
d
e
f
g
h
i
root@DESKTOP-T9SOHC8:/home/jason#
```

### service 
语法：service servicename start|stop|status 启动，停止，查看服务状态  
service --status-all 查看所有服务状态  

### sort
```bash
jason@DESKTOP-T9SOHC8:~$ cat so
a:1
b:12
c:2
jason@DESKTOP-T9SOHC8:~$ cat so | sort  #默认排序，以第一列字母排序
a:1
b:12
c:2
jason@DESKTOP-T9SOHC8:~$ cat so |sort -t ':' -k 2 #按：分割，以第二列字母排序
a:1
b:12
c:2
jason@DESKTOP-T9SOHC8:~$ cat so |sort -t ':' -k 2  -n #按：分割，以第二列数字排序
a:1
c:2
b:12
```

### split 
语法： 
split -b size filename  按照大小切割，大小可以以m ，k,b为单位 ，原始文件一行可能会被切为两行   
split -l num filename  按照行数切割  
split -C size filename  尽量保持原始文件行的完整性  

### su 切换用户  
推荐语法：
su - username # 使用login shell文件登录方式切换用户  
su -l username # 使用login shell文件登录方式切换用户    
如果不跟用户名，则默认切换为root  
```bash
jason@DESKTOP-T9SOHC8:~$ su - 
Password:
root@DESKTOP-T9SOHC8:~# exit
logout
jason@DESKTOP-T9SOHC8:~$ su - root
Password:
root@DESKTOP-T9SOHC8:~# exit
logout
jason@DESKTOP-T9SOHC8:~$ su -l
Password:
root@DESKTOP-T9SOHC8:~# exit
```
### sudo 切换到其他用户执行命令  
语法：  
sudo 命令  #默认切换到root 执行命令 
sudo -u username 命令   # 切换到username 用户执行命令  

### tee 双向重定向  
```bash
jason@DESKTOP-T9SOHC8:~$ ls | tee te | grep so # ls的内容被记录到了te文件中，并且继续向屏幕输出  
so
jason@DESKTOP-T9SOHC8:~$
```

### 查看当前登录的用户  
```bash
[lxadmin@dmp-dn-010 ~]$ w
 19:31:55 up 298 days, 11:07,  5 users,  load average: 0.04, 0.05, 0.05
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
lxadmin  pts/0    192.168.1.48     18:22    1:00m  0.05s  0.01s sshd: lxadmin [priv]
lxadmin  pts/3    192.168.1.48     18:19   56:59   0.15s  0.01s sshd: lxadmin [priv]
.....
lxadmin  pts/6    192.168.1.48     19:30    3.00s  0.03s  0.00s w
[lxadmin@dmp-dn-010 ~]$ who
lxadmin  pts/0        2020-05-04 18:22 (192.168.1.48)
lxadmin  pts/3        2020-05-04 18:19 (192.168.1.48)
lxadmin  pts/4        2020-05-04 14:47 (192.168.1.48)
lxadmin  pts/5        2020-05-04 14:48 (192.168.1.48)
lxadmin  pts/6        2020-05-04 19:30 (192.168.1.48)
```

### ; && ||
```bash
jason@DESKTOP-T9SOHC8:~$ cd .m2 ; ls  # cmd1 ; cmd2 不管第一条命令是否执行成功，都会执行第二条命令  
settings.xml

jason@DESKTOP-T9SOHC8:~$ cd  jj || mkdir jj #cmd1 || cmd2 如果第一个命令执行失败则执行第二个，否则不执行第二个  
-bash: cd: jj: No such file or directory
jason@DESKTOP-T9SOHC8:~$ ll jj
total 0
drwxrwxrwx 1 jason jason 512 May  4 19:58 ./
drwxr-xr-x 1 jason jason 512 May  4 19:58 ../

jason@DESKTOP-T9SOHC8:~$ cd jj && ls # cmd1 && cmd2  cmd1 执行成功才执行cmd2 否则不执行cmd2
```

### 标准输入
有的命令可以从命令行接受输入 ，比如ftp  ，cat > filename 
```bash
jason@DESKTOP-T9SOHC8:~/jj$ cat > jj   # 用cat > jj  创建文件jj
hello #在jj中输入内容 
jason  # 按 ctrl + d 可以保存退出
jason@DESKTOP-T9SOHC8:~/jj$ cat jj
hello
jason
jason@DESKTOP-T9SOHC8:~/jj$ cat >jj2 <jj  # 也可以这样创建文件并添加内容
jason@DESKTOP-T9SOHC8:~/jj$ ls
jj  jj2
jason@DESKTOP-T9SOHC8:~/jj$ cat jj2
hello
jason
jason@DESKTOP-T9SOHC8:~/jj$ cat > jj3 << eof #这样也可以 
> hello
> jason
> dong
> eof
```

### stdout  stderr  
执行一个命令的时候，有两种输出，比如 ls /home  :
1.列出/home 下的内容  这就是 stdout  
2.如果/home不存在，则输出报错信息  这个是stderr  

```bash
jason@DESKTOP-T9SOHC8:~/jj$ ls
jj  jj2  jj3
jason@DESKTOP-T9SOHC8:~/jj$ ls jj5 1> stdout 2>stderr  #将 标准输出和错误输出 分别输出到不同的文件 
                                                       # 也可以写成ls jj5 > stdout 2>stderr，基本都这样写
jason@DESKTOP-T9SOHC8:~/jj$ ll
total 0
drwxrwxrwx 1 jason jason 512 May  4 20:43 ./
drwxr-xr-x 1 jason jason 512 May  4 19:58 ../
-rw-rw-rw- 1 jason jason  12 May  4 20:30 jj
-rw-rw-rw- 1 jason jason  12 May  4 20:30 jj2
-rw-rw-rw- 1 jason jason  17 May  4 20:31 jj3
-rw-rw-rw- 1 jason jason  51 May  4 20:43 stderr
-rw-rw-rw- 1 jason jason   0 May  4 20:43 stdout

jason@DESKTOP-T9SOHC8:~/jj$ ls jj5 > stdout 2>&1  #将stdout 和 stderr 写到一个文件  
```

### 改变dos换行符为linux换行符  
在win下编辑的文件到linux上，换行符回多一个 ^M,可以用以下命令转换  
```bash
[lxadmin@dmp-dn-010 ~]$ dos2unix -n jobfc5d6ada4bfc40db9945ead518f832f1.scala  jj  #复制到新文件
dos2unix: converting file jobfc5d6ada4bfc40db9945ead518f832f1.scala to file jj in Unix format ...
[lxadmin@dmp-dn-010 ~]$ dos2unix  jobfc5d6ada4bfc40db9945ead518f832f1.scala # 直接修改原文件
dos2unix: converting file jobfc5d6ada4bfc40db9945ead518f832f1.scala to Unix format ...


也存在unix2dos 命令
```

### iconv 更改文件编码格式  
```bash
[lxadmin@dmp-dn-010 ~]$ iconv --list | grep -i gbk
GBK//
[lxadmin@dmp-dn-010 ~]$ iconv --list | grep -i utf8
ISO-10646/UTF8/
UTF8//
[lxadmin@dmp-dn-010 ~]$ iconv -f GBK -t UTF8 编辑2 -o bb  # 将文件从gbk 格式改到 utf8 格式，并输出到 文件bb  
```

###  查看系统所有环境变量  
env 

### echo -e 允许后面使用转义，默认是不允许的 
```bash
jason@DESKTOP-T9SOHC8:~/jj$ echo "hello \n china"
hello \n china
jason@DESKTOP-T9SOHC8:~/jj$ echo -e "hello \n china"
hello
 china
jason@DESKTOP-T9SOHC8:~/jj$
```

###  man echo 

### shell 的追踪  
[root@www ~]# sh [-nvx] scripts.sh  
选项与参数：  
-n  ：不要运行 script，仅查询语法的问题；  
-v  ：再运行 sccript 前，先将 scripts 的内容输出到萤幕上；  
-x  ：将使用到的 script 内容显示到萤幕上，这是很有用的参数！  