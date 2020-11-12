
SQL(Structured Query Language), 是一种结构化的查询语言简称。
主要是对数据库中数据进行分析、统计、处理、存储等操作。
SQL语句不区分大小写！但是在查某个值的时候,值要区分大小写！

 
-- 1.查询结构(不涉及分组计算)
	SELECT *|列名|表达式                -- * 表示表的所有列名称;多个列或者多个表达式用逗号分隔
	  FROM 表名|结果集                  -- 查看的对象为表或者结果集
	 WHERE 条件                         -- 多个条件用and/or/not 连接
	 ORDER BY 列名1 ASC, 列名2 DESC,... -- ASC 升序(默认),DESC 降序

	【注意】：SELECT 和 FROM 是必须要有的, 其它关键字看题目需求使用！
	
	-- 查看所有列
	SELECT * 
	  FROM student_info;
	-- 查看学号和姓名
	SELECT sno,sname
	  FROM student_info;
	-- 查看学号为6的学生信息
	SELECT *
	  FROM student_info
	 WHERE sno=6;
	-- 查看学号为6且专业为统计学
	SELECT *
	  FROM student_info
	 WHERE sno=6 AND major='统计学';
	-- 查看在2014年之后毕业的学生信息，按照毕业时间从前往后排序
	SELECT *
	  FROM student_info
	 WHERE graduated_year>2014
	 ORDER BY graduated_year;
	-- 查看在2014年之后毕业的学生信息，按照毕业时间从前往后排序，毕业时间相同的按照性别降序排
	SELECT *
	  FROM student_info
	 WHERE graduated_year>2014
	 ORDER BY graduated_year ASC, sex DESC;  -- 默认排序为asc升序
	 
 
 
 	练习：查询在2014年后毕业的,专业不为统计学的学生学号、姓名和专业,并按照毕业年份升序排列,年份一样的按照性别降序排列。
 
 
 
 
-- 2.表和字段的别名
	【用途】多表查询时候简化表名长度,字段给别名便于理解查询含义
	-- 字段给别名可以加AS 也可以不加AS, 表给别名不能加AS
	SELECT sno AS 学号,sname AS 姓名 FROM STUDENT_INFO e;  -- 学号为sno别名,姓名为sname别名,s 为表STUDENT_INFO的别名
    -- 当select中含有*, 以及其它字段或表达是, 一定要用表名.* 或者表别名.*
    SELECT e.*, sysdate AS 当前时间 FROM STUDENT_INFO e;   -- sysdate为系统日期函数, 看做一个表达式, 可以直接在select 中用
	SELECT STUDENT_INFO.*, sysdate AS 当前时间 FROM STUDENT_INFO;


-- 3.虚拟表
	SELECT 10/2 FROM DUAL;
	SELECT 1 AS 数字1, '1' AS 字符1 FROM DUAL;
	
	
-- 4.操作符（熟悉emp 和 dept表）
  算术运算,关系运算,和逻辑运算
  
  算术运算:+-*/
  SELECT 2+3, 6-4, 3*6, 5/2 
    FROM dual;
  -- 
  SELECT sno,
         2+3, 
         6-4, 
         3*6, 
         5/2 
    FROM student_info;  
    
  关系运算:> >= = < <= <> !=
  SELECT *
    FROM student_info
   WHERE sno>=3 AND sno<=6;  
  
  
  逻辑运算: NOT>AND>OR
  SELECT (CASE WHEN 1=1 OR 1=3 AND 1=2 THEN 1
               ELSE 2 
           END) AS FLAG
    FROM DUAL;  
	
	

-- 5.NULL操作（'',NULL）
	在查询条件中NULL值用IS NULL作条件,非NULL值用 IS NOT NULL做条件
	空值的一些特性：
	1、空值跟任何值进行算术运算,得到的结果都为空值
	2、空值跟任何值进行关系运算,得到的结果都为不成立
	3、空值不参与任何聚合运算
	4、排序的时候,空值永远是最大的
	-- 查询奖金为空
	SELECT * FROM EMP WHERE COMM IS NULL;
	-- 1
	SELECT e.*, COMM+100, SAL + COMM FROM EMP e;
	-- 2
	SELECT * FROM EMP WHERE COMM<>0;
	-- 3
	SELECT COUNT(COMM) FROM EMP;
	-- 4
	SELECT * FROM EMP ORDER BY COMM ASC;
		
		
		
-- 6.IN 操作
	查询出工作职责是'SALESMAN'或者'PRESIDENT'或者'ANALYST'的员工信息。
	SELECT ename,job FROM emp WHERE job = 'SALESMAN' OR job = 'PRESIDENT' OR job = 'ANALYST';
	SELECT ename,job FROM emp WHERE job IN ('SALESMAN','PRESIDENT','ANALYST');
	
	
-- 7.BETWEEN…AND…（包含边界从小到大顺序）
	查询列值包含在指定区间内的行,包含边界。
	查询工资大于等于1500且小于等于2000的员工信息。
	SELECT *
	  FROM emp
	 WHERE sal >=1500 AND sal <=2000;
	 
	SELECT *
	  FROM emp
	 WHERE sal BETWEEN 1500 AND 2000;
	 
	查询工资在1500到2000之间的员工信息
	SELECT *
	  FROM emp
	 WHERE sal >1500 AND sal <2000;
	 
	-- 查询不到值
	SELECT *
	  FROM emp
	 WHERE sal BETWEEN 2000 AND 1500;
	 
	 
-- 8.LIKE模糊查询（对字符串）
	字符匹配操作可以使用通配符'%'和'_':
	  %：代表零个或多个字符。
	  _：代表任意一个字符。 
	SELECT * FROM student_info WHERE sname LIKE '张%';
	SELECT * FROM student_info WHERE sname LIKE '张晓_';
	  
	练习：查询员工名称第二个字母为A, 最后一个字母为S的员工的姓名、工资。
	  
	  
	  
	  
	  
	  
	

