
循环控制	
	PL/SQL提供了丰富的循环结构来重复执行一些列语句。Oracle提供的循环类型有：
	1.无条件循环LOOP-END LOOP语句
	2.WHILE + LOOP-END LOOP循环语句
	3.FOR + LOOP-END LOOP循环语句
	在上面的三类循环中EXIT用来强制结束循环。

	-- LOOP循环
	LOOP
		--循环体
	END LOOP;
	语法格式：
	1.循环体在LOOP和END LOOP之间,在每个LOOP循环体中,首先执行循环体中的语句序列,执行完后再重新开始执行。
	2.在LOOP循环中可以使用EXIT或者[EXIT WHEN 条件]的形式终止循环。否则该循环就是死循环。
	
	例题1：打印1到100数字（换行）
    -- 	LOOP循环
	DECLARE 
	  V_NUM NUMBER :=0;
	BEGIN
	  LOOP
		  V_NUM := V_NUM + 1;           -- 变量自增
		  DBMS_OUTPUT.PUT_LINE(V_NUM);   
		  EXIT WHEN V_NUM>=100;         -- 退出条件
	  END LOOP;
	END;
	
	
	-- WHILE循环（先判断条件,条件成立再执行循环体）
	WHILE 条件 LOOP
		--循环体
	END LOOP;
	
	DECLARE
	  V_NUM NUMBER :=1;
	BEGIN
	  WHILE V_NUM<=100 LOOP           -- 条件成立则循环
		DBMS_OUTPUT.PUT_LINE(V_NUM);
		V_NUM := V_NUM + 1;           -- 变量自增
	  END LOOP;
	END;
	
	
	
	-- FOR循环
	FOR 循环变量 IN [REVERSE] 循环下限..循环上限 LOOP
	--循环体
	END LOOP;
	FOR循环需要预先确定的循环次数,可通过给循环变量指定下限和上限来确定循环运行的次数,然后循环变量在每次循环中递增（或者递减）
	
	BEGIN
	  FOR V_NUM IN 1..100 LOOP        --  可以不声明变量,数字只能从小到大,在结果集中遍历
		DBMS_OUTPUT.PUT_LINE(V_NUM);
	  END LOOP;
	END;
	

	
	练习1：打印1到100之间的奇数
	练习2：打印10次当前时间(sysdate)
	练习3：执行 -1+2-3+4-5+...+100 的值(奇数前是负号,偶数前为+号)

	
	
	
	
	
	
	
	
	
	
	
	
	
	
