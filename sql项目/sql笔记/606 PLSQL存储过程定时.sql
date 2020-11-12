


设置存储过程定时作业（DBMS_JOB）
		该过程用于建立一个新的作业,当建立作业的时候,需要通过设置相应的参数来告诉Oracle要执行的内容,
		要执行的时间,要执行任务的间隔。如下格式：
		DBMS_JOB.SUBMIT(
		   JOB OUT BINARY_INTERGER,                          -- 用于指定作业编号
		   WHAT IN VARCHAR2,                                 -- 用于指定作业要执行的操作
		   NEXT_DATE IN DATE DEFAULT SYSDATE,                -- 用于指定该操作的下一次运行的日期
		   INTERVAL IN VARCHAR2 DEFAULT 'NULL',              -- 用于指定该操作的时间间隔
		   NO_PARSE IN BOOLEAN DEFAULT FALSE,                -- 用于指定是否需要解析与作业相关的过程
		   INSTANCE IN BINARY_INTEGER DEFAULT ANY_INSTANCE,  -- 用于指定哪个例程可以运行作业？
		   FORCE IN BOOLEAN DEFAULT FALSE                    -- 用于指定是否强制运行与作业相关的例程
		);
		-- 举例
		CREATE TABLE TEST_JOB(
		ID NUMBER CONSTRAINT TEST_JOB_ID_PK PRIMARY KEY,
		NAME VARCHAR2(30),
		CT_DT DATE
		);
		--如果序列存在就删除,然后创建一个序列
		CREATE SEQUENCE TEST_JOB_ID_SEQ;
		--创建一个序列,每一次向表中插入一条数据,并且表中的ID字段值使用序列指定
		CREATE OR REPLACE PROCEDURE SP_INSERT_JOB IS
		BEGIN
		INSERT INTO TEST_JOB
		VALUES
		  (TEST_JOB_ID_SEQ.NEXTVAL, 'TEST' || TEST_JOB_ID_SEQ.CURRVAL,SYSDATE);
		COMMIT;
		END;
	  
		DECLARE
		  V_JOBNO NUMBER;
		BEGIN
		--提交,操作的时间间隔设置为5秒（default参数可以不用传入）
		  DBMS_JOB.SUBMIT(JOB=>V_JOBNO,
						  WHAT=>'SP_INSERT_JOB;', -- 'SP_INSERT_JOB;' 分号不能少 调用存储过程INSERT_JOB
						  NEXT_DATE=>SYSDATE,
						  INTERVAL=>'SYSDATE+1/(24*60*12)');  
		--打印序列号
		  DBMS_OUTPUT.PUT_LINE('JOBNO='||V_JOBNO);
		--运行
		  DBMS_JOB.RUN(V_JOBNO);
		END;
	  
		-- 删除
		BEGIN
		DBMS_JOB.REMOVE(JOBNO);  -- JOBNO为具体数字
		END; 









		
