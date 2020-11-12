
空值转换函数
	NVL （列,默认值）	      如果列值为null,则使用默认值表示
	NVL2（列,返回值1,返回值2）如果列值不为null,返回结果1；如果列值为null,返回结果2
	
-- 1.NVL
	SELECT NVL(NULL,0),     -- 空转0
		   NVL(NULL,100),   -- 空转100
		   NVL('', 99),     -- 空字符转99
		   NVL(10, 100),    -- 非空不会转
		   NVL('AD',77)     -- 非空不会转
	  FROM DUAL;
	  
	  
-- 2.NVL2
	SELECT NVL2(NULL, 0, 1),       -- 空转1
		   NVL2('', 99, 2),        -- 空字符转2
		   NVL2(10, 3, 100),       -- 非空转3
		   NVL2('AD', 'AD', 7)     -- 非空转'AD'
	  FROM DUAL;

	
    例题：查看员工信息和其年薪
	SELECT EMP.*,
		   (NVL(SAL,0)+NVL(COMM,0))*12 AS 年薪
	  FROM EMP;
	  

练习：对EMP表中的奖金为空的转换为100,不为空的转换为88



			
			
			
			
			
			