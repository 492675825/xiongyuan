
Oracle常用单行函数有：
	数字函数：对数字进行计算,返回一个数字。
	日期函数：对日期和时间进行处理。
	字符函数：对字符串操作。


-- 1.数字函数
	ABS(x)           x绝对值                              SELECT ABS(-2) FROM DUAL;      -- 2   
	MOD(x,y)         x除以y的余数                         SELECT MOD(7,3) FROM DUAL;     -- 1   
	POWER(x,y)       x的y次幂                             SELECT POWER(2,3) FROM DUAL;   -- 8 
	ROUND(x[,y])     x在第y位四舍五入(默认四舍五入到整数) SELECT ROUND(2.989),ROUND(2.989,2),ROUND(5.989,-1) FROM DUAL; -- 3, 2.99, 10
	TRUNC(x[,y])     x在第y位截断(默认截断到整数)         SELECT TRUNC(2.989),TRUNC(2.989,2),TRUNC(5.989,-1) FROM DUAL; -- 2, 2.98, 0
	CEIL(x)          向上取整                              SELECT CEIL(2.13), CEIL(2.00),CEIL(-2.13) FROM DUAL;    -- 3, 2, -2
	FLOOR(x)         向下取整                              SELECT FLOOR(2.89),FLOOR(3.00),FLOOR(-2.89) FROM DUAL;  -- 2, 3,-3

	-- TRUNC配合日期使用
	TRUNC(d[,fmt])和ROUND(d[,fmt])对日期处理：
	TRUNC(d[,fmt])：
	fmt: 'DD'       截取到当月的当天 
	fmt: 'DDD'      截取到当月的当天（默认格式）
	fmt: 'D'        截取到当周的第一天 
	fmt: 'MM'       截取到当月的第一天 
	fmt: 'Q'        截取到当季度的第一天
	fmt: 'Y'        截取到当年的第一天
	SELECT SYSDATE,
		   TRUNC(SYSDATE),
		   TRUNC(SYSDATE,'DD'),
		   TRUNC(SYSDATE,'DDD'),
		   TRUNC(SYSDATE,'D'),    -- 周日为本周第一天
		   TRUNC(SYSDATE,'MM'),   -- 可以写成'MONTH'
		   TRUNC(SYSDATE,'Q'),    
		   TRUNC(SYSDATE,'Y')     -- 可以写成'YEAR'
	FROM DUAL;
	  
		
		

-- 2.日期函数
	ADD_MONTHS(d,n),在某一个日期d上,加上指定的月数n,返回计算后的新日期。d表示日期,n表示要加的月数（n可以为负值）
	SELECT ADD_MONTHS(SYSDATE, 1),
		   ADD_MONTHS(DATE'2019-08-30', -6),
		   ADD_MONTHS(DATE'2020-08-30', -6)
	  FROM DUAL;
	  
	LAST_DAY(d),返回指定日期当月的最后一天
	SELECT LAST_DAY(SYSDATE),LAST_DAY(DATE'2019-08-30') FROM DUAL;
	
	MONTHS_BETWEEN (date1, date2),用于计算date1和date2之间有几个月
	SELECT MONTHS_BETWEEN(TO_DATE('2014-3-21', 'yyyy-mm-dd'), TO_DATE('2014-1-10', 'yyyy-mm-dd')) mon_diff FROM DUAL;
	

    注意：日期可以加减数字,表示加减多少天;日期减去日期表示相隔多少天;日期不能相加
	SELECT DATE'2019-08-30'+6,
	       DATE'2019-08-30'-6,
		   DATE'2019-08-30'-DATE'2019-08-16'
      FROM DUAL;




-- 3.字符函数
	ASCII(x)                            返回字符x的ASCII码。
	CONCAT(x,y)                         连接字符串x和y。（|| 也可以连接字符串）
	LENGTH(x)                           返回x的长度。
	LENGTHB(x)                          返回x的字节长度
	LOWER(x)                            x转换为小写。
	UPPER(x)                            x转换为大写。
	REPLACE(x,old,new)                  替换字符     -- 在x中查找old,并替换为new。
	TRANSLATE(x,from_string,to_string)  替换字符     -- from_string 和 to_string 以字符为单位,对应字符一一替换。
	-------------------
	LTRIM(x[,trim_str])                 左边截去字符 -- 从x左边开始截去其中的trim_str字符串,直到不是为止,缺省则默认截去的为空格。
	RTRIM(x[,trim_str])                 右边截去字符 -- 从x右边开始截去其中的trim_str字符串,直到不是为止,缺省则默认截去的为空格。
	TRIM([trim_str FROM] x)             两边截去字符 -- 从x两边开始截去其中的trim_str字符串,直到不是为止,缺省则默认截去的为空格。
	-------------------
	INSTR(x, str[,start] [,n])          定位字符位置 -- 在x中查找str,可以指定从start位开始,第n次出现,省去的参数默认为1。
	SUBSTR(x,start[,length])            截取某段字符 -- 在x中从start位开始,截取length个字符,缺省length,默认到结尾。
	
	-- 示例
	SELECT ASCII('A') FROM DUAL;   -- 65
	-- 
	SELECT '0722' || 'BI' || '大数据' FROM DUAL;
	SELECT CONCAT(CONCAT('0722','BI'),'大数据') FROM DUAL;
	SELECT CONCAT(CONCAT('0722','BI'), (SELECT '大数据' FROM DUAL)) FROM DUAL;
	-- 
	SELECT LENGTH('A Ub 好'), LENGTHB('中国平安'), LENGTHB('abcd') FROM DUAL;
	--
	SELECT LOWER('Ab2'), UPPER('Ab2'), REPLACE('a2b3a','a','520') FROM DUAL;
	-- 
	SELECT REPLACE(REPLACE('a你好djl','a','3'),'b','4') FROM dual;
	SELECT TRANSLATE('a你好djl','ad','34') FROM dual;
	SELECT TRANSLATE('a你好djl','adj','34') FROM dual;
	
	------------------
	SELECT LTRIM(' a 1 '), RTRIM(' a 1 '), TRIM(' a 1 ')
	  FROM DUAL;  -- 默认截去空格
	SELECT * FROM student_info WHERE TRIM(sname)='蓝浪峰';
	
	------------------
    -- 从'0722BI大数据BI520'字符串中的第1位开始查看找'BI'，第1次出现的位置
    SELECT INSTR('0722BI大数据BI520', 'BI') FROM DUAL;      -- 5
    -- 从'0722BI大数据BI520'字符串中的第6位开始查看找'BI'，第1次出现的位置    
	SELECT INSTR('0722BI大数据BI520', 'BI',6) FROM DUAL;    -- 10
    -- 从'0722BI大数据BI520'字符串中的第5位开始查看找'BI'，第2次出现的位置    
	SELECT INSTR('0722BI大数据BI520', 'BI',5, 2) FROM DUAL; -- 10
    -- 从'0722BI大数据BI520'字符串中的第6位开始查看找'BI'，第2次出现的位置   
	SELECT INSTR('0722BI大数据BI520', 'BI',6, 2) FROM DUAL; -- 0
		
	--
	SELECT SUBSTR('ra badf', 2) FROM DUAL;    -- 从第2个字符截取到最后一个字符
	SELECT SUBSTR('ra badf', 2, 3) FROM DUAL; -- 从第2个字符截取3个字符
	SELECT SUBSTR('Hello SQL!', -4) FROM dual    --从倒数第4个字符开始，截取到末尾。返回'SQL!'
	SELECT SUBSTR('Hello SQL!', -4, 3) FROM dual --从倒数第4个字符开始，截取3个字符。返回'SQL'
	




练习1：2019年7月22日的情况
	1.当年的第一天和最后一天
	2.本月的第一天和最后一天
	3.本季的第一天和最后一天
	4.当天为当年的第几天
	5.本周的第一天和最后一天
	6.当年一共有多少天
	
		
练习2：从字符串中'1#qfq#3df#520#d234#dlaj#' 查找第3个#号和第4个#号之间的字符串

	
	
	
	
	
	
	
	
	
	
