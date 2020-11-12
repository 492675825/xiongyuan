

创建存储过程
	为什么需要创建存储过程？
	(1)封装代码,执行复杂的逻辑
	(2)先编译后执行,第一次编译成功后,之后调用,其效率要比单独运行sql语句要高
	(3)存储过程是一个完整的事物,整体的代码要么全部成功要么全部失败
	存储过程在工作中的实际应用？
	(1)处理多张表关联的逻辑,并将最终的结果集数据写入到目标表
	(2)同一种数据库,可以做跨库数据同步,增量(MERGE INTO ...)或全量
	语法格式：创建存储过程
	CREATE [OR REPLACE] PROCEDURE 过程名(参数1 [IN|OUT|IN OUT] 数据类型,参数2 [IN|OUT|IN OUT] 数据类型……)
	IS|AS
	PL/SQL过程体;
	
	三种参数：传入(in或省去),传出(out),传入或传出(in out)

	注意: 1.数据类型不要带字符长度也不用括号 varchar2/number/date
		  2.如果存储过程不带参数,过程名后不用括号,IS|AS 后可以直接跟声明内容,不要declare
		  3.为in的参数,不能在过程中被赋值,只能作为调用传入值
		  4.省去参数类型则默认为IN传入
		  5.IN OUT 参数必需在声明时候赋初值,调用中用变量名

	语法格式：调用存储过程
	BEGIN
	  过程名[(参数)];
	END;
	
	-- 1.不带参数		
	例题1：打印emp表中所有雇员的姓名,工作和薪水。
	CREATE OR REPLACE PROCEDURE SP_EMP1
	IS
	  CURSOR C_EMP_DEPTNO IS
	  SELECT ENAME, JOB, SAL FROM EMP;  
	BEGIN
	  FOR V_EMP_DEPTNO IN C_EMP_DEPTNO LOOP
		  DBMS_OUTPUT.PUT_LINE('姓名：' || V_EMP_DEPTNO.ENAME ||
							   '工作：' || V_EMP_DEPTNO.JOB || 
							   '工资：' || V_EMP_DEPTNO.SAL);
	  END LOOP;
	END;
	
	-- 调用
	BEGIN
	  SP_EMP1;  -- 也可写成SP_EMP1();
	END;

	-- 2.只带传入参数
	例题2：接收一个部门号（带参数，可以手动输入要选择的部门）,显示该部门的所有雇员的姓名,工作和薪水。

	CREATE OR REPLACE PROCEDURE SP_EMP2 (P_DEPTNO IN EMP.DEPTNO%TYPE DEFAULT 20)  -- 给默认值
	IS
	  -- 游标
	  CURSOR C_EMP IS
	  SELECT ENAME,JOB,SAL FROM EMP WHERE DEPTNO=P_DEPTNO;
	BEGIN
		FOR V_EMP IN C_EMP LOOP
		  DBMS_OUTPUT.PUT_LINE(' 姓名:'|| V_EMP.ENAME ||' 工作:' || V_EMP.JOB || ' 薪水:' || V_EMP.SAL);
	  END LOOP;
	END;

	
	-- 调用
	BEGIN
	  SP_EMP2(10);
	  -- SP_EMP2(&部门编号);
	END;
	或者    
	DECLARE
	  V_DEPTNO EMP.DEPTNO%TYPE :=10;
	BEGIN
	  SP_EMP2 (V_DEPTNO);
	END;
	或者 
	BEGIN
	  SP_EMP2(P_DEPTNO => 10);  -- 参数定向调用（多个参数可以改变顺序）
	END;



	-- 3.带传入和传出参数
	例题3：查询某个部门中的某个职位员工的姓名、工资、入职日期。（只考虑单行情况）
	CREATE OR REPLACE PROCEDURE SP_EMP3(P_DEPTNO   IN EMP.DEPTNO%TYPE,    -- 传入,不可被赋值,看作常量
										P_JOB      IN EMP.JOB%TYPE,       -- 传入
										P_ENAME    OUT EMP.ENAME%TYPE,    -- 传出,可被赋值,看作变量
										P_SAL      OUT EMP.SAL%TYPE,      -- 传出
										P_HIREDATE OUT EMP.HIREDATE%TYPE) -- 传出
	 IS
	BEGIN
	  SELECT ENAME, SAL, HIREDATE
		INTO P_ENAME, P_SAL, P_HIREDATE
		FROM EMP
	   WHERE DEPTNO = P_DEPTNO
		 AND JOB = P_JOB;
	END;
	
	-- 调用
	DECLARE
	  v_ename    emp.ename%TYPE;
	  v_sal      emp.sal%TYPE;
	  v_hiredate emp.hiredate%TYPE;
	BEGIN
	  SP_EMP3(20,'MANAGER',v_ename,v_sal,v_hiredate);
	  DBMS_OUTPUT.PUT_LINE(' 姓名:' || v_ename ||
						   ' 工资:' || v_sal || 
						   ' 入职日期:' || v_hiredate);
	  -- 单行的值打印可以防止调用中,如果多行值,打印防止调用中只会显示最后一条被替换的值
	END;


	-- 4.参数中含IN OUT 类型
	CREATE OR REPLACE PROCEDURE SP_EMP4(P_DEPTNO    IN  NUMBER,
										P_HIREDATE  OUT DATE,
										P_SAL       OUT NUMBER,
										P_JOB_ENAME IN OUT VARCHAR2)
										----------参数不能定义长度
										----------OUT可以被赋值的参数,理解为PLSQL块中的变量
	IS                                   
	BEGIN
	  SELECT E.ENAME, E.SAL, E.HIREDATE
		INTO P_JOB_ENAME, P_SAL, P_HIREDATE  -- P_JOB_ENAME 当OUT参数 传出ENAME
		FROM EMP E
	   WHERE E.DEPTNO = P_DEPTNO             -- P_DEPTNO IN 参数只能传入值,不能被赋值
		 AND E.JOB = P_JOB_ENAME;            -- P_JOB_ENAME 当IN参数  传入JOB
	  EXCEPTION   -- 异常处理
		  WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('没找到任何结果');
	END;


	--调用存储过程
	DECLARE
	  V_HIREDATE DATE;                                -- OUT 参数
	  V_SAL NUMBER;                                   -- OUT 参数
	  V_JOB_ENAME VARCHAR2(100) :='MANAGER';          -- IN OUT 参数此处先声明并赋值
	BEGIN
	  SP_EMP4(10, V_HIREDATE, V_SAL, V_JOB_ENAME);    -- 存储过程参数要对应（个数和类型）
	  DBMS_OUTPUT.PUT_LINE(V_JOB_ENAME || ' ' || V_SAL || ' ' || V_HIREDATE);
	END;
	
	
	
	-- 5.注意参数给默认值情况
	CREATE OR REPLACE PROCEDURE SP_EMP5(T_DEPTNO EMP.DEPTNO%TYPE DEFAULT 10,
										T_JOB    EMP.JOB%TYPE)

	 IS
	  T_EMPNO EMP.EMPNO%TYPE;
	  T_SAL   EMP.SAL%TYPE;

	BEGIN
	  SELECT EMPNO, SAL
		INTO T_EMPNO, T_SAL
		FROM EMP
	   WHERE DEPTNO = T_DEPTNO
		 AND JOB = T_JOB;
	  DBMS_OUTPUT.PUT_LINE('员工编号: ' || T_EMPNO || ' 工资: ' || T_SAL);
	EXCEPTION
	  WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('未找到数据');
	  WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('其他错误');
	  
	END;
	
	
	调用1
    BEGIN
	  SP_EMP5(20,'MANAGER');
	END;
	调用2
	BEGIN
	  SP_EMP5(T_JOB=>'MANAGER');
	END;
	调用3
	BEGIN
	  SP_EMP5(T_JOB=>'MANAGER',T_DEPTNO=>30);
	END;
	  
	  
	  
	  
	
	
	练习：1.编写存储过程,传入部门号和工作类型,返回员工编号和对应工资
	
		2.编写存储过程,统计每个部门名称及其员工人数和平均工资（将统计结果插入到建立的目标表中,目标表在存储过程外建立）
		目标表：4个字段 (dname,emp_num,avg_sal,etl_date)-- etl_date为计算数据的时间,用sysdate就行
		注意：数据量特别大的时候,通过游标插入数据时候,实现每插入1万条数据提交一次;
		数据量不大的时候,可以直接一次性插入数据到目标表,最后提交。 
		    -- 全量数据（清空所有数据支持重跑）
			DELETE FROM 表;  
			-- 增量数据（清空当天数据支持重跑）
			DELETE FROM 表 WHERE TRUNC(etl_date)=TRUNC(SYSDATE);


			 -- 编写过程体(数据量不大，一次提交数据）
      CREATE OR REPLACE PROCEDURE SP_EMP_STAT IS
      BEGIN
        DELETE FROM T_EMP_STAT;  -- 数据量不大可以用delete清空数据支持重跑
        INSERT INTO T_EMP_STAT
          (DNAME, EMP_NUM, AVG_SAL, ETL_DATE)
          SELECT D.DNAME,
                 COUNT(DISTINCT E.EMPNO) AS EMP_NUM,
                 ROUND(AVG(SAL), 2) AS AVG_SAL,
                 SYSDATE AS ETL_DATE
            FROM DEPT D
            LEFT JOIN EMP E
              ON D.DEPTNO = E.DEPTNO
           GROUP BY D.DNAME;
        COMMIT;
      END;
      
      -- 数据量大
      CREATE OR REPLACE PROCEDURE SP_EMP_STAT1 IS
        CURSOR C_EMP_STAT IS
		SELECT D.DNAME,
				COUNT(DISTINCT E.EMPNO) AS EMP_NUM,
				ROUND(AVG(SAL), 2) AS AVG_SAL,
				SYSDATE AS ETL_DATE
		FROM DEPT D
		LEFT JOIN EMP E
			ON D.DEPTNO = E.DEPTNO
		GROUP BY D.DNAME;
      BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE T_EMP_STAT';-- 数据量大用truncate清空数据支持重跑
        FOR V_EMP_STAT IN C_EMP_STAT LOOP
          INSERT INTO T_EMP_STAT
            (DNAME, EMP_NUM, AVG_SAL, ETL_DATE)
          VALUES
            (V_EMP_STAT.DNAME,
             V_EMP_STAT.EMP_NUM,
             V_EMP_STAT.AVG_SAL,
             V_EMP_STAT.ETL_DATE);
          IF MOD(C_EMP_STAT%ROWCOUNT, 10000) = 0 THEN
            COMMIT;
          END IF;
        END LOOP;
        COMMIT;
      END;

		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		    
		  
		  
		  