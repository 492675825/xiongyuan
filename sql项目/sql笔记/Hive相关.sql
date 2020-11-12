1.查看数据库列表
  show databases;
2.创建数据库
  create database if not exists bi_db;
3.进入数据库
  use bi_db;
4.查看数据库中的表
  show tables;
5.查看数据库定义(数据库名称、数据库在HDFS目录、HDFS用户名称)
  describe database bi_db;
6.删除数据库
  drop database if exists bi_db cascade;


-- 普通表/外部表/桶表/分区表


数据类型：
数字  int
字符  string
日期  date


-- 表操作
CREATE TABLE DEPT
(DEPTNO int, 
DNAME string, 
LOC string
)
row format delimited       -- 数据文件导入是行限定
fields terminated by ','   -- 区域 终止 按照 ,分隔符
;

CREATE TABLE EMP
(EMPNO int, 
ENAME string, 
JOB string, 
MGR double, 
HIREDATE string, 
SAL double, 
COMM double, 
DEPTNO int
)
row format delimited
fields terminated by ','
;

/*
-- 将你的hive可以设置成本地模式
set hive.exec.mode.local.auto=true;
*/

-- 插入数据
insert into dept(deptno,dname,loc) values(10,'ACCOUNTING','NEW YORK'); 


-- 导入数据
load data local inpath '/home/hadoop/hive/data/dept.data' overwrite into table DEPT;
load data local inpath '/home/hadoop/hive/data/emp.data' overwrite into table EMP;


-- 导出数据
insert overwrite local directory '/home/hadoop/hive/data/tmp' row format delimited fields terminated by '\t' select * from emp; 



-- 查询
select * from emp where empno=7369;
select * from emp where empno=7369 and job='CLERK';
select * from emp where DEPTNO IN (10,20);
SELECT COUNT(1) FROM EMP;
SELECT COUNT(COMM) FROM EMP;
SELECT COUNT(DISTINCT DEPTNO) FROM EMP;
--
select deptno,count(empno)
  from emp
 group by deptno
having count(empno)>3;
--
select d.deptno,d.dname
  from emp e, dept d
 where e.deptno=d.deptno;
--
select d.deptno,d.dname
  from emp e, dept d
 where e.deptno=d.deptno
   and e.empno<>7369;
--
select d.deptno,d.dname
  from emp e
  join dept d
    on e.deptno=d.deptno
   and e.empno<>7369;


-- 注意如下不等关联不行
select d.deptno,d.dname
  from emp e
  join dept d
    on e.deptno<>d.deptno;
	 




最大问题： 数据倾斜
https://blog.csdn.net/weixin_35353187/article/details/84303518

Hadoop  做离线分析

3节点 1主2从
-- 默认最小分隔文件大小为128M
200M文件 切割为128M和72M, 2个文件

节点1  -- 保存 2 个文件
节点2  -- 保存 2 个文件
节点3  -- 保存 2 个文件

-- HDFS（分布式文件系统）：解决海量数据存储
-- MAPREDUCE（分布式运算编程框架）：解决海量数据计算
-- YARN（作业调度和集群资源管理的框架）：解决资源任务调度
大数据开发 -- java  (MAPREDUCE)
数据库     -- hbase (hive--hsql(解决了MapReduce功能))
Sqoop：数据导入导出工具（比如用于mysql和HDFS之间）



hive
1.update 表 不允许
2.delete 表 不允许


Hadoop中常用：
hdfs    分布式数据存储
sqoop   数据传输采集工具
hbase   数据库
hive    写sql 进行计算（MapReduce功能）
flume   日志数据采集框架

-- 比较流行
spark     -- scala 编程 （sparksql ）
kafka     -- 实时作业流

hive 的清屏：ctrl + l
hive  进入数据库，查看表， 几种表，表关联， 导入数据 ，导出查询结果

insert overwrite local directory '/home/hadoop/data/emp0605.data' select * from emp;
