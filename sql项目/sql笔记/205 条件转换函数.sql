
条件转换函数（从前往后判断,满足前面条件,执行对应操作后退出）
	DECODE（列|值,判断值1,返回值1,判断值2,返回值2,...,默认值）  -- 默认值可以给可以不给,不给的话,默认为空
	CASE WHEN 条件1 THEN 返回值1 [WHEN 条件2 THEN 返回值2 ...] ELSE 默认值 END   -- 条件都不成立,没给else就为空
	
	区别：decode    只能对单个字段进行等值判断
		  case when 可以对多个字段进行任意条件判断
		  

-- 1.DECODE
    -- 对值
	SELECT DECODE(12,         -- 原始值
				   1, 2, 
				  12, 10),    -- 10
		   DECODE(12, 
				   1, 2, 
				  13, 10),    -- 空
		   DECODE(12, 
				   1, 2, 
				  13, 10, 
				   7),        -- 给定默认值7
		   DECODE(12, 
				   1, 2, 
				  12, 10,     -- 找到后就返回值,然后退出,不会向下找
				  12, 88,
				   7)         -- 给定默认值7
		FROM DUAL;
		
    -- DECODE对列（对EMP表中的奖金为空的转换为100,不为空的转换为88）
	SELECT comm,
		   DECODE(comm, 
				  NULL, 100, 
				  88)
	  FROM emp;
	  
	
	练习：查看各部门名称（中文）,以及部门对应人数。
	ACCOUNTING   会计部
	RESEARCH     研究部
	SALES        销售部
	OPERATIONS   操作部
	 SELECT DECODE(DNAME,
				   'ACCOUNTING','会计部',
				   'RESEARCH','市场调查部',
				   'SALES','销售部',
				   'OPERATIONS','操作部'
				   ) AS 部门名称,
			COUNT(E.EMPNO) AS 部门人数
	   FROM DEPT D
	   LEFT JOIN EMP E
		 ON E.DEPTNO = D.DEPTNO
	  GROUP BY D.DNAME;
	
	
-- 2.CASE WHEN(对EMP表中的奖金为空的转换为100,不为空的转换为88)
	SELECT COMM,
		   (CASE WHEN COMM IS NULL THEN 100
				 ELSE 88
			 END) AS COMM_1
	  FROM EMP;
	-- 部门转换
	SELECT DEPT.*,
		   (CASE
			 WHEN DNAME = 'ACCOUNTING' THEN '会计部'
			 WHEN DNAME = 'RESEARCH' THEN '研究部'
			 WHEN DNAME = 'SALES' THEN '销售部'
			 ELSE '操作部'
		   END) AS 部门
	  FROM DEPT;
	

	例题：统计员工表中各部门的员工人数,10号部门不将经理计算在内
	SELECT deptno,
		   COUNT(CASE WHEN deptno=10 AND job='MANAGER' THEN NULL
					ELSE empno
				END) AS cnt
	  FROM emp
	 GROUP BY deptno;
	  
	SELECT DEPTNO, COUNT(EMPNO)
	 FROM EMP
	WHERE DEPTNO <> 10                         -- 排除10号部门
	   OR (DEPTNO = 10 AND JOB <> 'MANAGER')   -- 10号中排除经理
	GROUP BY DEPTNO;


	SELECT DEPTNO, COUNT(EMPNO)
	 FROM EMP
	WHERE NOT (DEPTNO = 10 AND JOB = 'MANAGER')
	GROUP BY DEPTNO;
	
	
	SELECT DEPTNO, COUNT(EMPNO)
	  FROM EMP
	 WHERE empno NOT IN (SELECT empno FROM emp WHERE DEPTNO = 10 AND JOB = 'MANAGER')
	 GROUP BY DEPTNO;
	
	
		  
	  
	  
	练习：1.对员工表的job类型进行转换,CLERK -> 职员, SALESMAN -> 销售员, PRESIDENT -> 总裁, MANAGER -> 经理, ANALYST ->分析师;
		  2.对员工表的薪资打标, 小于1500为'低薪',大于等于1500并且小于等于2500为'中薪', 其它为'高薪';
		  3.更新数据：job为'CLERK' 转为'职员',将其工资增加10%, 
						   'SALESMAN' 转为'销售员',将其工资增加5%, 
						   'MANAGER' 转为'经理',将其工资增加2000, 
						   'ANALYST' 转为'分析师',将其工资增加6%,
						   'PRESIDENT' 转为'老板',其工资不变;
		  4.计算每个部门发放的总工资,总裁不考虑在内

			
			
			
			
			
			
			
			