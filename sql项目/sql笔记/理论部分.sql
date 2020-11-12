
理论部分

1.数据库和数据仓库区别
https://blog.csdn.net/sjmz30071360/article/details/80822085


2.BI系统结构常见
	业务数据库DB1   --|              |-- DM1
	业务数据库DB2   --|——>ODS——>DW——>|-- DM2——>RPT
	...             --|              |-- DM3
	|_________________|_____________________|_____|
			|                  |
		源系统          数据仓库架构体系    数据可视化
		
		
3.数据采集（ETL）
	https://blog.csdn.net/wl044090432/article/details/60329843
	一般采用ETL工具：Datastage、Informatica、Kettle、SSIS(SQL SERVER)、ODI(oracle)
	在技术上，ETL主要涉及到关联、转换、增量、调度和监控等几个方面！
	1.业务库到ODS采用工具还是存储过程？
	  同种数据库,一般采用存储过程（ETL工具占用资源比较大,消耗内存影响服务器）,不同数据库,采用ETL工具
	2.采集数据注意问题？
	  <1>抽取方式：
	     全量抽取
	     增量抽取：时间戳/触发器/全表比对/日志对比
	  <2>抽取频率：按天/按周/按月
	  <3>数据转换：数据格式的不一致、数据输入错误、数据不完整等等
	  <4>ETL工具的选择:
		在数据集成中该如何选择ETL工具呢？一般来说需要考虑以下几个方面：
		(1)对平台的支持程度。
		(2)对数据源的支持程度。
		(3)抽取和装载的性能是不是较高，且对业务系统的性能影响大不大，倾入性高不高。
		(4)数据转换和加工的功能强不强。
		(5)是否具有管理和调度功能。
		(6)是否具有良好的集成性和开放性。
	  <5>调度：shell/python脚本 + crontab, control-M,azkaban等
	  <6>调度时间：凌晨之后
	  
	  
4.建模
   https://segmentfault.com/a/1190000012882641
   1.范式建模（三范式）         -- 数仓比较常用  （不会造成数据的冗余）
   2.维度建模（维度表和事实表） -- 集市比较常用  （为了多维度的统计数据，一般做成大宽表）
   3.实体建模
   
   
   宽表和窄表、明细表和汇总表、事实表和维度表等
   https://www.cnblogs.com/Leo_wl/p/8515794.html
   https://www.cnblogs.com/xyg-zyx/p/9803580.html
   
   建模工具：ER-WIN、PowerDesigner
   通过对业务熟悉,采取相关的模型概念,设计表结构以及表之间的关联关系。
   最后导出建表语句到相应的数据库中生成表结构。
   
   
5.数据可视化（表格和图形）
  报表工具：SAP BO、Cognos、 Oracle BIEE、Qlikview、Tableau、Powerbi、Smartbi、FineBI、Finereport
  设计报表的表结构,编写存储过程或SQL加工报表数据,用工具制作报表。

   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
	  
	  
	  
	  
	  
	  
	  
	  
	  
		
		
		
	 
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	
	
	
	