

1.表空间    
	（1）系统表空间      SYSTEM
	（2）临时表空间      temp
	（3）用户表空间      USERS
	（4）undo表空间      undotbs1
	（5）样例表空间      example
	（6）系统副本空间    SYSAUX

	-- 管理员查看表空间
	SELECT * FROM DBA_DATA_FILES;
	-- 查看数据库版本信息等
	SELECT * FROM v$version;
	
	
	
	
	2.同义词
	  私有同义词：拥有CREATE SYNONYM权限的用户（包括非管理员用户）即可创建私有同义词,创建的私有同义词只能由当前用户使用。
	  公有同义词：系统管理员可以创建公有同义词,公有同义词可以被所有用户访问。
		创建同义词
		CREATE [OR REPLACE] [PUBLIC] SYNONYM [schema.]synonym_name 
		FOR [schema.]object_name

		-- sys 用户
		-- SELECT * FROM DBA_SYNONYMS;
		CREATE OR REPLACE PUBLIC SYNONYM emp_copy FOR scott.emp;

		-- scott用户
		SELECT * FROM  emp_copy;
		
	

  
  
  
  
  