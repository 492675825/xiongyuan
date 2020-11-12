

注意：
表已经创建, 数据已经插入表中;不用再创建表和插入数据！！！

/*
create table student(
sno varchar2(10) primary key,
sname varchar2(20),
sage number(2),
ssex varchar2(5)
);
create table teacher(
tno varchar2(10) primary key,
tname varchar2(20)
);
create table course(
cno varchar2(10),
cname varchar2(20),
tno varchar2(20),
constraint pk_course primary key (cno,tno)
);
create table sc(
sno varchar2(10),
cno varchar2(10),
score number(4,2),
constraint pk_sc primary key (sno,cno)
);


--初始化学生表的数据--
insert into student values ('s001','张三',23,'男');
insert into student values ('s002','李四',23,'男');
insert into student values ('s003','吴鹏',25,'男');
insert into student values ('s004','琴沁',20,'女');
insert into student values ('s005','王丽',20,'女');
insert into student values ('s006','李波',21,'男');
insert into student values ('s007','刘玉',21,'男');
insert into student values ('s008','萧蓉',21,'女');
insert into student values ('s009','陈萧晓',23,'女');
insert into student values ('s010','陈美',22,'女');

--初始化教师表--
insert into teacher values ('t001', '刘阳');
insert into teacher values ('t002', '谌燕');
insert into teacher values ('t003', '胡明星');

--初始化课程表--
insert into course values ('c001','J2SE','t002');
insert into course values ('c002','Java Web','t002');
insert into course values ('c003','SSH','t001');
insert into course values ('c004','Oracle','t001');
insert into course values ('c005','SQL SERVER 2005','t003');
insert into course values ('c006','C#','t003');
insert into course values ('c007','JavaScript','t002');
insert into course values ('c008','DIV+CSS','t001');
insert into course values ('c009','PHP','t003');
insert into course values ('c010','EJB3.0','t002');


--初始化成绩表--
insert into sc values ('s001','c001',78.9);
insert into sc values ('s002','c001',80.9);
insert into sc values ('s003','c001',81.9);
insert into sc values ('s004','c001',60.9);
insert into sc values ('s001','c002',82.9);
insert into sc values ('s002','c002',72.9);
insert into sc values ('s003','c002',81.9);
insert into sc values ('s001','c003','59');
 
*/





练习：
注意：以下练习中的数据是根据初始化到数据库中的数据来写的SQL 语句，请大家务必注意。
1、查询“c001”课程比“c002”课程成绩高的所有学生的学号；
2、查询平均成绩大于60 分的同学的学号和平均成绩；
3、查询所有同学的学号、姓名、选课数、总成绩；
4、查询姓“刘”的老师的个数；
5、查询没学过“谌燕”老师课的同学的学号、姓名；
6、查询学过“c001”并且也学过编号“c002”课程的同学的学号、姓名；
7、查询学过“谌燕”老师所教的所有课的同学的学号、姓名；
8、查询课程编号“c002”的成绩比课程编号“c001”课程低的所有同学的学号、姓名；
9、查询所有课程成绩小于60 分的同学的学号、姓名；
10、查询没有学全所有课的同学的学号、姓名；
11、查询至少有与学号一门课为“s001”的同学所学相同的同学的学号和姓名；
12、查询学过学号为“s001”同学所有门课的其他同学学号和姓名；
13、把“SC”表中“谌燕”老师教的课的成绩都更改为此课程的平均成绩；
14、查询和“s001”号的同学学习的课程完全相同的其他同学学号和姓名；
15、查询各科成绩最高和最低的分：以如下形式显示：课程ID，最高分，最低分
16、按各科平均成绩从低到高和及格率的百分数从高到低顺序









