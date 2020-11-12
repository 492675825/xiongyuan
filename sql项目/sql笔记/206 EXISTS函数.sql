 EXISTS 函数
	EXISTS(查询结果集)：查询结果集有记录则成立,否则不成立
	NOT EXISTS(查询结果集)：与EXISTS相反
	-- 列出有员工的部门信息
	SELECT DISTINCT D.DNAME
	  FROM DEPT D
	  JOIN EMP E
		ON D.DEPTNO=E.DEPTNO;
		
	SELECT D.*
	  FROM DEPT D
	 WHERE DEPTNO IN (SELECT DEPTNO FROM EMP);
		
	-- EXISTS
	SELECT D.DNAME
	  FROM DEPT D
	 WHERE EXISTS (SELECT 1 FROM EMP E WHERE E.DEPTNO=D.DEPTNO);
	-- 空值和无结果集的区别
	SELECT D.DNAME
	  FROM DEPT D
	 WHERE EXISTS (SELECT NULL FROM DUAL);
	 
	 
一般子查询效率比较低, 可以用EXISTS函数等价改写！！
	 
		 
		 