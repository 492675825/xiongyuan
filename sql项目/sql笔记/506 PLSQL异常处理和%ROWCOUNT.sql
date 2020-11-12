
1.异常处理	
	语法格式：异常处理
	BEGIN
		--可执行部分
		EXCEPTION   -- 异常处理开始
			WHEN 异常名1 THEN
				 --对应异常处理;
			WHEN 异常名2 THEN
				 --对应异常处理;
			 ……
			WHEN OTHERS THEN
				 --其他异常处理;
	END;
	
	------- 
	DECLARE
	  V_ENMAE EMP.ENAME%TYPE; 
	BEGIN
	  SELECT ENAME
	  INTO V_ENMAE
	  FROM EMP
	   WHERE DEPTNO=10;   -- 'dfad' 其它错误
	   DBMS_OUTPUT.PUT_LINE('返回单行值');       
	  EXCEPTION   -- 异常处理开始
		WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('SELECT INTO 返回多行值！');
		WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('SELECT INTO 没有返回值！');
		  WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('其它错误！');
	END;




2.程序块中的%ROWCOUNT
	2.1 SQL%ROWCOUNT 用于记录修改的条数,必须放在一个增删改等修改类语句后面执行,select语句用于查询的话无法使用,
	    当你执行多条修改语句时,SQL%ROWCOUNT 之前执行的最后一条语句修改数为准。

		BEGIN
		  DELETE FROM emp;
		  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);   -- 记录删除数据的条数
		  INSERT INTO emp(empno) VALUES (7777);
		  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);   -- 记录插入数据的条数
		  UPDATE emp SET comm=1000 WHERE empno=7369;
		  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);   -- 记录更新数据的条数
		END;


	2.2 游标%ROWCOUNT  用于记录游标遍历到第几行。
        -- 数据插入一次提交（数据量太大占用内存时间太长太大）
        BEGIN
          DELETE FROM EMP_SYN; -- 清空数据支持重跑
          INSERT INTO EMP_SYN
            SELECT * FROM EMP;
          COMMIT;
        END;
        
        -- 分批提交数据
        DECLARE
          CURSOR C_EMP IS
            SELECT * FROM EMP;
        BEGIN
          DELETE FROM EMP_SYN;     -- 清空数据支持重跑
          FOR T_EMP IN C_EMP LOOP
              INSERT INTO EMP_SYN
              SELECT *
                FROM emp;
              IF mod(C_EMP%ROWCOUNT,10000)=0 THEN   -- 每插入1万行提交一次
                COMMIT;
              END IF;
          END LOOP;
        END;
           

	
	

	
	
	
	
	
	
	
	