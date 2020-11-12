	
	
1.隐式游标
	对变量赋值还可以使用SELECT…INTO 语句从数据库中查询数据对变量进行赋值。
	但是查询的结果只能是一行记录,不能是零行或者多行记录。
	
	例题1：打印出emp中员工编号为7369的姓名和工资。  
	DECLARE
	  V_ENAME VARCHAR2(20);
	  V_SAL NUMBER(10,2);
	BEGIN
	  SELECT ENAME,SAL
		INTO V_ENAME,V_SAL          -- 隐士游标赋值（来源于表的查询结果,查询结果只能是单行）
		FROM EMP WHERE EMPNO=7369;
	  DBMS_OUTPUT.PUT_LINE('员工名称：'||V_ENAME||' 员工工资：'||V_SAL);    -- 不能直接打印表,只能是单行字段拼接后的字符串形式打印
	END;
	注意：使用select…into语句对变量赋值,要求查询的结果必须是一行,不能是多行或者没有记录。
	
	
	
	
2.引用数据类型
	%TYPE：   引用数据库中的某列的数据类型或某个变量的数据类型。
	%ROWTYPE：引用数据库中的一行（所有字段）作为数据类型。
	
	例题1：打印出emp中员工编号为7369的姓名和工资。
	-- %TYPE 引用表单个字段类型
	DECLARE
	  v_name emp.ename%TYPE;      -- 引用表的单个字段类型
	  v_sal  emp.sal%TYPE;
	BEGIN
	  SELECT ename, sal
		INTO v_name, v_sal
		FROM emp 
	   WHERE empno=7369;
	  dbms_output.put_line('姓名:' || v_name ||' 工资: ' ||v_sal);
	END;


	-- %ROWTYPE 引用表的所有字段类型
	DECLARE
	  v_emp emp%ROWTYPE;         -- 引用整个表的字段类型
	BEGIN
	  SELECT *
		INTO v_emp               -- 插入整行数据（所有字段数据）
		FROM emp 
	   WHERE empno=7369;
	  dbms_output.put_line('姓名:' || v_emp.ename ||' 工资: ' ||v_emp.sal);  -- 不能直接打印整个表,只能是单个值的拼接
	END;



	DECLARE
	  v_emp emp%ROWTYPE;           -- 引用整个表的字段类型
	BEGIN
	  SELECT ename, sal
		INTO v_emp.ename,v_emp.sal -- 只插入两个字段数据
		FROM emp 
	   WHERE empno=7369;
	  dbms_output.put_line('姓名:' || v_emp.ename ||' 工资: ' ||v_emp.sal);  -- 不能直接打印整个表,只能是单个值的拼接
	END;

	
	
	练习：1.计算192除以3后的余数并打印出来
		  2.打印员工7499的员工编号、工作职位和部门名称
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  