

行列转换
	/*
	-- 适用场景介绍
	-- 数仓数据存储
	Y      Q      AMT
	2015   1      100
	2015   2      110
	2015   3      130
	2015   4      100
	2016   1      200
	2016   2      150
	2016   3      100
	2016   4      300
	-- 报表展示
	Y      Q1   Q2   Q3   Q4
	2015   100  110  130  100
	2016   200  150  100  300
	*/
	
	分析：
	SELECT T.Y,
	       CASE WHEN T.Q=1 THEN T.AMT END AS Q1,
	       CASE WHEN T.Q=2 THEN T.AMT END AS Q2,
	       CASE WHEN T.Q=3 THEN T.AMT END AS Q3,
	       CASE WHEN T.Q=4 THEN T.AMT END AS Q4
	  FROM T;
	
	练习：
	SELECT DEPTNO,
		   COUNT(EMPNO)
	  FROM EMP
	 GROUP BY DEPTNO;
   
	员工表人数统计：
	10号部门  20号部门  30号部门  50号部门  
		   3         5         6         1
	WITH T AS (
			  SELECT DEPTNO,
					 COUNT(EMPNO) AS CNT
				FROM EMP
			   GROUP BY DEPTNO)
	SELECT -- T.*, 查看所有数据
		   MAX(CASE WHEN t.deptno=10 THEN t.cnt ELSE 0 END) "10号部门",
		   MAX(CASE WHEN t.deptno=20 THEN t.cnt ELSE 0 END) "20号部门",
		   MAX(CASE WHEN t.deptno=30 THEN t.cnt ELSE 0 END) "30号部门"
	 FROM T;
	 
			  
-- 1.行转列
		有一张表S,记录了某公司每个季度的销售额,如下
		Y      Q      AMT
		2015   1      100
		2015   2      110
		2015   3      130
		2015   4      100
		2016   1      200
		2016   2      150
		2016   3      100
		2016   4      300

		Y      Q1   Q2   Q3   Q4
		2015   100  110  130  100
		2016   200  150  100  300
		  
		-- CASE WHEN
		SELECT A.Y,
			   SUM(CASE WHEN A.Q=1 THEN A.AMT END) AS Q1,
			   SUM(CASE WHEN A.Q=2 THEN A.AMT END) AS Q2,
			   SUM(CASE WHEN A.Q=3 THEN A.AMT END) AS Q3,
			   SUM(CASE WHEN A.Q=4 THEN A.AMT END) AS Q4
		  FROM T_Y_Q_AMT A 
		 GROUP BY A.Y;
	 
	 
	 
-- 2.列转行
		/*
		-- 将原表拆分4个季度的值,给上季度的标识,然后合并
		Y      Q1      Q_FLAG
		2015   100     1
		2016   200     1
		
		Y      Q2      Q_FLAG
		2015   110     2
		2016   150     2
		
		Y      Q3      Q_FLAG
		2015   130     3
		2016   100     3
		
		Y      Q4      Q_FLAG
		2015   100     4
		2016   300     4
		*/
		
		SELECT Y, 1 AS Q, Q1 AS AMT
		 FROM T_Y_Q_AMT_1 T1
		UNION
		SELECT Y, 2 AS Q, Q2 AS AMT
		 FROM T_Y_Q_AMT_1 T1
		UNION
		SELECT Y, 3 AS Q, Q3 AS AMT
		 FROM T_Y_Q_AMT_1 T1
		UNION
		SELECT Y, 4 AS Q, Q4 AS AMT
		 FROM T_Y_Q_AMT_1 T1;
		 
		 
		 
-- pivot和unpivot函数
		/*
		pivot函数：行转列函数
		　　语法：pivot(任一聚合函数(列) for 需要转的列的值所在列名 in (需转为列名的值))；
		unpivot函数：列转行函数
		　　语法：unpivot(新的列名1[多列中的值转为新增列中值] for 新的列名2[解释:多列的列名转为新增列中值] in (需转为行的列名))；
		执行原理：将pivot函数或unpivot函数接在查询结果集的后面。相当于对结果集进行处理。
		-- PIVOT 行转列
		SELECT *
		  FROM T_Y_Q_AMT PIVOT(SUM(AMT) FOR Q IN(1 AS Q1,
												 2 AS Q2,
												 3 AS Q3,
												 4 AS Q4));
		-- 逐行分析
		Y        Q1    Q2    Q3    Q4
		2015     100   110   130   100
		2016     200   150   100   300

		-- UNPIVOT 列转行
		SELECT *
		  FROM T_Y_Q_AMT_1 UNPIVOT(AMT FOR Q IN(Q1 AS 1,Q2 AS 2,Q3 AS 3,Q4 AS 4));

		*/  
		
		
		
		
总结：行转列: PIVOT   或者 MAX(CASE WHEN ...END)
	  列转行：UNPIVOT 或者 UNION ALL
	  
	  
	  

练习：按部门统计每种工作下面员工的工资总额（每种工作显示一列） 

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 