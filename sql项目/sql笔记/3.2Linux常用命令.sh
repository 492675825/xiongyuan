# LINUX 常用命令
-----------------------------LINUX常用命令--------------------------------------------------------------------
1.查看当前路径
pwd 
------------------------

2.查看当前路径下面有哪些文件或文件夹
ll或者ls -l
------------------------

3.
drwxrwxr-x d表示是文件夹,权限问题r读,w写,x执行
------------------------

4.进入到某个路径
cd 路径
------------------------

5.返回上一级
cd ..
------------------------

5.返回默认进入路径
cd
------------------------

6.清屏
clear
------------------------

（不熟练）7.切换用户
su 用户名
su root (表示切换到root用户)
------------------------

（不熟练）8.新建文件夹
mkdir 文件夹名
mkdir -p 文件夹/子文件夹（多级目录）
rmdir 删除空目录（只能删除空目录）
rm -rf 删除非空目录
------------------------

（不熟练）9.创建文件
touch 文件名
例如：touch aaa.txt（创建一个名叫aaa的txt文件）
------------------------

（不熟练）10.编辑文件
vi 文件名
点击a或i进入插入模式
按esc键退出插入模式
shit+zz
退出并保存！

vim 文件名
：wq(保存并退出)
：q(退出但不保存)
------------------------

11.查看文件
cat 文件名（以只读的方式打开查看）
more 文件名（分页显示）
less 文件名
head -10 文件名(显示文件的前10行)
tail -10 文件名（显示文件的后10行）
tail -f 文件名(实时监控文件内容的变化)
例如：tail -f mydate.txt（实时监控mydate的文件内容，当文件内容发生变化的时候会自动打印）
------------------------

12.改名或移动文件
mv 文件名 新的文件名
例如：（1）mv aaa.txt bbb.txt(将aaa.txt改名为bbb.txt)
	（2）mv aaa.txt /root/(将aaa.txt移动到root中去)
------------------------

13.复制文件
cp 文件名 路径
例如：（1）cp aaa.txt bbb/（将aaa.txt复制到bbb文件夹中）
	  （2）cp -r  bbb/ ccc/（将bbb整个文件夹复制到ccc文件夹中）
	  （3）\cp -r  bbb/ ccc/（强制覆盖，将bbb整个文件夹复制到ccc文件夹中）
------------------------

14.删除文件
rm 文件名
例如：(1)rm aaa.txt(删除aaa的文件)
      (2)rm -rf bbb（表示删除bbb整个文件夹）
------------------------

15.下载文件
sz 文件名
------------------------

16.上传文件
rz
------------------------

17.打包(压缩)文件
gzip 文件名
zip mypackage.zip /home/（表示把home整个文件夹压缩成mypackage.zip文件）
tar -zcvf 打包后的名字 文件名
例如：（1）tar -zcvf a.tar.gz a1.txt a2.txt(表示把a1.txt和a2.txt一起压缩成a.tar.gz文件)
（2）tar -zcvf mypackage.tar.gz /home/(表示把home文件中的所有文件都压缩成一个名为mypackage.tar.gz的文件)
------------------------

18.解压文件
gunzip 文件.gz
unzip -d /opt/tmp/ mypackage.zip(表示把mypackage.zip解压到opt/tmp的文件夹下面)
tar -xvf 包名
例如：(1)tar -zxvf a.tar.gz（表示把a.tar.gz文件解压到当前文件）
(2)tar -zxvf mypackage.tar.gz -c /opt/(表示把mypackage.tar.gz文件解压到opt目录中去)
------------------------

19.查找文件
find -name 文件名
例如：find -name aaa.txt
find / -size +20M(从根目录下查找20M以上的文件)
find / -size -20M(从根目录下查找20M以下的文件)
find / -size 20M(从根目录下查找等于20M的文件)
------------------------

20.路径
./ 当前目录下
../ 上级目录下
------------------------

21.可以换行输入
\
------------------------

22.查看ip
ifconfig
------------------------

23.查看磁盘占用情况
df
------------------------

（重要）24.设置脚本定时
crontab -e 设置定时任务
例如：crontab -e
		*/1 * * * * ls -l /etc>>tmp/to.txt(表示 每分钟调把ls -l追加写入to.txt)
------------------------
BNM, 
（重要）25.查看定时任务
crontab -l 查看定时任务
crontab -r 删除定时任务
------------------------

24.将文件覆盖或追加写入
echo "asdf" >>a.txt (将asdf写入a.txt)
>（覆盖写入）
例如：ll >a.txt（将ll查出来的内容写入到a.txt中，如果已经有a.txt则覆盖写入）
>>(追加写入)
例如：ll >>a.txt(将ll查出来的内容写入到a.txt中，如果已经有a.txt则追加写入)
------------------------

25、显示当前日期
cal 以日历的方式显示时间
date 显示当前所在的年月日明细数据
date "+%Y-%m-%d" 按照固定的日期格式显示时间
------------------------

26、查看操作的历史记录
history
------------------------
27、修改权限
chmod u=rwx,g=rx,o=rw abc（表示给用户自己rwx权限，给用户所在组rx的权限，给其他组rw的权限）
或者：chmod 744 表示给当前用户一个rwx的完整权限
------------------------

28、查看网络情况
ping
例如：ping www.baidu.com
ctrl+z 停止ping
------------------------

shell脚本就是封装好的基础linux命令！存储过程跟sql关系！
shell脚本可以用于设置调度作业！
用crontab 创建定时任务！
https://blog.csdn.net/zhangxiaojun211/article/details/85053637

------------------------------------定时调度--------------------------------------------------------------

定时调度：创建一个定时调度任务，每隔一分钟，将当前的日期信息，追加到/tmp/mydate文件中
解答：
（1）先创建一个脚本文件mytask1.sh放在/home/目录下面
	vim mytask1.sh
（2）在mytask1.sh脚本文件中写入以下代码
	#!/bin/bash
	date >> /tmp/mydate
（3）为mytask1.sh文件配置执行权限
	chmod 744 /home/mytask1.sh
（4）打开调入器
	crontab -e
（5）在crontab -e 的界面中输入定时的代码
	*/1 * * * * /home/mytask1.sh

------------------------------------shell脚本课程---------------------------------------------------------

一、格式、shell脚本格式(开头)
	#!/bin/bash

二、编辑代码
	vim 文件名.sh
	例如:vim myshell.sh
	在myshell.sh里面写代码

三、在shell文件中编程(这里假设是myshell.sh文件)
	#!/bin/bash         --在shell脚本中#号是注销的符号
	echo "hello.world"  --这里的echo相当于python中的print

四、shell的执行
	方法一（实际工作中常用）
	(1)先给shell文件分配可执行权限
	chmod 744 myshell.sh
    (2)使用相对路径调用myshell.sh
    ./myshell.sh
    方法二（比较少用，以sh开头，明确是用sh来执行）
    sh ./myshell.sh

五、shell的变量
	定义变量：a=100
		注：变量定义不能用数字开头
	引用变量：echo "a=$a"或者echo $(a)
	删除变量:unset a
六、运算符
	方法一：
	expr m + n 
	方法二：
	"$((运算的内容))"
	例如：result=$(((2+3)*4))
	方法三（推荐使用）：
	$[运算的内容]
	例如：result=$[(2+3)*4]
七、流程控制
（一）条件判断语句
	1、格式：if [ 条件语句 ]
	注意：[]中的条件语句前后有空格
	2、比较符
	（1）字符串之间的比较
	=:字符串之间的比较
	例如：if [ "OK"="ok" ]
		  then echo "equal"
		  else echo "not equal"
		  fi

	（2）数与数之间的比较
	-lt ：小于 means "less than"
	-le :小等于 means "less than equal to"
	-eq：等于 means "equal"
	-gt ：大于 means "greater than"
	-ge ：大等于 means "greater than equal to"
	-ne :不等于 means "not equal to"

	例如:if [ 20 -gt 22 ]
		then echo "大于"
		else echo "不大于"
		fi
	（3）判断文件是否存在
	
	例如：
		if [ -e /home/abc.txt ]
		then echo "存在"
		else echo "不存在"
		fi
（二）for循环语句
	1、格式：
			for 变量 in 值1，值2，值3
			do
			程序内容
			done
（三）while循环
	1、格式： 
			while [ 条件判断式 ]
			do
				程序
			done
八、读取控制台的输入（类似于python中的input功能）
	1、基本语法
	read(选项)(参数)
	选项：-p:读取时的提示内容 -t:读取时等待的时间
	参数：参数，指读取值得变量名
	例如：（1）读取控制台输入的一个num值
			read -p "请输入一个数num=" NUM1
			echo "你输入的值是 num1=$NUM1"
		  （2）读取控制台输入的一个num值，并且在10秒内输入
		  	read -t 10 -p "请输入一个数num" NUM1
		  	echo "你输入的值是 num1=$NUM1"
九、自定义函数
	1、定义：[function]funname[()]
	{
		action;
		[return int;]
	}
	2、调用：funname[值]
	例如：计算输入（用read方式输入）两个参数的和

	定义：
	function getSum(){
		SUM=$[$n1+$n2]
		echo "和是=$SUM"
	}
	调用：
	read -p "请输入第一个数n1" n1
	read -p "请输入第二个数n2" n2
	getSum $n1 $n2
	注意：定义和调用的部分都统一写在shell脚本里面

十、shell编程综合案例
	需求分析：
	（1）每天凌晨2：10备份数据库atguiguDB到/data/backup/（文件可能存在也可能不存在）
	（2）备份开始和备份结束能够给出相应的提示信息
	（3）备份后的文件要求以备份时间为文件名，并打包成.tar.gz的形式，比如：
		2018-3-12——230201.tar.gz
	（4）在备份的同时，检查是否有10天前备份的数据库文件，如果有就将其删除
	（5）shell脚本写在/usr/sbin下面

	解题：
在/usr/sbin下面新建一个mysql_db_backup.sh并写入以下内容
#!/bin/bash
#完成数据库的定时备份
#备份的路径
BACKUP=/data/backup/db
#当前的时间作为文件名
DATETIME=$(date +%Y_%m_%d_%H%M%S)
#可以输出变量调试一下
echo $DATETIME

echo "======开始备份======"
echo "======备份的路径是 $BACKUP/$DATETIME.tar.gz"

#主机
HOST=localhost
#用户名
DB_USER=root
#密码
DB_PWD=1349
#创建备份的路径(如果备份的文件夹存在，就使用，否则创建)
[ ! -d "$BACKUP/$DATETIME" ] && mkdir -p "$BACKUP/$DATETIME:"

#备份数据库名
DATABASE=atguiguDB
#执行mysql的备份数据库的指令
mysqldump -u${DB_USER} -p${DB_PWD} --host=$HOST $DATABASE | gzip > $BACKUP/$DATETIME/$DATETIME.sql.gz

#打包备份文件
cd $BACKUP
tar -zcvf $DATETIME.tar.gz $DATETIME
#删除临时目录
rm -rf $BACKUP/$DATETIME

#删除10天前的备份文件
find $BACKUP -mtime + 10 -name "*.tar.gz" -exec rm -rf {} \;

新建一个crontab -e文件，并在里面写入以下内容:
10 2 * * * mysql_db_backup.sh    (表示每天晚上的2点10分跑一次数)

-----------------------linux入门与进阶------------------------------------------
1、grep工具
	grep是行过滤工具，用于根据关键字进行行过滤
	语法：grep [选项] ‘关键字’ 文件名
	(1)高亮显示: --color=auto
	grep --color=auto 'root' password(表示在password文件中搜索含有root的关键字)
	(2)打印关键字所在的行号
	grep -n 'root' password
	(3)打印关键字所在的行号（忽略大小写）
	grep -ni 'root' password(在password文件中找root的关键字所在的行号，不管大小写)















































