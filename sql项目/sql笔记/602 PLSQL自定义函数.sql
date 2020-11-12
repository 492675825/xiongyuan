

自定义函数
	语法格式：创建函数
	CREATE [OR REPLACE] FUNCTION 函数名(参数 参数类型[IN|OUT|IN OUT] 数据类型,……)
    RETURN 返回的数据类型   -- 不带数据类型长度
    IS|AS
    PL/SQL函数体;           -- 里面必须要有一个RETURN子句
  
	
	-- 不带参数情况
	CREATE OR REPLACE FUNCTION FUN_TEST
	RETURN NUMBER    -- 函数的返回类型
	IS
	BEGIN
		RETURN 100;
	END;
	
	SELECT FUN_TEST FROM DUAL;
			
	
	-- 传入两个参数,返回最大值
	CREATE OR REPLACE FUNCTION FUN_MAX (P_NUM1 IN NUMBER, P_NUM2 IN NUMBER DEFAULT 99)
	RETURN NUMBER    -- 函数的返回类型
	IS
	BEGIN
		IF P_NUM1>P_NUM2 THEN 
			RETURN P_NUM1;	
		ELSE 
			RETURN P_NUM2; 
		END IF;
	END;
	
	调用：
	SELECT FUN_MAX(12,20) FROM DUAL;
	SELECT EMP.*,FUN_MAX(COMM,SAL) FROM emp;
	SELECT FUN_MAX(20) FROM DUAL;
	如果P_NUM1给了默认值,调用可以为：
	SELECT FUN_MAX(P_NUM2=>20) FROM DUAL;
	或者
	BEGIN
	  dbms_output.put_line(FUN_MAX(12,20));
	END;
	或者
	DECLARE
	  v_num NUMBER;
	BEGIN
	  v_num := FUN_MAX(12,20);
	  dbms_output.put_line(v_num);
	END;
	
	
	
	-- 函数返回类型为游标(对应报表接口)
	-- 传入部门编号,返回整个部门的员工信息（函数）
	CREATE OR REPLACE FUNCTION FUN_REF(P_DEPTNO EMP.DEPTNO%TYPE)
	  RETURN SYS_REFCURSOR IS
	  C_EMP SYS_REFCURSOR;
	BEGIN
	  OPEN C_EMP FOR
		SELECT * FROM EMP WHERE DEPTNO = P_DEPTNO;
	  RETURN C_EMP;
	END FUN_REF;

	
	
	
	练习：1.输入2个整数,返回最小到最大数之间的连乘的结果（两个整数在1到20之间）;
	-----------------------------------------------------------------------------------
	CREATE OR REPLACE FUNCTION F_PLUS(N1 INT, N2 INT) 
	RETURN VARCHAR2 
	IS
  		MULTI_RE NUMBER(20) := 1;
	BEGIN
	IF (1 <= N1 AND N1 <= 20) AND (1 <= N2 AND N2 <= 20) THEN
		IF N1 < N2 THEN
		FOR I IN N1 .. N2 LOOP
			MULTI_RE := MULTI_RE * I;
		END LOOP;
		RETURN MULTI_RE;
		ELSIF N1 = N2 THEN
		MULTI_RE := N1 * N2;
		RETURN MULTI_RE;
		ELSE
		FOR I IN N2 .. N1 LOOP
			MULTI_RE := MULTI_RE * I;
		END LOOP;
		RETURN MULTI_RE;
		END IF;
	ELSE
		RETURN '请重新输入';
	END IF;
	END;


	-----------------------------------------------------------------------------------	
	2.输入3个整数,取中位数。
	CREATE OR REPLACE FUNCTION FUN_L (P_NUM1 IN NUMBER, P_NUM2 IN NUMBER, P_NUM3 IN NUMBER DEFAULT 99)
	RETURN NUMBER
	IS
	BEGIN
  		IF P_NUM2>=P_NUM1 AND P_NUM1>=P_NUM3 OR P_NUM2<=P_NUM1 AND P_NUM1<=P_NUM3 THEN
			RETURN P_NUM1;
		ELSIF P_NUM1>=P_NUM2 AND P_NUM2>=P_NUM3 OR P_NUM1<=P_NUM2 AND P_NUM2<=P_NUM3 THEN
			RETURN P_NUM2;
		ELSIF P_NUM1>=P_NUM3 AND P_NUM3>=P_NUM2 OR P_NUM1<=P_NUM3 AND P_NUM3<=P_NUM2 THEN
 			RETURN P_NUM3;
  		END IF;
	END;

		
	
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
