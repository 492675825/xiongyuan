
1、索引 --1.索引可以提高查询的效率 2.占用空间 3.数据增删改时需要更新索引,因此索引对增删改时会有负面影响
	前提：表数据量比较大的时候,查询比较慢
	1.如果表中的某些字段经常被查询或者表之间的关联,以及作为查询的条件出现时,就应该考虑为该列创建索引。
	2.有一条基本的准则是：当任何单个查询要检索的行少于或者等于整个表行数的10%时,索引就非常有用。
	原理：一个索引可以由一个或多个列组成,对列设置索引其实就是对列的内容按一定的方式进行排序,
		 检索数据的时候，检索排过序的数据,检索到最后一个有效数据之后就跳出检索,这样就不必进行全表扫描了。


	（1）索引种类
	    -- 结构上分类：
		B-树索引
		最常用的索引结构，默认建立的索引就是这种结构
		
		
		-- 用途上分类：
		唯一索引
		1、何时创建：当某列任意两行的值都不相同
		2、当建立Primary Key(主键)或者Unique constraint(唯一约束)时,唯一索引将被自动建立
		
		
		组合索引
		1、何时创建：当两个或多个列经常一起出现在where条件中时,则在这些列上同时创建
		2、组合索引中列的顺序是任意的,也无需相邻。但是建议将最频繁访问的列放在列表的最前面
		

		基于函数的索引
		1、何时创建：在WHERE条件语句中包含函数或者表达式时
		2、函数包括：算数表达式、PL/SQL函数、程序包函数、SQL函数、用户自定义函数。
		
		
		位图索引
		1、何时创建：列中有非常多的重复的值时候。例如某列保存了 “性别”信息。
		Where 条件中包含了很多OR操作符。较少的update操作,因为要相应的跟新所有的bitmap
	

	（2）创建索引
	    -- 唯一索引
		CREATE UNIQUE INDEX u_inx_emp_bak_empno ON emp_bak(empno);
		-- 组合索引,和顺序有关
		CREATE INDEX inx_emp_bak_deptno_job ON emp_bak(deptno,job);
		-- 基于函数的索引
		CREATE INDEX inx_emp_bak_ename ON emp_bak(substr(ename,-1,1));
		-- 位图索引
		CREATE BITMAP INDEX index_job ON emp_bak(job);
	
	
	（3）索引失效
		1.隐士转换
		SELECT * FROM EMP_BAK WHERE EMPNO = '7934';
		-- 改 SELECT * FROM EMP_BAK WHERE EMPNO = 7934;
		2.字段引用函数
		SELECT * FROM EMP_BAK WHERE TO_CHAR(EMPNO) = '7934';
		3.NULL 值判断
		SELECT * FROM EMP_BAK WHERE EMPNO IS NOT NULL;
		-- 改SELECT * FROM EMP_BAK WHERE EMPNO>0;
		4.索引列进行运算
		SELECT * FROM EMP_BAK WHERE EMPNO + 10 = 7944;
		-- 改SELECT * FROM EMP_BAK WHERE EMPNO = 7944 -10;
		SELECT * FROM EMP_BAK WHERE EMPNO <> 7944;
		-- 改    
		SELECT * FROM EMP_BAK WHERE EMPNO > 7944
        UNION ALL
        SELECT * FROM EMP_BAK WHERE EMPNO < 7944;
		5.like首字母未知（末尾字母知道）
		-- 对ename 建立了唯一索引
		SELECT * FROM EMP_BAK WHERE ename like '%S';   -- 失效
		SELECT * FROM EMP_BAK WHERE ename like 'A%S';  -- 走部分索引
		-- 改substr(ename,-1,1)建立索引
		SELECT * FROM EMP_BAK WHERE substr(ename,-1,1) ='S';
		6.组合索引(字段顺序有关）
		SELECT * FROM EMP_BAK WHERE deptno=10;                    -- 部分索引
		SELECT * FROM EMP_BAK WHERE deptno=10 AND job='SALESMAN'; -- 全部索引
		SELECT * FROM EMP_BAK WHERE job='SALESMAN';               -- 索引失效
	
	
        -----------索引---------
		SELECT COUNT(1) FROM t_test_2000w;             -- 2.59s
		SELECT COUNT(*) FROM t_test_2000w;             -- 2.58s
		SELECT COUNT(ID) FROM t_test_2000w;            -- 2.60s
		SELECT ID FROM t_test_2000w WHERE ID=1;        -- 2.60s
		SELECT ID FROM t_test_2000w WHERE ID=20000000; -- 2.58s
		
		
        -- 建立索引会对数据进行排序,并将索引数据进行存储（占用磁盘空间）
		CREATE UNIQUE INDEX idx_t_test_2000w_id ON t_test_2000w(ID); -- 11.67s
		SELECT COUNT(1) FROM t_test_2000w;             -- 2.65s
		SELECT COUNT(*) FROM t_test_2000w;             -- 2.58s
		SELECT COUNT(ID) FROM t_test_2000w;            -- 1.43s
		SELECT ID FROM t_test_2000w WHERE ID=1;        -- 0.02s
		SELECT ID FROM t_test_2000w WHERE ID=20000000; -- 0.02s
		
		-- 4个字段,2000万行数据,表数据大概占用1.2G，只对一个字段建立索引，索引大概占用350M
		-- 建立索引前查询id=1用时2.567s左右,建立索引后用时0.02s左右
		



2.表分区
	前提：表数据量比较大的时候,查询比较慢
	优点：1.提高查询效率 2.增强可用性 3.维护方便（只对某些有问题分区数据维护,不用对整张表维护）
	缺点：2.分区表需要维护（维护创建的分区）
	表分区的几种类型及操作方法
	1.范围分区：RANGE
	2.列表分区：LIST
	3.散列（哈希）分区：HASH
	4.组合分区


  （1）范围分区：
		按入职日期进行范围分区
		CREATE TABLE MYEMP
		(
			EMPNO  NUMBER(4)  PRIMARY KEY,
			ENAME VARCHAR2(10),
			HIREDATE DATE,
			DEPTNO NUMBER(7)
		)
		PARTITION  BY  RANGE (HIREDATE)
		(
			  PARTITION  part1 VALUES  LESS  THAN (TO_DATE('1981-1-1','YYYY/MM/DD')), --①
			  PARTITION  part2 VALUES  LESS  THAN (TO_DATE('1982-1-1','YYYY/MM/DD')),
			  PARTITION  part3 VALUES  LESS  THAN (TO_DATE('1983-1-1','YYYY/MM/DD')), 
			  PARTITION  part4 VALUES  LESS  THAN (TO_DATE('1988-1-1','YYYY/MM/DD')), 
			  PARTITION  part5 VALUES  LESS  THAN (MAXVALUE)                          --默认最大
		);

		-- SELECT * FROM USER_TAB_PARTITIONS WHERE TABLE_NAME='MYEMP'; 查看分区表情况

		INSERT INTO MYEMP(EMPNO,
						  ENAME,
						  HIREDATE,
						  DEPTNO)
			 VALUES(1,'张三',DATE'1980-1-1',10);
			   
		INSERT INTO MYEMP(EMPNO,
						  ENAME,
						  HIREDATE,
						  DEPTNO)
			 VALUES(2,'李四',DATE'1981-10-02',20);       
			   
		INSERT INTO MYEMP(EMPNO,
						  ENAME,
						  HIREDATE,
						  DEPTNO)
			 VALUES(3,'王五',DATE'1982-11-03',30);         
			   
			   
		INSERT INTO MYEMP(EMPNO,
						  ENAME,
						  HIREDATE,
						  DEPTNO)
			 VALUES(4,'李蕾',DATE'1983-07-08',40);  
			 
			 
		INSERT INTO MYEMP(EMPNO,
						  ENAME,
						  HIREDATE,
						  DEPTNO)
			 VALUES(5,'李华',DATE'1987-09-09',40);       
			   
		INSERT INTO MYEMP(EMPNO,
						  ENAME,
						  HIREDATE,
						  DEPTNO)
			 VALUES(6,'赵四',DATE'1989-11-03',50);        


		-- 查看分区数据
		SELECT * FROM MYEMP PARTITION(PART5);


  （2）列表分区：
		该分区的特点是某列的值比较少并且不会经常变动,基于这样的特点我们可以采用列表分区。
		按DEPTNO进行LIST分区
		CREATE TABLE MYEMP2
		(
			EMPNO  NUMBER(4)  PRIMARY KEY,
			ENAME VARCHAR2(10),
			HIREDATE DATE,
			DEPTNO NUMBER(7)
		)
		PARTITION BY LIST (DEPTNO)
		(
			  PARTITION MYEMP_DEPTNO_10  VALUES (10) ,
			  PARTITION MYEMP_DEPTNO_20  VALUES (20) ,
			  PARTITION MYEMP_DEPTNO_30  VALUES (30) , 
			  PARTITION MYEMP_DEPTNO_40  VALUES (40) 
		);

		-- SELECT * FROM USER_TAB_PARTITIONS WHERE TABLE_NAME='MYEMP2'; 查看分区表情况

		INSERT INTO MYEMP2(EMPNO,
						  ENAME,
						  HIREDATE,
						  DEPTNO)
			 VALUES(1,'张三',DATE'1980-1-1',10);
			   
		INSERT INTO MYEMP2(EMPNO,
						  ENAME,
						  HIREDATE,
						  DEPTNO)
			 VALUES(2,'李四',DATE'1981-10-02',20);       
			   
		INSERT INTO MYEMP2(EMPNO,
						  ENAME,
						  HIREDATE,
						  DEPTNO)
			 VALUES(3,'王五',DATE'1982-11-03',30);         
			   
			   
		INSERT INTO MYEMP2(EMPNO,
						  ENAME,
						  HIREDATE,
						  DEPTNO)
			 VALUES(4,'李蕾',DATE'1983-07-08',40);  
			 
			 
		INSERT INTO MYEMP2(EMPNO,
						  ENAME,
						  HIREDATE,
						  DEPTNO)
			 VALUES(5,'李华',DATE'1987-09-09',40);       
			   
		INSERT INTO MYEMP2(EMPNO,
						  ENAME,
						  HIREDATE,
						  DEPTNO)
			 VALUES(6,'赵四',DATE'1989-11-03',50);  -- 没给分区数据无法插入


	 
  （3）散列分区/HASH 分区:
	通过计算hash值,将相同的hash值放到相同的分区
	CREATE TABLE MYEMP3
	(
	  EMPNO  NUMBER(4)  PRIMARY KEY,
	  ENAME VARCHAR2(10),
	  HIREDATE DATE,
	  DEPTNO NUMBER(7)
	)
	PARTITION BY HASH (ENAME)
	   (PARTITION part01, 
		PARTITION part02);
		
	-- SELECT * FROM USER_TAB_PARTITIONS WHERE TABLE_NAME='MYEMP3'; 查看分区表情况     
		
	 INSERT INTO MYEMP3(EMPNO,
			  ENAME,
			  HIREDATE,
			  DEPTNO)
	   VALUES(1,'张三',DATE'1980-1-1',10);
		 
	INSERT INTO MYEMP3(EMPNO,
			  ENAME,
			  HIREDATE,
			  DEPTNO)
	   VALUES(2,'李四',DATE'1981-10-02',20); 
	   
	INSERT INTO MYEMP3(EMPNO,
			  ENAME,
			  HIREDATE,
			  DEPTNO)
	   VALUES(3,'张五',DATE'1982-11-03',30);  
	   
	 SELECT * FROM MYEMP3 PARTITION(part01);
	 SELECT * FROM MYEMP3 PARTITION(part02);



  （4）组合分区：
	这种分区是基于两种分区的组合,分区之中的分区被称为子分区。
	按入职日期进行范围分区,再按DEPTNO进行LIST子分区
	CREATE TABLE MYEMP4
	(
		EMPNO  NUMBER(4)  PRIMARY KEY,
		ENAME VARCHAR2(10),
		HIREDATE DATE,
		DEPTNO NUMBER(7,2)
	)
	PARTITION BY RANGE(HIREDATE) SUBPARTITION BY LIST(DEPTNO)
	(
	   PARTITION P1 VALUES LESS THAN(TO_DATE('1981-01-01','YYYY-MM-DD'))
			  (
				  SUBPARTITION P1A VALUES (10),
				  SUBPARTITION P1B VALUES (20),
				  SUBPARTITION P1C VALUES (30),
				  SUBPARTITION P1D VALUES (40)
			  ),
	   PARTITION P2 VALUES LESS THAN (TO_DATE('1982-01-01','YYYY-MM-DD'))
			  (
				  SUBPARTITION P2A VALUES (10),
				  SUBPARTITION P2B VALUES (20),
				  SUBPARTITION P2C VALUES (30),
				  SUBPARTITION P2D VALUES (40)
			  ),
	   PARTITION P3 VALUES LESS THAN (TO_DATE('1983-01-01','YYYY-MM-DD'))
			  (
				 SUBPARTITION P3A VALUES (10) ,
				  SUBPARTITION P3B VALUES (20),
				  SUBPARTITION P3C VALUES (30),
				  SUBPARTITION P3D VALUES (40)
			  ),
	   PARTITION P4 VALUES LESS THAN (TO_DATE('1988-01-01','YYYY-MM-DD'))
			  (
				 SUBPARTITION  P4A VALUES (10),
				  SUBPARTITION P4B VALUES (20),
				  SUBPARTITION P4C VALUES (30),
				  SUBPARTITION P4D VALUES (40)
			  ),
	   PARTITION P5 VALUES LESS  THAN (MAXVALUE)
			  (
				  SUBPARTITION P5A VALUES (10),
				  SUBPARTITION P5B VALUES (20),
				  SUBPARTITION P5C VALUES (30),
				  SUBPARTITION P5D VALUES (40)
			  )                
	);
	-- SELECT * FROM USER_TAB_PARTITIONS WHERE TABLE_NAME='MYEMP4'; 查看分区表情况


  （5）分区表相关操作
		1)查看分区数据（列表分区为例）
		SELECT * FROM MYEMP2 PARTITION(MYEMP_DEPTNO_40);
		1)添加分区（原有的分区表没有给定默认分区的前提）
		ALTER TABLE MYEMP2 ADD PARTITION MYEMP_DEPTNO_50 VALUES (50);
		2)删除分区
		ALTER TABLE MYEMP2 DROP PARTITION MYEMP_DEPTNO_50; 
		注意：如果删除的分区是表中唯一的分区,那么此分区将不能被删除,要想删除此分区,必须删除表。
		3)重命名表分区
		以下代码将P21更改为P2
		ALTER TABLE MYEMP2 RENAME PARTITION MYEMP_DEPTNO_50 TO MYEMP_DEPTNO_60; 


	总结：
	1.非分区表, 不能直接改为分区表（通过重新建立分区表,将旧表数据导入到分区表）
	2.创建了分区表, 给了默认分区, 不能添加其它分区
	3.建完的分区表, 数据插入只能是当前分区所能包含的数据
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	