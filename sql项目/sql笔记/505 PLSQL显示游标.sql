

显示游标
	游标的类型有两种：隐式游标和显示游标。
	PL/SQL会为所有的SQL数据操作声明一个隐式的游标,包括只返回一条记录的查询操作。
	显示游标四个步骤：
	1.声明
	2.打开游标
	3.逐行获取数据
	4.关闭游标
		  
	语法结构：声明游标
	CURSOR 游标名[(参数1 数据类型[,参数2 数据类型...])]
	IS SELECT 语句;  --游标的声明
  
	语法结构：执行游标
	OPEN 游标名[(实际参数1[,实际参数2...])];  --打开游标
	FETCH 游标名 INTO 变量名1[,变量名2...];
	或
	FETCH 游标名 INTO 记录变量;  --提取数据
	CLOSE 游标名;  --关闭游标（千万别忘了！）
  
	游标属性：%FOUND、%NOTFOUND
	%FOUND:
	用于判断游标是否从结果集中提取数据。如果提取到数据,则返回值为TRUE,否则返回值为FALSE。
	%NOTFOUND:
	该属性与%FOUND相反,如果提取到数据则返回值为FALSE；如果没有,则返回值为TRUN。

  
	练习1：查询10号部门所有员工的姓名和工资并打印（PL/SQL）
	-- 隐式游标
	DECLARE
	  V_ENAME EMP.ENAME%TYPE;
	  V_SAL   EMP.SAL%TYPE;
	BEGIN
	  SELECT ENAME,SAL
		INTO V_ENAME,V_SAL    -- 多值无法插入
		FROM EMP
	   WHERE DEPTNO=10;
	  DBMS_OUTPUT.PUT_LINE(V_ENAME||V_SAL);
	END;
	
	
	-- 显式游标
	DECLARE
	  CURSOR C_EMP IS                   -- 先声明游标（放在declare中）
	  SELECT ENAME,SAL
		FROM EMP
	   WHERE DEPTNO=10;
	  V_EMP C_EMP%ROWTYPE;              -- 声明变量为游标行类型
	BEGIN
	  -- DBMS_OUTPUT.PUT_LINE(C_EMP);   -- 没法直接打印结果集(表的结果集)
	  OPEN C_EMP;                       -- 打开游标
	  LOOP                              -- 游标为结果集所以要有循环
		FETCH C_EMP INTO V_EMP;
		EXIT WHEN C_EMP%NOTFOUND;       -- 退出循环条件
		-- DBMS_OUTPUT.PUT_LINE(C_EMP); -- 没法直接打印结果集(单行的结果集)
		DBMS_OUTPUT.PUT_LINE(V_EMP.ENAME||' -- '||V_EMP.SAL);   -- 只能从变量中取字段
		-- EXIT WHEN C_EMP%NOTFOUND;        -- 放在最后打印结果会多出最后一行
	  END LOOP;
	  CLOSE C_EMP;
	END;
	
	
	--FOR循环
	DECLARE
	  CURSOR C_EMP IS
	  SELECT ENAME,SAL
		FROM EMP
	   WHERE DEPTNO=10; 
	BEGIN
	  FOR V_EMP IN C_EMP LOOP
		DBMS_OUTPUT.PUT_LINE('姓名: ' || V_EMP.ENAME || '工资: ' || V_EMP.SAL);
	  END LOOP;
	END;
	
	
	
	
	-- 游标参数
	例题1：打印某个部门的员工姓名和工资
	DECLARE
	  CURSOR C_EMP(P_DEPTNO EMP.DEPTNO%TYPE) IS   -- 游标参数
	  SELECT ENAME,SAL
		FROM EMP 
	   WHERE DEPTNO=P_DEPTNO;
	BEGIN
	  FOR V_EMP IN C_EMP(&部门号) LOOP    -- 键盘输入变量值（键盘输入值时,字符型要加单引号）/打开游标的时候传入
	  DBMS_OUTPUT.PUT_LINE('姓名: ' || V_EMP.ENAME || '工资: ' || V_EMP.SAL);
	  END LOOP;
	END;
	
	
	
	
	练习：
	1.用游标显示所有部门编号与名称,以及其所拥有的员工人数。
	DECLARE
      CURSOR C_EMP IS
      SELECT D.DEPTNO, D.DNAME, COUNT(DISTINCT EMPNO) AS CNT
      FROM EMP E
      RIGHT JOIN DEPT D
      ON E.DEPTNO = D.DEPTNO
      GROUP BY D.DEPTNO, D.DNAME;
    BEGIN
      FOR X IN C_EMP LOOP
      DBMS_OUTPUT.PUT_LINE(X.DEPTNO||' ' ||X.DNAME||' '||X.CNT);
      END LOOP;
    END;

	2.编写一个程序块,利用%type属性,接收一个雇员号,从emp表中显示该雇员的整体薪水(即,薪水加佣金)。

	DECLARE
		CURSOR C_A(P_EMPNO EMP.EMPNO%TYPE) IS
		SELECT DEPTNO, ENAME, JOB, SAL + NVL(COMM, 0) CHARGE
	FROM EMP
	WHERE EMP.EMPNO=P_EMPNO;
	BEGIN
		FOR V_E IN C_A(&工号) LOOP
		DBMS_OUTPUT.PUT_LINE(V_E.DEPTNO || '姓名:' || V_E.ENAME || ' 工作:' ||
					V_E.JOB || ' 薪水:' || V_E.CHARGE);
	END LOOP;
	END;


	
	
	
	
	
	