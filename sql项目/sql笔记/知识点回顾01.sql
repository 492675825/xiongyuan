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
































 
 
 
 
 
 










