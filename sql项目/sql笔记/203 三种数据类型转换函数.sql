
数据类型转换函数：
TO_CHAR/TO_NUMBER/TO_DATE


-- 1.TO_CHAR(d|n[,fmt])
   SELECT 12, TO_CHAR(12),TO_CHAR(DATE'2019-07-08','YYYYMMDD') FROM DUAL;
	-- fmt 格式
	SELECT TO_CHAR(DATE'2019-08-30','YYYY'),   -- '2019'
		   TO_CHAR(DATE'2019-08-30','YYYYMM'), -- '201908'
		   TO_CHAR(DATE'2019-08-30','WW'),     -- '35'  第35周
		   TO_CHAR(DATE'2019-08-30','IW'),     -- '35'  第35周（自然周）
		   TO_CHAR(DATE'2019-08-30','Q'),      -- '3'   第3季度
		   TO_CHAR(DATE'2019-08-30','MM'),     -- '08'
		   TO_CHAR(DATE'2019-08-30','DD'),     -- '30'
		   TO_CHAR(DATE'2019-08-30','D')       -- '6'   当周的第几天（星期天为第一天）
	  FROM DUAL;
	  
    -- 数字格式显示（后面格式长度要大于前面的值,如果不加FM或在前面填充空格）
    SELECT TO_CHAR(243677865674,'FM999,999,999,999,990.00') FROM DUAL;
	
	
	例题：计算员工表中每年入职的人数。
	SELECT TO_CHAR(HIREDATE, 'YYYY') AS 入职年份, 
		COUNT(*) AS 入职人数
	  FROM EMP
	 GROUP BY TO_CHAR(HIREDATE, 'YYYY')
	 ORDER BY 入职年份;
	 
	  
	/*
    订单表：t_order
	order_id         order_tm              cus_id    pro_id      cnt     amt
	2012010000001    2020-05-25 11:28:29   t00001   100010001    1       6000
	2012010000001    2020-05-25 11:28:29   t00001   200010001    1       2200
	2012010000002    2020-05-25 10:51:26   t00002   100010002    2       7800
	2012010000003    2020-05-26 08:22:15   t00003   200010001    1       2000
	2012010000004    2020-05-27 10:51:26   t00003   200010001    1       1800
    
    产品表：t_product
	pro_class_id    pro_id      pro_name
	1               100010001   笔记本电脑
	1               100010002   台式一体机电脑
	2               200010001   全自动洗衣机
         
    客户表：t_customer
	cus_id   cus_name
	t00001   小蝴蝶
	t00002   大耳朵
	t00003   大漂亮
	-----
	CREATE TABLE t_order(order_id number(20), order_tm date, cus_id varchar2(20), pro_id number(20), cnt number(10), amt number(16,2));
	insert into t_order values(  2012010000001, to_date('2020-05-25 11:28:29','YYYY-MM-DD HH24:MI:SS'), 't00001', 100010001, 1, 6000);
	insert into t_order values(  2012010000001, to_date('2020-05-25 11:28:29','YYYY-MM-DD HH24:MI:SS'), 't00001', 200010001, 1, 2200);
	insert into t_order values(  2012010000002, to_date('2020-05-25 10:51:26','YYYY-M