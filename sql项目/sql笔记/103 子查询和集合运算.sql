

-- 1.子查询
	子查询在SELECT、UPDATE、DELETE语句内部可以出现SELECT语句。
	1.单行子查询：不向外部返回结果,或者只返回一行结果。
	2.多行子查询：向外部返回零行、一行或者多行结果。
	-- 单行查询和多行查询
	SELECT * FROM EMP WHERE EMPNO=7369;  -- 单行
	SELECT * FROM EMP WHERE DEPTNO=10;   -- 多行
	
	-- 单行子查询
	SELECT * FROM EMP WHERE SAL = (SELECT SAL FROM EMP WHERE EMPNO=7369);     -- 单行结果"=",并且字段要对应
	-- 多行子查询
	SELECT * FROM EMP WHERE SAL IN (SELECT SAL FROM EMP WHERE DEPTNO=10) AND DEPTNO <> 10;   -- 单行结果"IN",并且字段要对应
	
	-- 查询EMP表中每个部门的最低工资的员工信息（尝试练习）
	SELECT * FROM EMP WHERE (deptno,sal) IN (SELECT deptno, MIN(sal) AS min_sal FROM EMP GROUP BY deptno);  -- 可以多列对应
	  
	
	练习：查询出dept表中销售部（SALES）下面的员工姓名、工作、工资。（子查询）
	
	
    

-- 2.集合运算(a={1,2,3} , b={2,3,4})
	交集：INTERSECT              -- 两者共有部分
	并集（去重）：  UNION        
	并集（不去重）：UNION ALL    
	补集：MINUS                  -- 前者有后者无
	当使用集合操作的时候,要注意：
	1.查询所返回的列数以及列的类型必须匹配,列名可以不同。
	2.只有UNION ALL不会去重。其他三个都需要排序后去重,性能比较差
	
	
	例题：
	1.求员工表和部门表中的共有的部门编号
	SELECT DEPTNO
	  FROM EMP
	INTERSECT
	SELECT DEPTNO
	  FROM DEPT;
	  
	2.求员工表或者部门表中所包含的部门编号（不去重）
	SELECT DEPTNO
	  FROM EMP
	 UNION ALL 
	SELECT DEPTNO
	  FROM DEPT;
	
	3.求员工表或者部门表中所包含的部门编号（去重）
	SELECT DEPTNO
	  FROM EMP
	 UNION
	SELECT DEPTNO
	  FROM DEPT;
	
	4.求部门表中不在员工表中的部门编号
	SELECT DEPTNO
	  FROM DEPT
	 MINUS
	SELECT DEPTNO
	  FROM EMP;
	-- 
	SELECT deptno 
	  FROM EMP
	MINUS
	SELECT deptno
	  FROM DEPT;
  


-- 3.去重（DISTINCT, GROUP BY, UNION, ROWID）
	-- 查看部门编号（去重）
	SELECT DISTINCT DEPTNO FROM EMP;
	SELECT deptno FROM emp GROUP BY deptno;
	-- DISTINCT 只能出现在最前,不能一个字段去重一个字段不去重
	-- 错误1
	SELECT JOB,
		   DISTINCT DEPTNO
	  FROM EMP;
	-- 错误2
	SELECT DISTINCT JOB,
		   DISTINCT DEPTNO
	  FROM EMP;
	  
	  
    -- 三种等价去重
	-- 性能最好
	SELECT deptno,job
	  FROM emp
	 GROUP BY deptno,job;
	-- 性能其次
	SELECT DISTINCT deptno,job
	  FROM emp;
	-- 性能很差
	SELECT deptno,job
	  FROM emp
	UNION
	SELECT deptno,job
	  FROM emp;



	
	
	
	
	
	
	
	
	
	
	