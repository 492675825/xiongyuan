-- 1
1.查询员工ENAME的第三个字母是A的员工的信息(使用2种方法)。
SELECT * FROM EMP WHERE ENAME LIKE '__A%';
SELECT * FROM EMP WHERE SUBSTR(ENAME,3,1)='A';


2.查询部门10, 20的员工截止到2000年1月1日，工作了多少个月
SELECT EMPNO, ENAME, MONTHS_BETWEEN(DATE'2000-01-01',HIREDATE) AS DIF_MON
  FROM EMP WHERE DEPTNO IN (10,20);


3.显示姓名、hiredate和雇员开始工作日是星期几(提示：使用to_char函数)
SELECT ename,hiredate,TO_CHAR(HIREDATE,'DAY') FROM EMP;


4.查询所有名字的开始字母是J、A或M的雇员,
  用首字母大写、其它字母小写显示雇员的全名，显示名字的长度，并对查询结果按雇员的全名升序排序。
SELECT E.*,
       CONCAT(UPPER(SUBSTR(ENAME, 1, 1)), LOWER(SUBSTR(ENAME, 2))) AS 姓名,
       LENGTH(ENAME) AS 长度
  FROM (SELECT *
          FROM EMP
         WHERE ENAME LIKE 'J%'
            OR ENAME LIKE 'A%'
            OR ENAME LIKE 'M%') E
   ORDER BY 姓名;
  
  

5.查询部门编号为10或20，入职日期在81年5月1日之后，并且姓名中包含大写字母A的员工姓名，员工姓名长度
（提示，要求使用INSTR函数，不能使用like进行判断)
SELECT ENAME, LENGTH(ENAME) AS 长度
  FROM EMP
 WHERE DEPTNO IN (10,20)
   AND HIREDATE>DATE'1981-05-01'
   AND INSTR(ENAME,'A',1,1)>0;
   

6.将员工工资按如下格式显示：123,234.00 RMB。
SELECT TO_CHAR(SAL,'FM999,990.00')||' RMB' FROM emp;



7.在员工表中查询出员工的工资，并计算应交税款：
	如果工资小于1000,税率为0，
	如果工资大于等于1000并小于2000，税率为10％，
	如果工资大于等于2000并小于3000，税率为15％，
	如果工资大于等于3000，税率为20％。
SELECT SAL,
       (CASE WHEN SAL<1000 THEN 0
	         WHEN SAL<2000 THEN SAL*0.1
			 WHEN SAL<3000 THEN SAL*0.15
			 ELSE SAL*0.2
	     END) AS 应交税款
  FROM EMP;
	
8. 查询各个管理者手下员工的最低工资，其中最低工资不能低于6000，没有管理者的员工不计算在内
SELECT E2.EMPNO,
       MIN(E1.SAL) 
  FROM EMP E1 
  JOIN EMP E2 
    ON E1.MGR = E2.EMPNO
  GROUP BY E2.EMPNO
  HAVING MIN(E1.SAL)>2000;




-- 2
1. 组函数处理多行返回一行吗?  
2. 组函数不计算空值吗？                是
3. where子句可否使用组函数进行过滤?    WHERE COUNT(1)>3; 否



-- 3
原表:
courseid coursename score
1        Java       70
2        oracle     90
3        xml        40
4        jsp        30
5        servlet    80
-------------------------------------
为了便于阅读, 查询此表后的结果显式如下( 及格分数为60):
courseid coursename score mark
1        Java       70    pass
2        oracle     90    pass
3        xml        40    fail
4        jsp        30    fail
5        servlet    80    pass
SELECT S.*,
       CASE WHEN SCORE>=60 THEN 'pass' ELSE 'fail' END AS MARK
 FROM SC_JUN S	




-- 4
原表：
id    name
1     a
1     b
2     c
2     d
3     e
3     f
3     g
-------------------------------------
用一条sql实现如下展示结果：
id     name
1      a_b
2      c_d
3      e_f_g

/*
create table t_1 (id1 number(10),name1 varchar2(10));
insert into t_1 values (1, 'a');
insert into t_1 values (1, 'b');
insert into t_1 values (2, 'c');
insert into t_1 values (2, 'd');
insert into t_1 values (3, 'e');
insert into t_1 values (3, 'f');
insert into t_1 values (3, 'g');
*/


SELECT id1 as id,REPLACE(wm_concat(name1),',','_') AS name
  FROM 表
 GROUP BY id1;




-- 5	   
1.不用组函数求EMP表中薪水最高的员工信息。
  SELECT *
    FROM (SELECT E.*, RANK() OVER(ORDER BY SAL DESC) AS RAK FROM EMP E) T
   WHERE T.RAK = 1;
   
   
2.求每个部门工资高于部门平均工资的员工数量占整个部门人数的百分比
SELECT DEPTNO,
       -- COUNT(EMPNO),
       -- SUM(CASE WHEN SAL>AVG_SAL THEN 1 ELSE 0 END),
       CONCAT(ROUND(SUM(CASE WHEN SAL>AVG_SAL THEN 1 ELSE 0 END)/COUNT(EMPNO)*100,2),'%') AS RATE
  FROM (SELECT E.*,
               AVG(SAL) OVER (PARTITION BY DEPTNO) AS AVG_SAL
          FROM EMP E) T
 GROUP BY DEPTNO;






-- 6
1.统计emp表中的各部门人数和所有部门人数总和，格式如下：
	部门       人数
	10          3
	20          5
	30          6
	50          1
	总计        15 
 SELECT to_char(deptno) AS 部门,
        COUNT(DISTINCT empno) AS 人数
   FROM emp
  GROUP BY deptno
 UNION ALL
 SELECT '总计' AS 部门,
        COUNT(DISTINCT empno) AS 人数
   FROM emp;
 或者
 SELECT NVL(to_char(deptno),'总计') AS 部门,
        COUNT(DISTINCT empno) AS 人数
   FROM emp
  GROUP BY rollup(deptno);


2. 查询在1980-1982年之间，每年雇用的人数，展示各式如下
	total  1980   1981   1982  
	   13     1     10      2   
 WITH T AS (  
 SELECT TO_CHAR(HIREDATE, 'YYYY') AS 年,
        COUNT(1) AS 人数
   FROM EMP
  WHERE TO_CHAR(HIREDATE, 'YYYY') BETWEEN '1980' AND '1982'
  GROUP BY rollup(TO_CHAR(HIREDATE, 'YYYY')))
 SELECT * FROM T PIVOT(SUM(人数) FOR 年 IN(NULL AS total,'1980','1981','1982'));   
	   
	   


-- 7
有如下两张表：
交易表deli_t：

日期Busi_date	交易时间Exch_time	客户编号Cust_piy_no	 交易类型Exch_type	产品代码Prd_no	交易量Del_amt	机构编号Org_no
20170101	    93102	            0312003	             证券买入	        00001	        1000	        0312
20170101	    103102	            0312003	             证券买入	        00002	        500	            0312
20170101	    133102	            0312003	             证券卖出	        00003	        800	            0312
......	                                                                                    
20171231	    143102	            0320004	             期权买入	        00004	        500	            0320

客户信息表info_t：
机构编号Org_no   机构名称Org_name
0312	         黄埔东路
0320	         农林下路
...         
0306	         中年广场


需求1:
    请写一段筒单的sql,提取出201712月每个部门每天各种交易类型的交易量给业务部门.
    展示字段为:日期、机构名称、证券买入当日交易量、证券卖出当日交易量

需求2:
    提取出201712月每天第一个下单的客户、最后一个下单的时间信息.
    展示字段为:日期、第一个下单时间、第一个下单客户、最后下单时间、最后下单客户
	
需求3:
    提取出201712月每天成交量前10的产品信息展示字段为:日期、产品代交易量、排名
    提示:此表数据量巨大,请考虑劇脚本效率

-- 需求1:
SELECT d.busi_date AS 日期,
       i.org_name AS 机构名称,
       SUM(CASE WHEN d.exch_type='证券买入' THEN d.del_amt END) AS 证券买入当日交易量,
       SUM(CASE WHEN d.exch_type='证券卖出' THEN d.del_amt END) AS 证券卖出当日交易量
  FROM deli_t d
  JOIN info_t i
    ON d.org_no=i.org_no
 WHERE SUBSTR(d.busi_date,1,6)='201712'  -- d.busi_date 为字符串类型
 GROUP BY d.busi_date,i.org_name;


-- 需求2:
SELECT tmp.busi_date AS 日期,
       d1.exch_time AS 第一个下单时间,
       d1.cust_piy_no AS 第一个下单客户,
       d2.exch_time AS 最后下单时间,
       d2.cust_piy_no AS 最后下单客户
  FROM ( 
        SELECT d.busi_date,
               MIN(exch_time) AS min_exch_time,
               MAX(exch_time) AS max_exch_time
          FROM deli_t d
         WHERE SUBSTR(d.busi_date,1,6)='201712'  -- d.busi_date 为字符串类型
         GROUP BY d.busi_date
        ) tmp
   JOIN deli_t d1
     ON d1.busi_date=tmp.busi_date
    AND d1.exch_time=tmp.min_exch_time
   JOIN deli_t d2
     ON d2.busi_date=tmp.busi_date
    AND d2.exch_time=tmp.max_exch_time
  ORDER BY tmp.busi_date;


-- 需求3:
    WITH T AS (
    SELECT BUSI_DATE, PRD_NO, SUM(DEL_AMT) AS DEL_AMT
      FROM DELI_T D
     WHERE SUBSTR(D.BUSI_DATE, 1, 6) = '201712'
     GROUP BY BUSI_DATE, PRD_NO
     )
     SELECT * FROM (SELECT T.*,
                           ROW_NUMBER() OVER(PARTITION BY BUSI_DATE, PRD_NO ORDER BY DEL_AMT DESC) AS RN
                      FROM T) T1
      WHERE T1.RN <= 10;
	  
    /*
	SELECT busi_date AS 日期,
		   prd_no AS 产品代码,
		   del_amt AS 每天成交量
	  FROM (SELECT busi_date,
				   prd_no,
				   SUM(del_amt) AS del_amt,
				   row_number() OVER(PARTITION BY busi_date ORDER BY SUM(del_amt) DESC) AS rn
			  FROM deli_t d
			 WHERE SUBSTR(d.busi_date,1,6)='201712'  -- d.busi_date 为字符串类型
			 GROUP BY busi_date,prd_no
			 ) t
	   WHERE rn<=10;

    */










