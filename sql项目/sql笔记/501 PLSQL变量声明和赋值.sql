
1.PL/SQL介绍
	Oracle PL/SQL语言（Procedural Language/SQL）是结合了结构化查询与Oracle自身过程控制为一体的强大语言，
	PL/SQL不但支持更多的数据类型，拥有自身的变量声明、赋值语句，而且还有条件、循环等流程控制语句。过
	程控制结构与SQL数据处理能力无缝的结合形成了强大的编程语言，可以创建过程和函数以及程序包。
	自带工具：sqlplus/sql developer
    第三方工具：plsql/navicat premium
	
	
	
	
  
2.PL/SQL基础
	2.1语法结构：PL/SQL块的语法
	[DECLARE                            -- 声明部分
		 --declaration statements]①     -- 声明变量、常量、游标等（声明的内容可以不在执行部分使用）
	BEGIN                               -- 执行部分
		 --executable statements  ②     -- 对于执行部分不能去定义变量等（使用的变量、常量、游标等必须在声明的内容中）
	[EXCEPTION                          -- 异常处理
		 --exception statements]  ③
	END;                                -- 分号不能省略
	
	注意： 每一个命令语句结束后面必须加分号
	
	
	特殊符号：
	:= 赋值     v_cnt := 6;  对变量赋值为6
	.. 连续值   1..6         表示1到6的整数
	** 求幂     3**2         3的2次方为9
	

    2.2声明与赋值
	声明变量或常量必须指明变量的数据类型,也可以声明变量时对变量初始化,变量声明必须在声明部分。
	变量名 数据类型[ :=初始值]
	代码演示：声明变量或常量（使用 CONSTANT 关键字声明常量）
	
	-- 1 没有变量/常量
	BEGIN
	  DBMS_OUTPUT.PUT_LINE('0601BI课程！');
	END;
	  
	  
    -- 2 变量申明
    DECLARE
  	v_sql VARCHAR2(20);
    BEGIN
  	v_sql :='20200601儿童节快乐！';
  	v_sql :='儿童节快乐！';
  	DBMS_OUTPUT.PUT_LINE(v_sql);
    END;
    
    -- 3 变量申明并赋值
    DECLARE
  	v_sql VARCHAR2(20) := '20200601儿童节快乐！';
    BEGIN
  	-- v_sql :='儿童节快乐！';  -- 变量可以被重新赋值
  	DBMS_OUTPUT.PUT_LINE(v_sql);
    END;
    
    
    -- 4 常量赋值
    DECLARE
  	v_sql CONSTANT VARCHAR2(20) := '20200601儿童节快乐！';
    BEGIN
  	-- v_sql :='儿童节快乐！';   -- 常量不能被重新赋值
  	DBMS_OUTPUT.PUT_LINE(v_sql);
    END;
    
    
    -- 5 异常部分
    DECLARE
  	v_1 NUMBER(6);
  	v_2 NUMBER(6);
    BEGIN
  	v_1 :=100;         -- 分子
  	v_2 :=&输入数字;   -- 分母（手工输入)
  	DBMS_OUTPUT.PUT_LINE(v_1/v_2);
    EXCEPTION
  	WHEN ZERO_DIVIDE
  	  THEN DBMS_OUTPUT.PUT_LINE('分母为0！'); 
    END;


    练习：设置三个变量,  v_1、v_2、v_3, 分别将自己的姓名、性别和专业赋值给这三个变量, 并将三个变量拼接在一起打印出来！
          如打印结果：姓名：张三  性别：男  专业：统 计学！
          DBMS_OUTPUT.PUT_LINE( '姓名：' || v_1 || ...);













	