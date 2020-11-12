1.查询结构
SELECT    *|字段|表达式(聚合函数/常量等,多个查询值用逗号隔开)  -- 如果有group by ,select中的非表达式中字段必须包含于group by的字段中
  FROM    表名
 WHERE    条件(对字段的限定,多个条件用and/or/not连接)
 GROUP BY 字段(多个字段,用逗号隔开)
HAVING    条件(对分组后的聚合值进行限定)
 ORDER BY 字段|表达式
 
 

2.执行顺序
SELECT        -- 5  
FROM          -- 1
WHERE         -- 2
GROUP BY      -- 3
HAVING        -- 4
ORDER BY      -- 6



3.运算符
算术运算：+ - * /
关系运算：> >= = <= < <> !=
逻辑运算：not and or


4.空值
'' 和null 都是空值
查询用：is null /is not null
(1)不参加算术、关系、聚合运算
(2)排序永远是最大


5.虚拟表
dual


6.集合in
多个or判断可以用in 替换


7.模糊查询like
通配符：
_:代替任意1个字符
%:代替任意个字符


8.聚合函数(一般是配合分组使用group by)
SUM/AVG/COUNT/MIN/MAX



9.子查询(select/update/delete 中包含的select语句为子查询)
单行子查询：
多行子查询：
-- 查看和7369员工工资相同的其他员工的信息
select * 
  from emp 
 where sal = (select sal from emp where empno=7369)
   and empno<>7369;
-- 查看和10号部门员工工资相同的其它部门的员工信息
select *
  from emp
 where sal in (select sal from emp where deptno=10)
   and deptno!=10;



10.集合运算
交集：INTERSECT
并集：UNION /UNION ALL
补集：MINUS

除了UNION ALL 合并集合不用排序和去重,其它都需要排序并去重



11.多表连接
内连接： INNER JOIN
外连接： LEFT JOIN/RIGHT JOIN/FULL JOIN

JOIN/ LEFT JOIN工作中用的最多
FULL JOIN 主要是查看两种表关联不上的信息数据
JOIN 中的条件限定写在ON和WHERE中结果是一致的;
LEFT JOIN 中的条件限定写在ON和WHERE中结果是有差异的;



12.DDL/DML/TCL
DDL: CREATE/ALTER/DROP  + 对象类型 + 对象名称
     TRUNCATE TABLE 表名
DML: INSERT INTO/UPDATE/DELETE + 表名
TCL:COMMIT/ROLLBACK
数据类型：
数字/日期/字符



13.单行函数
数字函数：ROUND/TRUNC
日期函数：ADD_MONTHS/LAST_DAY/MONTHS_BETWEEN
字符函数：REPLACE/TRIM/INSTR/SUBSTR



14.三种显示转换函数
to_char:    一般是对日期型转化为要取的日期的格式（年/年月/年月日/季度...）
to_number:  不能对日期直接转换为数字
to_date:    to_date('2018-05-05','YYYY-MM-DD')/date'2018-05-05'

SELECT  to_date('2018-05-05','YYYY-MM-DD')
        ,date'2018-05-05'
        ,to_date('2018-05-05 16:25:36','YYYY-MM-DD HH24:MI:SS')
  FROM dual;
  
  
  
15.空值转换
NVL/NVL2


16.条件转换函数
DECODE:

CASE WHEN 条件1 THEN 执行1 
	 WHEN 条件2 THEN 执行2
	 ...
	 ELSE 执行n
 END
 
 
 
17.伪列
ROWID/ROWNUM/LEVEL

ROWID:  表中每一行的一个物理地址,是属于表中的字段,值唯一（去重）
ROWNUM: 不是表固有的列, 只是在select 查询中生成的序列号 （分页）



18. EXISTS 函数
WHERE EXISTS (结果集)
-- 当结果集有返回记录(即使为空)就为真, 结果集没有返回记录就为假



19.临时表
会话级临时表：TEMPORARY  TABLE  ...  ON COMMIT PRESERVE ROWS;
事物级临时表：TEMPORARY  TABLE  ...  ON COMMIT DELETE ROWS;
用途：做多表连接，处理复杂逻辑的时候，需要临时表作为过渡。
特点：数据在会话或者事物技术后，数据会自动释放。表还是存在的。


20.分析函数
function_name() over (partition by ... order by ... asc/desc)
function_name：
1.聚合函数（求累计） 
  sum/count/avg/...
2.排序函数（求分组后的排名/挑选某种条件下的一行数据）
  -- 查看每个买家在当天第一笔订单的详情
select * 
  from (
select t.*,
       row_number() over (partition by 买家ID ORDER BY 支付时间 asc) as rn
  from t_order t
 where trunc(支付时间)=trunc(sysdate)
 ) t
where t.rn=1;
3.位移函数
  lead()
  lag()
  -- 计算同比/环比（主要是可以对数据错位，可以进行上下行的计算）
  

21.行列转换
行转列：  
(1)
max + case when 原来的列=某值1 then ...end as 新的列名1,
max + case when 原来的列=某值2 then ...end as 新的列名2,
...
(2)
pivot

列传列： 
(1)
字段1,标识值1
UNION ALL
字段1,标识值1
...
(2)
unpivot

  
  
22.表的约束
主键约束：PRIMARY KEY
外键约束：FOREIGN KEY REFERENCES ...
检查约束：CHECK
唯一约束：UNIQUE
非空约束：NOT NULL



































































 
 
 
 
 
 










