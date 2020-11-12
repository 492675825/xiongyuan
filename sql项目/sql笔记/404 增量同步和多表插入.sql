

业务交易系统：
t_pay;
同步数据到数仓：
t_pay_ods
1.全量同步(晚上凌晨)
（1）先清空目标表t_pay_ods;
（2）整个业务数据同步到目标表t_pay_ods;
2.增量同步(按天增量/晚上凌晨)
（1）将业务前一天的数据同步到目标表t_pay_ods;

merge into [target-table] A 
   using [source-table sql] B
    on ([conditional expression] and [...]...)
when matched then      -- 当on中的条件匹配时
	[update sql]       -- 执行操作   更新或删除等
when not matched then  -- 当on中的条件不匹配时
	[insert sql]       -- 执行操作   新增等

/**

该语法用于：
    判断Ｂ表和Ａ表是否满足ON中条件，如果满足则用B表去更新A表（或其他操作），
    如果不满足，则将B表数据插入A表但是有很多可选项（或其他操作）.
    
其中：B表是作为条件来源或数据对比的作用，实际操作，一般是针对A表.

**/





1.增量更新数据
	语法格式：MERGE（不是所有数据库都通用）
	MERGE INTO 目标表
	USING (数据来源表)
	ON (匹配字段)
	WHEN MATCHED THEN UPDATE SET   --UPDATE和SET之间不需要加表名
	WHEN NOT MATCHED THEN INSERT VALUES
	--INSERT和VALUES之间不需要加INTO 表名
	

  -- 全量同步（历史数据量太大,耗时太长）
  INSERT INTO 目标表(字段) 
  SELECT 字段 FROM 源表;
  
  -- 增量（按天增量较多,只更新按天变化的数据）
  1. 删除目标表前一天的数据,插入源表前一天的数据
  2. Merge INTO, 增量是源表前一天的数据, 
     如果跟目标表关联得上的数据, 表示在目标表中存在的数据, 源表发生了变化的数据;
     如果跟目标表关联不上的数据, 表示在目标表中没有的数据, 源表新增的数据.
  
 
    例题：增量同步数据（merge into方法的on中，指定的字段不能有重复值）
    CREATE TABLE SRC_DEPT AS SELECT * FROM DEPT WHERE DEPTNO IN (10,20);
    ALTER TABLE SRC_DEPT ADD created_dt DATE;
    ALTER TABLE SRC_DEPT ADD updated_dt DATE;
    -- 0504源系统新增数据
    UPDATE SRC_DEPT SET created_dt=DATE'2020-05-04';
    UPDATE SRC_DEPT SET updated_dt=DATE'2020-05-04';
    UPDATE SRC_DEPT SET loc='达拉斯' WHERE deptno=20;
    -- 0505凌晨12点后, 目标表同步0504号数据(第一次同步要全量同步数据)
    CREATE TABLE SRC_DEPT_BAK AS SELECT * FROM SRC_DEPT WHERE 1=2;

    ALTER TABLE SRC_DEPT_BAK ADD etl_dt DATE;
    INSERT INTO SRC_DEPT_BAK SELECT d.*,DATE'2020-05-05' FROM SRC_DEPT d ;
    -- 0505白天源系统数据新增两条数据,同时更新一条0504的数据
    UPDATE SRC_DEPT SET loc='DALLAS',updated_dt=DATE'2020-05-05' WHERE deptno=20;
    INSERT INTO SRC_DEPT SELECT DEPT.*,DATE'2020-05-05',DATE'2020-05-05' FROM DEPT WHERE DEPTNO IN (30,40);

    -- 0506凌晨12点后, 目标表同步0505号数据(增量同步数据)
    MERGE INTO SRC_DEPT_BAK a
   	USING (SELECT * FROM SRC_DEPT WHERE updated_dt=DATE'2020-05-05') b
   	ON (a.deptno=b.deptno)
   	WHEN MATCHED THEN UPDATE SET
       a.dname=b.dname
      ,a.loc=b.loc
      ,a.created_dt=b.created_dt
      ,a.updated_dt=b.updated_dt
      ,a.etl_dt=DATE'2020-05-06'
   	WHEN NOT MATCHED THEN INSERT
      (a.deptno,a.dname,a.loc,a.created_dt,a.updated_dt,a.etl_dt)   
   VALUES (b.deptno,b.dname,b.loc,b.created_dt,b.updated_dt,DATE'2020-05-06');
	
   SELECT * FROM SRC_DEPT;
   SELECT * FROM SRC_DEPT_BAK;

	
	
	
	MERGE的灵活应用：
	若数据量大时,MERGE删除比DELETE好。
	MERGE INTO EMP E
	USING (SELECT * FROM EMP WHERE DEPTNO = 10) S
	ON (S.EMPNO = E.EMPNO)
	WHEN MATCHED THEN
	UPDATE SET E.COMM = E.COMM DELETE WHERE 1 = 1;   --SET随便改,后面接DELETE
	
	
	
    -- 未考虑分区情况
    1.从100万的数据中删除deptno=10的数据(10万)   -- delete from emp where deptno=10;
    2.将6000万的数据全部删除                     -- truncate table emp;
    3.从6000万的数据中删除deptno=10的数据(10万)  -- merge into
    4.一共6000万数据,分布情况如下：
  	部门标号      数据量
  	10            5800万
  	20            100万
  	30            50万
  	40            50万
  	删除10号部门数据？
  	
  	创建一张新表，跟源表结构一致，将20,30,40号部门数据导入到新表;
  	旧表改名，将新表改名。（有外键约束等权衡考虑）
	
	
	

	
2.INSERT ALL
	-- 多条插入
	CREATE TABLE t2 (id NUMBER(2),name VARCHAR2(20));
	
	INSERT ALL
	  INTO t2 
	VALUES (1, '张美丽')
	  INTO t2 
	VALUES (2, '王小二')
	SELECT * FROM dual;  -- 语句结构必须要select ...
	COMMIT;
	SELECT * FROM t2;


	-- 多表插入（分表--大表按照类别插入数据到小表）
    /*
	CREATE TABLE t1(product_id NUMBER, product_name VARCHAR2(80),p_month NUMBER);
	INSERT INTO t1 VALUES(111, '苹果',1);
	INSERT INTO t1 VALUES(222, '橘子',1);
	INSERT INTO t1 VALUES(333, '香蕉',1);
	COMMIT;
	-- 小表
	CREATE TABLE apple_orders AS SELECT * FROM t1 WHERE 1=2;
	CREATE TABLE orange_orders AS SELECT * FROM t1 WHERE 1=2;
	CREATE TABLE banana_orders AS SELECT * FROM t1 WHERE 1=2;
	*/
	INSERT ALL
		WHEN product_id = 111 THEN
			INTO apple_orders
		WHEN product_id = 222 THEN
			INTO orange_orders
		ELSE
			INTO banana_orders
		SELECT product_id, product_name, p_month 
		  FROM t1;
	COMMIT;
	SELECT * FROM apple_orders;
	SELECT * FROM orange_orders;
	SELECT * FROM banana_orders;
	
	
	
	
	
3.建表注意
	CREATE TABLE ORCL_emp_syn 
	("EMPNO" NUMBER(4,0), 
	  "ENAME" VARCHAR2(10), 
	  "JOB" VARCHAR2(9), 
	  "MGR" NUMBER(4,0), 
	  "HIREDATE" DATE, 
	  "SAL" NUMBER(7,2), 
	  "COMM" NUMBER(7,2), 
	  "DEPTNO" NUMBER(2,0),
	  "ETL_DATE" DATE
	);


	CREATE TABLE "ORCL_emp_syn"
	("EMPNO" NUMBER(4,0), 
	  "ENAME" VARCHAR2(10), 
	  "JOB" VARCHAR2(9)
	);

	SELECT * FROM ORCL_emp_syn;
	SELECT * FROM "ORCL_emp_syn";
	
	
	
	
	
	
	
	
	
	
	
	