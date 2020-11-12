

-- 连接查询（重点）
	包括内联接(inner join 1种)和外联接(outer join 3种) 
	（1）内连接(inner join)：inner可省略
		 内连接写法1（标准写法）
		 SELECT 
		   FROM 表名1
		   JOIN 表名2
			 ON 表名1.字段1=表名2.字段1     -- 等值连接
			AND 表名1.字段2>=表名2.字段2    -- 不等连接
			 OR ...;
			
			
		内连接写法2（非标准写法）
		SELECT
		  FROM 表名1,表名2
		 WHERE 表名1.字段1=表名2.字段1      -- 等值连接
		   AND 表名1.字段2>=表名2.字段2     -- 不等连接
			OR ...;
		   
		   
		   
		-- 查询员工信息及其部门信息
		SELECT *                     -- E.*,D.*  / DEPTNO -- 指向对象才行
		  FROM DEPT E 
		  JOIN EMP D                 -- 两张表调换顺序无关
			ON E.DEPTNO = D.DEPTNO;  -- 顺序无关 D.DEPTNO=E.DEPTNO
		-- oracle
		SELECT *
		  FROM EMP E, DEPT D
		 WHERE E.DEPTNO=D.DEPTNO;


		练习: 1.查询部门名称为'SALES'的员工编号、姓名、部门编号及其部门信息
			  2.查看7369员工的员工名称和部门名称
			
			
	  
	（2）左外连接(left outer join): outer可省略
		 left join 跟表的前后顺序有关
		 左外连接写法1（标准写法）
		 SELECT
		   FROM 表名1                     -- 主表    
		   LEFT JOIN 表名2                -- 从表
			 ON 表名1.字段1=表名2.字段1   -- 等值连接
		    AND 表名1.字段2>=表名2.字段2  -- 不等连接
			 OR ...;
	
	
		 左外连接写法2（非标准写法）
		 SELECT
		   FROM 表名1,表名2
		  WHERE 表名1.字段=表名2.字段(+);
		  
		  
		-- 查询部门名称为'SALES'部门的信息及其对应的员工信息
		SELECT *
		  FROM DEPT D             -- 主表信息全部展示（关联不上的也要展示）
		  LEFT JOIN EMP E         -- 从表只显示关联得上的信息
			ON D.DEPTNO=E.DEPTNO;
		 WHERE D.DNAME='SALES';   -- WHERE 是对关联后的结果集的过滤
		注意：	
		SELECT *
		  FROM DEPT D             -- 主表信息全部展示（关联不上的也要展示）
		  LEFT JOIN EMP E         -- 从表只显示关联得上的信息
			ON D.DEPTNO=E.DEPTNO
		   AND D.DNAME='SALES';   -- and 是限定关联的条件，不会过滤主表数据
		-- oracle	
		SELECT *
		  FROM DEPT D, EMP E
		 WHERE D.DEPTNO=E.DEPTNO(+)
		   AND D.DNAME='SALES'; 
		  
			
	（3）右外连接(right outer join): outer可省略
	（4）全外连接(full outer join): outer可省略
		-- FULL JOIN
		SELECT E.*,D.*
		  FROM EMP E
		  FULL JOIN DEPT D
			ON E.DEPTNO=D.DEPTNO;
	
		-- 错的
		SELECT E.*,D.*
		  FROM EMP E, DEPT D
		 WHERE E.DEPTNO(+)=D.DEPTNO(+); 
		 
	练习：1.查询各部门名称及其对应的人数
		  2.查询各部门名称及对应的经理名称
		  3.查询EMP表中每个部门的最低工资的员工信息
		  4.查询员工名称及其直接上级的名称
		  
		  
		  
		  
		  
		  
		  
		  
		 




