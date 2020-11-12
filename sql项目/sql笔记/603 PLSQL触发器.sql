

触发器简介
		触发器的定义就是说某个条件成立的时候,触发器里面所定义的语句就会被自动的执行。
		触发器可以分为:语句级触发器和行级触发器。
		1、在一个表中定义的语句级的触发器,当这个表被删除时,程序就会自动执行触发器里面定义的操作过程。
		   这个就是删除表的操作就是触发器执行的条件了。
		2、在一个表中定义了行级的触发器,那当这个表中一行数据发生变化的时候,比如删除了一行记录,那触发器也会被自动执行了。
		
		--触发器语法
		语法：
		CREATE [OR REPLACE] TRIGGER TRIGGER_NAME
		{BEFORE | AFTER} TRIGGER_EVENT
		ON TABLE_NAME
		[FOR EACH ROW]
		[WHEN TRIGGER_CONDITION]
		TRIGGER_BODY

		语法解释：
		TRIGGER_NAME：   触发器名称
		BEFORE | AFTER : 指定触发器是在触发事件发生之前触发或者发生之后触发
		TRIGGER_EVENT：  触发事件,在DML触发器中主要为INSERT、UPDATE、DELETE等
		TABLE_NAME：     表名,表示发生触发器作用的对象
		FOR EACH ROW：   指定创建的是行级触发器,若没有该子句则创建的是语句级触发器
		WHEN TRIGGER_CONDITION：添加的触发条件
		TRIGGER_BODY：   触发体,是标准的PL/SQL语句块
		
	   示例：
		CREATE TABLE t_order_detail
		(
		   detail_id  NUMBER(20)    --主键
		  ,ord_no     NUMBER(20)    --订单号
		  ,ord_cnt    VARCHAR2(32)  --订单数量
		  ,ord_amt    NUMBER(10,2)  --订单金额
		  ,ord_cdate  date          --下单时间
		  ,ord_update date          --更新时间
		);


		CREATE TABLE t_order_detail_log     --创建日志表,用于记录对t_order_detail表的操作日志
		(
		   log_id     NUMBER           --日志id
		  ,log_action VARCHAR2(100)    --操作名称
		  ,log_date   DATE             --操作时间
		  ,log_message1   VARCHAR2(32) --日志信息1
		  ,log_message2   VARCHAR2(32) --日志信息2
		);

		行级触发器（after触发器）-- 主要是对敏感数据的操作进行日志记录,以便数据追踪
		创建触发器：将对 t_order_detail 表的操作记录到 t_order_detail_log 表中
		（OF 用于指定一个或多个字段,指定字段被更新时才会触发触发器）
		CREATE OR REPLACE TRIGGER tr_t_order_detail
		AFTER INSERT OR DELETE OR UPDATE OF detail_id,ord_amt     -- 字段
		ON t_order_detail                                         -- 表
		FOR EACH ROW  -- 行级触发
		BEGIN 
			IF INSERTING THEN
			   INSERT INTO t_order_detail_log VALUES(1,'insert',SYSDATE,:NEW.detail_id,:NEW.ord_amt);
			ELSIF DELETING THEN
			   INSERT INTO t_order_detail_log VALUES(2,'delete',SYSDATE,:OLD.detail_id,:OLD.ord_amt);
			ELSIF UPDATING THEN
			  INSERT INTO t_order_detail_log VALUES(3,'update_old',SYSDATE,:OLD.detail_id,:OLD.ord_amt);
			  INSERT INTO t_order_detail_log  VALUES(4,'update_new',SYSDATE,:NEW.detail_id,:NEW.ord_amt);
			 END IF;
		END;
		
		--插入一条数据
		INSERT INTO t_order_detail(detail_id,ord_no,ord_cnt,ord_amt,ord_cdate,ord_update) 
		VALUES (1,201801012111134567,3,21.68,
				TO_DATE('2018-01-01 21:11:13','YYYY-MM-DD HH24:MI:SS'),
				TO_DATE('2018-01-01 21:11:13','YYYY-MM-DD HH24:MI:SS')); 
		--删除一条数据		
		DELETE t_order_detail WHERE detail_id=7;   
		--修改订单的数量
		UPDATE t_order_detail SET ord_cnt=20 WHERE detail_id=1;   
		--修改订单的金额
		UPDATE t_order_detail SET ord_amt=100 WHERE detail_id=1;
		-- 如果t_order_detail数据回滚,t_order_detail_log的数据也会回滚
		SELECT * FROM t_order_detail;
		SELECT * FROM t_order_detail_log;
		
		
		语句级触发器（BEFORE触发器）：用来控制对表的修改  -- 主要是删除和更新（重要数据保留）
		CREATE OR REPLACE TRIGGER tr_t_order_detail_table
		BEFORE UPDATE OR DELETE ON t_order_detail
		BEGIN
		   IF DELETING THEN
			 RAISE_APPLICATION_ERROR(-20001,'该表不允许删除数据');
		   ELSIF UPDATING THEN
			 RAISE_APPLICATION_ERROR(-20002,'该表不允许修改数据');
		   END IF;
		END;

		DELETE FROM t_order_detail;
		UPDATE t_order_detail SET ord_amt=200 WHERE detail_id=1;
		DROP TABLE t_order_detail;

		
		

		-- 表字段的自增序列（触发器+序列）
		CREATE SEQUENCE S_DETAIL_ID;
		-- 触发器
		CREATE OR REPLACE TRIGGER tr_t_order_detail_id
		  BEFORE INSERT ON t_order_detail -- 表
		  FOR EACH ROW -- 行级触发
		DECLARE
		NEXTID NUMBER;
		BEGIN
		IF :NEW.detail_id IS NULL THEN --sno是列名
			:NEW.detail_id := S_DETAIL_ID.NEXTVAL;
		END IF;
		END;
		
	   SELECT * FROM t_order_detail;
	   INSERT INTO t_order_detail(ord_no,ord_cnt,ord_amt,ord_cdate,ord_update) 
	   VALUES (202001012111134567,5,66.76,sysdate,sysdate);
		
	   INSERT INTO t_order_detail(ord_no,ord_cnt,ord_amt,ord_cdate,ord_update) 
	   VALUES (20200823111134567,7,21.68,sysdate,sysdate);

				


	练习: 触发器记录对emp表的员工编号字段的数据变更情况(新建一张和emp表一样的表）

	--复制emp表 CREATE TABLE xiongyuan AS SELECT * FROM EMP;



		
			--01.复制emp表 CREATE TABLE xiongyuan AS SELECT * FROM EMP;

			--02.创建日志表
			CREATE TABLE xiongyuan_log    --创建日志表,用于记录对t_order_detail表的操作日志
					(
					log_id       NUMBER           
					,log_action  VARCHAR2(100)    
					,log_date    DATE             
					,log_message1   VARCHAR2(32) 
					,log_message2   VARCHAR2(32) 
					);
			--03.创建触发器
			CREATE OR REPLACE TRIGGER xiongyuan_detail
			AFTER INSERT OR DELETE OR UPDATE OF EMPNO     -- 字段
			ON xiongyuan                                       -- 表
			FOR EACH ROW  
			BEGIN 
				IF INSERTING THEN
				INSERT INTO xiongyuan_log VALUES(1,'insert',SYSDATE,:NEW.EMPNO);
				ELSIF DELETING THEN
				INSERT INTO xiongyuan_log VALUES(2,'delete',SYSDATE,:OLD.EMPNO);
				ELSIF UPDATING THEN
				INSERT INTO xiongyuan_log VALUES(3,'update_old',SYSDATE,:OLD.EMPNO);
				INSERT INTO xiongyuan_log  VALUES(4,'update_new',SYSDATE,:NEW.EMPNO);
				END IF;
			END;

	
	
	
	
	
	
	
	
	
	
	