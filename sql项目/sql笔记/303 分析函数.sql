
分析函数（重点）
	它可以在数据中进行分组然后计算基于组的某种统计值,并且每一组的每一行都可以返回一个统计值
	-- 分组聚合
	SELECT DEPTNO,
		   COUNT(EMPNO)
	  FROM EMP
	 GROUP BY DEPTNO;
	按照每个部门的工资从低到高排序,计算每个部门的累计工资？
	按照每个部门的工资从低到高排序,给出各部门工资的序号？
	
	
	
	
	语法格式：分析函数语法（<> 内的内容可以选择性省略)
	FUNCTION_NAME(<参数>,…) OVER (<PARTITION BY 表达式,…> <ORDER BY 表达式 <ASC DESC> )
	
	

-- 1.函数为聚合函数（AVG,SUM,COUNT)
	1.FUNCTION_NAME(<参数>,…) OVER (PARTITION BY 表达式,… )         -- 分组求值
	2.FUNCTION_NAME(<参数>,…) OVER (ORDER BY 表达式 <ASC DESC> )    -- 整体数据未做分组,先排序,在求累计求值
	3.FUNCTION_NAME(<参数>,…) OVER (PARTITION BY 表达式,… ORDER BY 表达式 <ASC DESC> ) -- 先分组,按组内排序,对组内求累计求值
	
	
	-- PARTITION BY   1.查看员工表中员工信息以及对应部门的总人数
	/*
	SELECT * FROM EMP;
	SELECT DEPTNO, COUNT(1) FROM EMP GROUP BY DEPTNO;

	SELECT E.*, T.CNT
	  FROM EMP E
	  JOIN (SELECT DEPTNO, COUNT(1) AS CNT FROM EMP GROUP BY DEPTNO) T
		ON E.DEPTNO = T.DEPTNO;
	*/
	SELECT E.*,
		   COUNT(EMPNO) OVER (PARTITION BY DEPTNO) AS CNT
	  FROM EMP E;
	
	-- ORDER BY       2.对员工表的工资从低到高排序,求累计应发放薪资
	SELECT E.*,
		   SUM(SAL) OVER (ORDER BY SAL)
	  FROM EMP E;
	区别
	SELECT E.*,
		   SUM(SAL) OVER (ORDER BY SAL,EMPNO)
	  FROM EMP E;
	  
	-- PARTITION BY + ORDER BY   3.按照每个部门的工资从高到低排序,计算每个部门的累计工资
	SELECT E.*,
		   SUM(SAL) OVER (PARTITION BY DEPTNO ORDER BY SAL DESC)
	  FROM EMP E;
	
	SELECT E.*,
		   SUM(SAL) OVER (PARTITION BY DEPTNO ORDER BY SAL,EMPNO)
	  FROM EMP E;
	  
	
	练习：    
	每日生产量      T_A
	data_date       daily_out
	2019-07-10      120
	2019-07-11      100
	2019-07-12      150
	求每日累计产量
	data_date       daily_out   sum_daily_out
	2019-07-10      120         120
	2019-07-11      100         220
	2019-07-12      150         370
	/*
	CREATE TABLE T_A (
	data_date date,
	daily_out  number);
	INSERT INTO T_A(data_date,daily_out) VALUES (DATE'2019-07-10', 120);
	INSERT INTO T_A(data_date,daily_out) VALUES (DATE'2019-07-11', 100);
	INSERT INTO T_A(data_date,daily_out) VALUES (DATE'2019-07-12', 150);
	COMMIT;
	*/
	

	
	
-- 2.函数为排序函数（ROW_NUMBER(),RANK(),DENSE_RANK())情况下：
	①ROW_NUMBER： 
	ROW_NUMBER函数返回一个唯一的值,当碰到相同数据时,排名按照记录集中记录的顺序依次递增。 
	②RANK： 
	RANK函数返回一个唯一的值,当碰到相同的数据时,此时所有相同数据的排名是一样的,
	同时会在最后一条相同记录和下一条不同记录的排名之间空出排名。
	③DENSE_RANK： 
	DENSE_RANK函数返回一个唯一的值,当碰到相同数据时,此时所有相同数据的排名都是一样的。 
	同时会在最后一条相同记录和下一条不同记录的排名之间不空出排名。
	
	2.FUNCTION_NAME() OVER (ORDER BY 表达式 <ASC DESC> )                       -- 整体数据未做分组,按ORDER BY 的字段排名
	3.FUNCTION_NAME() OVER (PARTITION BY 表达式,… ORDER BY 表达式 <ASC DESC> ) -- 先分组,按组内排序,对组内进行排名
	
	-- ORDER BY   2.将emp表按工资从高到低排序,并给出排名（排名不并列）
	SELECT E.*,
		   ROW_NUMBER() OVER (ORDER BY SAL DESC)
	  FROM EMP E;
		
	-- PARTITION BY + ORDER BY   3.按照员工部门分组, 给出工资从高到低的排名（排名不并列）
	SELECT E.*,
		   ROW_NUMBER() OVER (PARTITION BY DEPTNO ORDER BY SAL DESC)
	  FROM EMP E;
		  
	
	例子：找出员工表每个部门的一条员工信息（分析函数）
	SELECT * 
	  FROM ( 
		  SELECT E.*,
				 ROW_NUMBER() OVER(PARTITION BY DEPTNO ORDER BY EMPNO) AS RN
			FROM EMP E
		  ) T
	WHERE T.RN = 1;
	

	
练习：找每个部门工资最低(最高)的员工信息


		
		
-- 3.函数为位移函数（LEAD(列,参数), LAG(列,参数) 
	SELECT E.*,
		   LAG(E.SAL,1) OVER(ORDER BY E.SAL) AS 工资下移一位,
		   LEAD(E.SAL,1) OVER(ORDER BY E.SAL) AS 工资上移一位
	  FROM EMP E;
	  


练习：员工表按入职先后排序, 求出每两个员工的入职时间差
SELECT E.*,
	   LAG(HIREDATE,1) OVER (ORDER BY HIREDATE) AS 下移,
	   LEAD(HIREDATE,1) OVER (ORDER BY HIREDATE) AS 上移,
	   LEAD(HIREDATE,1) OVER (ORDER BY HIREDATE) - HIREDATE AS 入职时间差
  FROM EMP E;  
	  
		  
		  
		  

		
		
		
		
		
		
		
		
		
		
		
		
		
		