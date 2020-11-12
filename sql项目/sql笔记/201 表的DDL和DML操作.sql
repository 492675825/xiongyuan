

DDL(数据定义语言):CREATE/ALTER/DROP + 对象类型 + 对象名称
                  --  TRUNCATE TABLE 表名;
DML(数据操作语言):INSERT INTO/UPDATE/DELETE    + 表名





/*--------------DDL---------------------*/

-- 1.CREATE 创建表
	(1)直接创建表
	CREATE TABLE 表名
	(列名1 数据类型 [,
	 列名2 数据类型]...
	);
	 -- 加注释
	COMMENT ON  TABLE 表名  IS '表注释名' ;                  
	COMMENT ON COLUMN 表名.列名1 IS '字段注释名';
	 
	-- 创建表	 
    CREATE TABLE t_stu_info
    (sno   NUMBER(10),
     sname VARCHAR2(20),
     cdate DATE
     );
	-- 加注释
	COMMENT ON  TABLE t_stu_info  IS '学生信息表' ;                  
	COMMENT ON COLUMN t_stu_info.sno IS '学号';
	COMMENT ON COLUMN t_stu_info.sname IS '姓名';
	COMMENT ON COLUMN t_stu_info.cdate IS '创建日期';
	
    -- 数据类型
	1.数字型   NUMBER        -- 默认最大为38位长度整数
			   NUMBER(10)    -- 最大长度为10的整数
			   NUMBER(8,2)   -- 整数最大长度为6位,小数长度为2位
	2.字符型   CHAR          -- 默认1位长度的字符
			   CHAR(10)      -- 最大长度为10的字符,输入值不满10位,后面补空格
			   VARCHAR2(10)  -- 最大长度为10的字符,输入值不满10位,后面不会填充
	3.日期型   DATE          -- 后面不要加括号(可以到时分秒)
			   TIMESTAMP


	(2)根据结果集创建表
	CREATE TABLE 表名 AS SELECT 语句;        

	-- 间接创建
	CREATE TABLE t_emp_cp AS SELECT * FROM EMP;            -- 拷贝表结构和数据
	CREATE TABLE t_emp_cp1 AS SELECT * FROM EMP WHERE 1=2; -- 拷贝表结构
	

			   	
-- 3.ALTER 更改表结构
	-- 【修改列数据类型】  ALTER TABLE 表名 MODIFY 列名 新的数据类型;
	/*修改的列没有数据时,可以随便更改类型；修改的列有数据时,只能在同一种类型上增加长度*/
	ALTER TABLE t_stu_info MODIFY sno VARCHAR2(20);
	alter table t modify (b varchar2(10),c varchar2(10));
	-- 【修改列名】        ALTER TABLE 表名 RENAME COLUMN 旧列名 TO 新列名;
	ALTER TABLE t_stu_info RENAME COLUMN sno TO snumber;
	-- 【增加列】          ALTER TABLE 表名 ADD 列名 数据类型;
	ALTER TABLE t_stu_info ADD sex CHAR(2);
	-- 【删除列】          ALTER TABLE 表名 DROP COLUMN 列名;
	ALTER TABLE t_stu_info DROP COLUMN sex;
	-- 【修改表名】        ALTER TABLE 表名 RENAME TO 新表名;
	ALTER TABLE t_stu_info RENAME TO t_stu_info_cp; 
	
	
-- 4.DROP 删除表对象
	 -- DROP TABLE 表名;
	 DROP TABLE t_stu_info_cp;
	 
	 
-- 5.TRUNCATE(对象是表) 删除表数据
    -- TRUNCATE TABLE 表名; 不能跟where, 清空整张表数据, 不会将清除的数据写入日志
	TRUNCATE TABLE t_stu_info; 



/*---------------DML--------------------*/
 
-- 1.INSERT INTO 插入数据到表中
    /*
	CREATE TABLE T_COURSE (
	CNO NUMBER(10),
	CNAME VARCHAR2(20),
	CDATE DATE
	);
	*/
	-- INSERT INTO 表名(列名1,列名2,……) VALUES (值1,值2……)
	INSERT INTO T_COURSE(CNO,CNAME,CDATE) VALUES (1,'语文',SYSDATE);
	INSERT INTO T_COURSE VALUES (2,'数学',DATE'2019-08-19');  #插入的时间必须是“-”隔开
	INSERT INTO T_COURSE(CNO,CNAME) VALUES (3,'英语');
	INSERT INTO T_COURSE SELECT 4,'科学', TO_DATE('2020-04-08','YYYY-MM-DD') FROM DUAL;

	
-- 2.UPDATE 更新表数据
	-- UPDATE 表名 SET 列名1=值, 列名2=值,…… WHERE 条件
	UPDATE T_COURSE SET CNAME='政治', CDATE=SYSDATE WHERE CNO=3;
	
-- 3.DELETE 删除表数据
	-- DELETE FROM 表名 WHERE 条件; 删除的数据可以从日志中找回
	DELETE FROM T_COURSE WHERE CNO=4;
		

	
注意：DROP/DELETE/TRUNCATE 的区别（语言类型不同/删除数据是否可跟条件/执行效率/是否可从日志恢复）
      DROP     是DDL语句,用于删除一个对象;
      DELETE   是DML语句,主要是针对表数据删除, 可以通过条件删除数据, 删除的数据可以从日志中找回, 效率低;
      TRUNCATE 是DML语句,主要是针对表数据删除, 不能跟where 条件, 不会将清除的数据写入日志, 效率高;


	-- 工作中用的比较多
	INSERT INTO 表名 SELECT * FROM 结果集; 
	
	
练习：先创建一张表, 将emp表的员工编号、员工姓名和其所在的部门编号、部门名称插入到表中 
/*
CREATE TABLE t_emp_dept(
empno number(20),
ename varchar2(20),
deptno number(10),
dname varchar2(20)
);

INSERT INTO T_EMP_DEPT
  (EMPNO, ENAME, D