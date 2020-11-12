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












































 
 
 
 
 
 










