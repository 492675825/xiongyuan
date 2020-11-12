

临时表
	创建ORACLE临时表,可以有两种类型的临时表：
	会话级临时表（1.其它会话查询不到数据 2.本会话关掉后也查询不到数据）
	事务级临时表（1.当进行事务提交或者事务回滚的时候,临时表中的数据将自行被截断 
				  2.其它会话查询不到数据 
				  3.本会话关掉后也查询不到数据）

  用途：对于一个电子商务类网站，不同消费者在网站上购物，就是一个独立的 SESSION，选购商品放进购物车中，
  最后将购物车中的商品进行结算。也就是说，必须在整个SESSION期间保存购物车中的信息。
  同时，还存在有些消费者，往往最终结账时放弃购买商品。如果，直接将消费者选购信息存放在最终表
  （PERMANENT）中，必然对最终表造成非常大的压力。因此，对于这种案例，就可以采用创建临时表(ON COMMIT PRESERVE ROWS)的方法来解决。
  数据只在 SESSION 期间有效，对于结算成功的有效数据，转移到最终表中后，ORACLE自动TRUNCATE 临时数据；
  对于放弃结算的数据，ORACLE 同样自动进行 TRUNCATE ，而无须编码控制，并且最终表只处理有效订单，减轻了频繁的DML操作的压力
	1）会话级临时表
		CREATE GLOBAL TEMPORARY TABLE TABLE_NAME
	   (COL1 TYPE1,COL2 TYPE2...) ON COMMIT PRESERVE ROWS;
   
	2）事务级临时表
		CREATE GLOBAL TEMPORARY TABLE TABLE_NAME
		(COL1 TYPE1,COL2 TYPE2...) ON COMMIT DELETE ROWS;
	
-- 1.会话级临时表（每一个打开的窗口，当窗口关闭数据就没有了）
	CREATE GLOBAL TEMPORARY TABLE tmp_STUDENT
	(STU_ID NUMBER(5),
	CLASS_ID  NUMBER(5),
	STU_NAME VARCHAR2(8),
	STU_MEMO VARCHAR2(200)) ON COMMIT PRESERVE ROWS ;

	INSERT INTO tmp_STUDENT VALUES(1,2,'A','随便');
	INSERT INTO tmp_STUDENT VALUES(2,3,'B','OK');
	COMMIT;
	SELECT * FROM tmp_STUDENT;

	-- 目标表
	CREATE TABLE STUDENT_tmp_cp
	(STU_ID NUMBER(5),
	CLASS_ID  NUMBER(5),
	STU_NAME VARCHAR2(8),
	STU_MEMO VARCHAR2(200));

	-- 目标表
	INSERT INTO STUDENT_tmp_cp
	SELECT * 
	FROM tmp_STUDENT
	WHERE STU_MEMO='OK';


	SELECT * FROM tmp_STUDENT;
	SELECT * FROM STUDENT_tmp_cp;

		
		
		

-- 2.事务级临时表
   -- 支付给商家,商家收到钱以及支付方被扣款
  CREATE GLOBAL TEMPORARY TABLE tmp_pay_customer
  (id NUMBER(5),
  pay_mon VARCHAR2(8)
  ) ON COMMIT DELETE ROWS;
  
  CREATE GLOBAL TEMPORARY TABLE tmp_get_merchant
  (id NUMBER(5),
  get_mon VARCHAR2(8)
  ) ON COMMIT DELETE ROWS;
  
  INSERT INTO tmp_pay_customer VALUES(1,-100);
  SELECT * FROM tmp_pay_customer;
  COMMIT; -- 确认支付
  -- 商家收款
  INSERT INTO tmp_get_merchant VALUES(1,100);
  
  
	
/*用途：
业务需求：
涉及到6张大表的关联（每张2000万行）

-- 1-2个小时
INSERT INTO 目标表(字段)
SELECT t_a.col2,
       t_b.col3,
       t_c.col4,
       t_d.col5,
       t_e.col6,
       t_f.col6,
  FROM t_a
  LEFT JOIN t_b
    ON t_a.col1=t_b.col1
  JOIN t_c
    ON t_c.col2=t_b.col2
  JOIN t_d
    ON t_d.col2=t_b.col2
  JOIN t_e
    ON t_e.col2=t_b.col2
  JOIN t_f
    ON t_f.col2=t_b.col2;
	
	
-- 拆开进行关联
1.先对t_a, t_b, t_c进行关联写入到临时表tmp_abc
INSERT INTO tmp_abc(字段)
SELECT 需要的字段
  FROM t_a
  LEFT JOIN t_b
    ON t_a.col1=t_b.col1
  JOIN t_c
    ON t_c.col2=t_b.col2;
	
	
2.用临时表和t_d, t_e, t_f
INSERT INTO 目标表(字段)
SELECT 字段
  FROM tmp_abc
  JOIN t_d
    ON t_d.col2=tmp_abc.col2
  JOIN t_e
    ON t_e.col2=tmp_abc.col2
  JOIN t_f
    ON t_f.col2=tmp_abc.col2;
	
*/
	
	
	
	
	
	
	
	
	
	
	
	
	