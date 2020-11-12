

创建日志
	日志是用来追溯问题的,记录整个程序的运行情况,知道哪个环节报错了,
	记录每一步花了多少时间,判断哪一步性能不好,从而对程序进行修改和优化。
	人为创建的日志区别于Oracle系统自带的日志,后者调用的成本比较高。
	通常报错的时候,会有很多条报错信息,第一条是真正报错的原因。
	一般SP里都会有调用日志语句。
	
	语法格式：创建日志
	--创建日志表
	CREATE TABLE LOG_RECORD(
	 LOG_ID NUMBER,
	 SP_NAME VARCHAR2(100),
	 STEP NUMBER,
	 FINISH_TIME DATE,
	 REMARKS VARCHAR2(100));

	--创建序列用于LOG_ID
	CREATE SEQUENCE SEQ_LOG_ID;
	
	--目标表T_SYN_EMP
	CREATE TABLE T_SYN_EMP AS SELECT * FROM EMP WHERE 1=2;
	
	
	
	（1）插入数据到日志表（INSERT INTO）
	-- 全量同步emp的数据到T_SYN_EMP
	CREATE OR REPLACE PROCEDURE SP_SYN_EMP
	IS
	BEGIN
	  -- 1 
	  EXECUTE IMMEDIATE 'TRUNCATE TABLE T_SYN_EMP';
	  INSERT INTO LOG_RECORD VALUES(SEQ_LOG_ID.NEXTVAL, 'SP_SYN_EMP',1,SYSDATE,'清空T_SYN_EMP表数据!');		  
	  -- 2
	  INSERT INTO T_SYN_EMP SELECT * FROM EMP;
	  INSERT INTO LOG_RECORD VALUES(SEQ_LOG_ID.NEXTVAL, 'SP_SYN_EMP',2,SYSDATE,'全量插入数据到T_SYN_EMP表!');
	  -- 3
	  INSERT INTO LOG_RECORD VALUES(SEQ_LOG_ID.NEXTVAL, 'SP_SYN_EMP',3,SYSDATE,'存储过程执行完成!');
	  COMMIT;
	END;
	
	-- 调用
	BEGIN
	  SP_SYN_EMP;
	END;
	
	SELECT * FROM LOG_RECORD;
	SELECT * FROM T_SYN_EMP;
	
	
	（2）插入数据到日志表（调用日志存储过程）
	-- 创建存储过程日志记录
	CREATE OR REPLACE PROCEDURE SP_LOG(P_SP_NAME  VARCHAR2,
									   P_STEP     NUMBER,
									   P_REMARKS  VARCHAR2) 
	IS
	BEGIN
	  INSERT INTO LOG_RECORD
		(LOG_ID, SP_NAME, STEP, FINISH_TIME, REMARKS)
	  VALUES
		(SEQ_LOG_ID.NEXTVAL, P_SP_NAME, P_STEP, SYSDATE, P_REMARKS);
	  COMMIT;
	END;
	

	-- 跑某个存储过程的时候调用日志存储过程
	CREATE OR REPLACE PROCEDURE SP_SYN_EMP
	IS
	BEGIN
	  -- 1 
	  SP_LOG(P_SP_NAME, 1, '清空T_SYN_EMP表数据');	  
	  EXECUTE IMMEDIATE 'TRUNCATE TABLE T_SYN_EMP';
	  -- 2
	  SP_LOG(P_SP_NAME, 2, '全量插入数据到T_SYN_EMP表');
	  INSERT INTO T_SYN_EMP SELECT * FROM EMP;
	  -- 3
	  SP_LOG(P_SP_NAME, 3, '存储过程执行完成！');
	  COMMIT;
	END;
	
	
	-- 调用
    BEGIN
      SP_SYN_EMP;
    END;
	

	SELECT * FROM T_SYN_EMP;
	SELECT * FROM LOG_RECORD;
	
	
	
	
	-- 通过日志可以发现的问题
	1.存储过程当天是否成功执行（查看存储过程SP_SYN_EMP）
	SELECT *
	  FROM LOG_RECORD
	 WHERE TRUNC(finish_time)=TRUNC(SYSDATE)
	   AND sp_name='SP_SYN_EMP';
	2.存储过程总耗时
	SELECT (MAX(finish_time)-MIN(finish_time))*24*60 AS 总耗时
	  FROM LOG_RECORD
	 WHERE TRUNC(finish_time)=TRUNC(SYSDATE)
	   AND sp_name='SP_SYN_EMP';
	3.存储过程耗时比较长的步骤
	SELECT t.*,
		   (LEAD(finish_time) OVER (PARTITION BY sp_name ORDER BY step)-finish_time)*24*60 AS 每步耗时
	  FROM LOG_RECORD t
	 WHERE TRUNC(finish_time)=TRUNC(SYSDATE);
	
	
	
	
	

	
	
		
	练习：删除emp表各个部门的经理的相关信息,插入自己的相关信息到emp表,记录存储过程的操作步骤到日志表(存储过程实现)
		 （日志通过调用SP_LOG(P_SP_NAME  VARCHAR2, P_CYCLE_ID NUMBER, P_STEP NUMBER, P_REMARKS VARCHAR2)插入）
		  4个步骤记录到日志表：
		  1)开始
		  2)删除
		  3)插入
		  4)执行完毕

		  --01.创建日志表
	CREATE TABLE LOG_RECORD(
	 LOG_ID NUMBER,
	 SP_NAME VARCHAR2(100),
	 STEP NUMBER,
	 FINISH_TIME DATE,
	 REMARKS VARCHAR2(100));

	--创建序列用于LOG_ID
	CREATE SEQUENCE SEQ_LOG_ID;
	
	--目标表T_SYN_EMP
	CREATE TABLE T_SYN_EMP AS SELECT * FROM EMP WHERE 1=2;


		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  