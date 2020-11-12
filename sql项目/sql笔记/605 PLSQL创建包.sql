

创建包
	包就是把相关的存储过程、函数、变量、常量和游标等PL/SQL程序组合在一起,
	并赋予一定的管理功能的程序块。
	一个程序包由两部分组成：包定义和包体。
	其中包定义部分声明包内数据类型、变量、常量、游标、子程序和函数等元素,
	这些元素为包的共有元素。包主体则定义了包定义部分的具体实现。
	注意：包声明的对象不一定要在包体中去使用,但是包体中的对象一定要在包声明中定义并保持一致。

	语法格式：创建包头
	CREATE [OR REPLACE] PACKAGE 包名
	IS|AS
		变量、常量及数据类型定义;
		游标定义头部;
		函数、过程的定义和参数列表以及返回类型;
	END [包名];

	语法格式：创建包体
	CREATE [OR REPLACE] PACKAGE BODY 包名
	IS|AS
		PROCEDURE 过程名(参数)
		IS|AS
		BEGIN
		过程体;
		END [过程名];
		FUNCTION 函数名(参数) RETURN 类型
		IS|AS
		BEGIN
		函数体;
		END [函数名];
	END;

		
	例题1：创建一个包, 包中含有存储过程和函数
	CREATE OR REPLACE PACKAGE PK_MYPACKAGE
	IS
	  A NUMBER;                                  -- 声明变量（声明的对象不一定要在包体中使用）
	  PROCEDURE MY_SP(P_EMPNO IN NUMBER);        -- 声明存储过程
	  FUNCTION MY_FUN(P_NUM1 IN NUMBER , P_NUM2 IN NUMBER) RETURN NUMBER; -- 声明函数
	END;


	CREATE OR REPLACE PACKAGE BODY PK_MYPACKAGE
	IS
	  -- 通过员工号找员工姓名和工资存储过程
	  PROCEDURE MY_SP(P_EMPNO IN NUMBER)    -- 和包中的声明要对应（并且一定要先声明）
	  IS
	  V_ENAME EMP.ENAME%TYPE;
	  V_SAL   EMP.SAL%TYPE;
	  BEGIN
		SELECT ENAME, SAL INTO V_ENAME, V_SAL FROM EMP WHERE EMPNO=P_EMPNO;
		DBMS_OUTPUT.PUT_LINE('姓名：'|| V_ENAME ||'工资：'|| V_SAL);
		EXCEPTION 
		  WHEN NO_DATA_FOUND THEN
			  DBMS_OUTPUT.PUT_LINE('SELECT INTO语句中没有返回任何记录!'); 
		  WHEN TOO_MANY_ROWS THEN 
			  DBMS_OUTPUT.PUT_LINE('SELECT INTO语句中返回多于1条记录!');
	  END;
	  -- 比较大小函数
	  FUNCTION MY_FUN(P_NUM1 IN NUMBER , P_NUM2 IN NUMBER)
	  RETURN NUMBER
	  IS
	  BEGIN 
		IF P_NUM1>P_NUM2 THEN 
		  RETURN P_NUM1;
		ELSE 
		  RETURN P_NUM2; 
		END IF;
	  END;
	END;
		
		
	-- 用户下面的表
	SELECT * FROM USER_TABLES;
	-- 用户下面的过程体
	SELECT * FROM USER_PROCEDURES WHERE OBJECT_TYPE ='PACKAGE'  ;
	SELECT * FROM USER_PROCEDURES WHERE OBJECT_TYPE ='FUNCTION' ;
	SELECT * FROM USER_PROCEDURES WHERE OBJECT_TYPE ='PROCEDURE';
	-- 调用存储过程
	BEGIN
	  PK_MYPACKAGE.MY_SP(&员工编号);
	END;
	-- 调用函数
	SELECT PK_MYPACKAGE.MY_FUN(10,20) FROM DUAL;
	
	
	
	
	
	
	
	
	
	
	
	
	
	