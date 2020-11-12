

1. IF 语句

	-- IF-THEN
	IF 条件 THEN
		 --条件结构体
	END IF;
	DECLARE 
	  V_NUM1 NUMBER:= 10;
	  V_NUM2 NUMBER:= 30;
	BEGIN
	  IF V_NUM1>V_NUM2 THEN
		DBMS_OUTPUT.PUT_LINE(V_NUM1 ||'>' ||V_NUM2);
	  END IF;
	END;
	
	
	-- IF-THEN-ELSE
	IF 条件 THEN
		 --条件成立结构体
	ELSE
		 --条件不成立结构体
	END IF;
	DECLARE 
	  V_NUM1 NUMBER:= 10;
	  V_NUM2 NUMBER:= 30;
	BEGIN
	  IF V_NUM1>V_NUM2 THEN
		DBMS_OUTPUT.PUT_LINE(V_NUM1 ||'>' ||V_NUM2);
	  ELSE
		DBMS_OUTPUT.PUT_LINE(V_NUM1 ||'<=' ||V_NUM2); 
	  END IF;
	END;
	
	
	-- IF-THEN-ELSIF
	IF 条件1 THEN
		 --条件1成立结构体
	ELSIF 条件2 THEN
		 --条件2成立结构体
	ELSE
		 --以上条件都不成立结构体
	END IF;
	DECLARE 
	  V_NUM1 NUMBER:= 10;
	  V_NUM2 NUMBER:= 30;
	BEGIN
	  IF V_NUM1>V_NUM2 THEN
		DBMS_OUTPUT.PUT_LINE(V_NUM1 ||'>' ||V_NUM2);  -- 每个 then 面的语句结束都要加分号 
	  ELSIF V_NUM1=V_NUM2 THEN
		DBMS_OUTPUT.PUT_LINE(V_NUM1 ||'=' ||V_NUM2); 
	  ELSE      -- 可以没有此分支,有此分支一定不要加条件判断
		DBMS_OUTPUT.PUT_LINE(V_NUM1 ||'<' ||V_NUM2); 
	  END IF;   -- if 语句结束用 end if
	END;
	
	
	
2. CASE 语句

	CASE
	WHEN 表达式1 THEN 语句序列1;
	WHEN 表达式2 THEN 语句序列2;
	WHEN 表达式3 THEN 语句序列3;
	……
	ELSE 语句序列N;
	END CASE;
		
	DECLARE 
	  V_NUM1 NUMBER:= 10;
	  V_NUM2 NUMBER:= 30;
	BEGIN
	  CASE
		WHEN V_NUM1>V_NUM2 THEN
			DBMS_OUTPUT.PUT_LINE(V_NUM1 ||'>' ||V_NUM2); -- 每个 then 面的语句结束都要加分号
		WHEN V_NUM1=V_NUM2 THEN
			DBMS_OUTPUT.PUT_LINE(V_NUM1 ||'=' ||V_NUM2); 
		ELSE -- 可以没有此分支但是以上语句中必须有一个条件为真,如果有此分支一定不要加条件判断
			  DBMS_OUTPUT.PUT_LINE(V_NUM1 ||'<' ||V_NUM2);
	  END CASE;                             -- case 语句结束用 end case
	END;
	
	
	
  
  练习：1.查找员工编号7521的工资,如果工资小于1500则打印其编号和名字,
          如果工资大等于1500且小于等于2000则打印其编号、名字和工资,
          否则打印其编号、名字和奖金。
        2.查找员工编号7521的工资,如果工资小于1500,若其奖金小于500则奖金再加上100,否则奖金加上50;
          如果工资大于等于1500,若其奖金小于200则奖金加上80,否则奖金减去50.（提示：通过update更新comm）

			
			
			
			
			
			
			
			
			
			
			
			
			
			