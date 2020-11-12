

表的约束
	按照约束用途分类：
	1.PRIMARY KEY：主键约束 （非空、唯一）          -- 身份证号
	2.FOREIGN KEY：外键约束 （受外部表主键的约束）
	3.CHECK：      检查约束 （只能为空或约束的值）  -- 性别
	4.UNIQUE：     唯一约束 （不重复、可多行为空）
	5.NOT NULL：   非空约束 （不能为空）


	-- 建表时候给定约束（系统给定约束名称）
	CREATE TABLE t_student_1 (
	sno VARCHAR2(18) PRIMARY KEY,                    -- 主键
	cno VARCHAR2(60) REFERENCES t_course_1(cno),     -- 外键
	score NUMBER(4,1) NOT NULL,
	sex VARCHAR2(200) CHECK(sex='男' OR sex='女'),
	tel NUMBER(11) UNIQUE
	);
	
	
	（1）PRIMARY KEY （主键只有一个, 但是可以对多个字段组合建立一个主键）
		CREATE TABLE t_china_id (
		ID_NO VARCHAR2(18),
		ID_NAME VARCHAR2(60),
		BIRTH_DAY DATE,
		ADDRESS VARCHAR2(200),
		TEL NUMBER(11),
		CONSTRAINT PR_ID_NO PRIMARY KEY(ID_NO)
		);
		INSERT INTO t_china_id(ID_NO) VALUES('1');
		INSERT INTO t_china_id(ID_NO) VALUES('1'); -- 重复值报错
		INSERT INTO t_china_id(ID_NO) VALUES('');  -- 空值报错
		-- 
		CREATE TABLE t_china_id_1 (
		ID_NO VARCHAR2(18),
		ID_NAME VARCHAR2(60),
		BIRTH_DAY DATE,
		ADDRESS VARCHAR2(200),
		TEL NUMBER(11),
		CONSTRAINT PR_ID_NAME PRIMARY KEY(ID_NO,ID_NAME)
		);
		INSERT INTO t_china_id_1(ID_NO) VALUES('1');  -- 主键字段ID_NAME为空报错
		INSERT INTO t_china_id_1(ID_NO,ID_NAME) VALUES('1','A');
		INSERT INTO t_china_id_1(ID_NO,ID_NAME) VALUES('1','B');
	

   （2）FOREIGN KEY （外部表要先建立主键,外键约束的字段值只能包含在外部表主键值中） 
		-- 父项表
		CREATE TABLE DEPT_1
		 (DEPTNO NUMBER(2,0), 
		  DNAME VARCHAR2(14), 
		  LOC VARCHAR2(13),
		  CONSTRAINT PK_DEPTNO_1 PRIMARY KEY (DEPTNO) 
		 );
		-- 子项表
		CREATE TABLE EMP_1(
		EMPNO NUMBER(4,0), 
		ENAME VARCHAR2(10), 
		DEPTNO NUMBER(2,0), 
		CONSTRAINT PK_EMPNO_1 PRIMARY KEY (EMPNO),
		CONSTRAINT FK_DEPTNO_1 FOREIGN KEY (DEPTNO) REFERENCES DEPT_1(DEPTNO)
		);
		
		INSERT INTO EMP_1(EMPNO,ENAME,DEPTNO) VALUES (1,'A',NULL);  -- 可以插入数据
		INSERT INTO EMP_1(EMPNO,ENAME,DEPTNO) VALUES (2,'B',10);    -- 报错,外部表主键没有10的值
		INSERT INTO DEPT_1(DEPTNO,DNAME,LOC) VALUES (10,'AA','BB');
		INSERT INTO EMP_1(EMPNO,ENAME,DEPTNO) VALUES (2,'B',10);    -- 可以插入数据
		DELETE FROM DEPT_1 WHERE DEPTNO=10;                         -- 报错,字表已经引用外部表10号部门的值
	
   （3）CHECK
		CREATE TABLE t_china_id_2 (
		ID_NO VARCHAR2(18) PRIMARY KEY,
		ID_NAME VARCHAR2(60),
		SEX VARCHAR2(4),
		TEL NUMBER(11),
		CONSTRAINT CK_SEX CHECK(SEX='男' OR SEX='女')
		);
		INSERT INTO t_china_id_2(id_no,sex) VALUES('1','');      -- 可以为空
		INSERT INTO t_china_id_2(id_no,sex) VALUES('2','未知');  -- 不能为检查约束外的值
		INSERT INTO t_china_id_2(id_no,sex) VALUES('3','男');
		
	
   （3）UNIQUE
		CREATE TABLE t_china_id_3 (
		ID_NO VARCHAR2(18) PRIMARY KEY,
		ID_NAME VARCHAR2(60),
		SEX VARCHAR2(4),
		TEL NUMBER(11), 
		CONSTRAINT UQ_TEL UNIQUE(TEL)
		);
		INSERT INTO t_china_id_3(id_no,tel) VALUES('1',NULL);      -- 可以为空
		INSERT INTO t_china_id_3(id_no,tel) VALUES('2',NULL);      -- 可以为空  
		INSERT INTO t_china_id_3(id_no,tel) VALUES('3',NULL);      -- 可以为空
	
   （4）NOT NULL
	
   （5）约束组合使用（主键不能和唯一约束组合）
		CREATE TABLE t_china_id_4 (
		ID_NO VARCHAR2(18) PRIMARY KEY CHECK(LENGTH(ID_NO)=18 AND SUBSTR(id_no,17,1) IN (1,2)),
		ID_NAME VARCHAR2(60)
		);
		
		INSERT INTO t_china_id_4(id_no,id_name)
		VALUES ('42187819190909751X','张三');
		INSERT INTO t_china_id_4(id_no,id_name)
		VALUES ('42187819190909752X','李四');
				
				
		-- ALTER TABLE命令添加约束
		ALTER TABLE 表名 ADD CONSTRAINT 约束名 PRIMARY KEY(列名1[,列名2...])
		ALTER TABLE 主表名 ADD CONSTRAINT 约束名 FOREIGN KEY(列名1[,列名2...]) REFERENCES 从表名(列名1[,列名2...])
		ALTER TABLE 表名 ADD CONSTRAINT 约束名 CHECK(条件)
		ALTER TABLE 表名 ADD CONSTRAINT 约束名 UNIQUE(列名) 
		ALTER TABLE 表名 MODIFY 列名 NOT NULL
		ALTER TABLE 表名 DROP CONSTRAINT 约束名	
				
				
		-- 有数据不满足约束的时候,不能创建约束		
		CREATE TABLE T_TEST_1 (
		SNO VARCHAR2(10),
		SNAME VARCHAR2(20)
		);
		INSERT INTO T_TEST_1(SNO, SNAME) VALUES ('1','张三');
		INSERT INTO T_TEST_1(SNO, SNAME) VALUES ('1','李四');
		ALTER TABLE T_TEST_1 ADD CONSTRAINT pk_t_test_1_sno PRIMARY KEY (SNO);	 -- 报错
	
	


		总结：-- 外键约束
			1.建表：
			  先建立父项表,再建立子项表
			2.插入数据：
			  先在父项表中插入外键约束字段中的数据,再在子项表中插入相关数据
			3.删除数据：
			  先删除子项表中外键约束字段中的数据,再删除父项表中的数据



练习：
1.建立2张表,学生表和课程表
2.学生表的学号为主键,课程表的课程号为主键
3.学生表的课程号建立外键,对应的为课程表的课程号（课程表的课程号为学生表的课程号的外键）
要求：建好表后通过语句添加主外键

	
	
	
	
	
	
	
	
	