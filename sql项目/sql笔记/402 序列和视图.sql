
1.序列
	序列(Sequence)是用来生成连续的整数数据的对象。-- 一般当做主键（像订单明细中）
	创建序列
	CREATE SEQUENCE sequence_name
	[START WITH num]             -- 从某一个整数开始,升序默认值是1,降序默认值是-1
	[INCREMENT BY increment]     -- 增长数
	[MAXVALUE num|NOMAXVALUE]    -- 最大值
	[MINVALUE num|NOMINVALUE]    -- 最小值
	[CYCLE|NOCYCLE]              -- 表示如果升序达到最大值后,从最小值重新开始；如果是降序序列,达到最小值后,从最大值重新开始
	[CACHE num|NOCACHE]          -- 预先在内存中生成序列号/不预先在内存中生成序列号
	-- 最简单创建
	CREATE SEQUENCE s_1;
	
	序列使用
	--访问下一个值（初始创建后要先定义）
	SELECT s_1.NEXTVAL FROM DUAL; 
	--访问当前值
	SELECT s_1.CURRVAL FROM DUAL; 

	-- 生成序列号
	CREATE SEQUENCE s_2
	START WITH 2
	MINVALUE 1
	MAXVALUE 10
	INCREMENT BY 2
	CYCLE 
	CACHE 2

	序列修改和删除
	--序列修改
	ALTER SEQUENCE s_1
	MAXVALUE 10000
	MINVALUE -300
	--删除序列
	DROP SEQUENCE s_1; 
	
	
	举例：		
	CREATE TABLE T_S_INFO(SNO NUMBER,SNAME VARCHAR(20));
	ALTER TABLE T_S_INFO ADD CONSTRAINT pk_sno PRIMARY KEY(sno);
	CREATE SEQUENCE S_INFO;
		
	INSERT INTO T_S_INFO(SNO,SNAME) VALUES(S_INFO.NEXTVAL,'张三');
	
	INSERT INTO T_S_INFO(SNO,SNAME) 
	SELECT S_INFO.NEXTVAL,'李四'
	  FROM dual;
	
	SELECT * FROM T_S_INFO;
	  
	
		

2.视图 -- 1.关键字段可以隐藏 2.根据基表实时更新 3.不占用空间 4.可以处理复杂的表关联
	视图（View）实际上是一张或者多张表上的预定义查询,这些表称为基表。
	从视图中查询信息与从表中查询信息的方法完全相同。只需要简单的SELECT…FROM即可。
	创建视图
	CREATE [OR REPLACE] [{FORCE|NOFORCE}] VIEW view_name
	AS
	SELECT查询
	[WITH READ ONLY] 

	视图
	--创建视图
	CREATE OR REPLACE VIEW v_emp_dept
	AS
	SELECT E.EMPNO, E.ENAME, E.JOB, E.HIREDATE, E.DEPTNO, D.DNAME
	  FROM EMP E
	  JOIN DEPT D
	  ON E.DEPTNO = D.DEPTNO
	WITH READ ONLY

	--更改基础表
	DELETE FROM emp WHERE empno<>7369

	--通过视图查询
	SELECT * FROM v_emp_dept;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	