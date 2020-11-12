伪列
	ROWID  插入数据的时候生成,记录的是该行的物理地址(用作去重)
	ROWNUM 查询数据的时候生成,返回的是序号(用作分页)
	
	SELECT E.*, E.ROWID, ROWNUM  -- ROWNUM是变化的值,不能指定到某个表
	  FROM EMP E;
	SELECT E.ROWID,D.ROWID,ROWNUM, E.*,D.*
	  FROM EMP E
	  JOIN DEPT D
		ON E.DEPTNO=D.DEPTNO;  

-- 1.ROWNUM 查询只能是小于或小于等于某个值（不能直接等于或者大于或者不是从1开始的某个区间段）
	SELECT E.*,ROWID, ROWNUM
	  FROM EMP E
	 WHERE ROWNUM<=10;
	抽取排在第7到第10行的数据
	-- 1.补集
	SELECT E.*, ROWNUM
	  FROM EMP E
	 WHERE ROWNUM <= 10
	MINUS
	SELECT E.*, ROWNUM
	  FROM EMP E
	 WHERE ROWNUM <= 6;
	-- 2.子查询
	SELECT t.*
	  FROM (
			SELECT E.*, ROWNUM AS rn    -- rownum 一定要用到别名,后面才能过滤
			  FROM EMP E
			 WHERE ROWNUM <= 10) t
	 WHERE t.rn>=7;
 
 
-- 2.ROWID
	删除重复数据,相同数据只保留一条
	DELETE FROM 表名 别名
	 WHERE ROWID NOT IN (SELECT MIN(ROWID) FROM 表名 别名 GROUP BY 列名);
	 
	-- 查看表中某些字段是否有重复数据
	SELECT DEPTNO
	  FROM EMP
	 GROUP BY DEPTNO
	 HAVING COUNT(DEPTNO)>1;
	 
	-- 从员工表找出所有部门编号（字段值进行分组找该字段每一组的一个值）
	SELECT DISTINCT DEPTNO
	  FROM EMP;
	SELECT DEPTNO
	  FROM EMP
	 GROUP BY DEPTNO;
	 
    -- 每个部门查询一条员工信息
	SELECT *
	FROM EMP
	WHERE empno IN (SELECT MIN(empno) FROM EMP GROUP BY DEPTNO);
  
	SELECT *
	  FROM EMP
	 WHERE ROWID IN (SELECT MIN(ROWID) FROM EMP GROUP BY DEPTNO);
  
	-- 每个部门只保留一条员工信息
	DELETE FROM emp e
	WHERE ROWID NOT IN (SELECT MIN(ROWID) FROM EMP GROUP BY DEPTNO);
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 