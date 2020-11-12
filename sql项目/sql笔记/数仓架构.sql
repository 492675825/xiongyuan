一.数据仓库体系架构
3层架构:           
-->ODS-->EDW-->DM(按部门划分不同集市)
说明：
     ODS 存放最近一周或一个月的业务原始数据；
     EDW 通过ODS按主题建模加工后的数据；
	 DM  通过EDW按部门进行维度建模加工的数据。

4层架构：
--ODS-->|
        |FDM-->ADM-->MDM
--HDS-->|
说明：
     ODS 存放最近一周或一个月的业务原始数据；
	 HDS 存放最近3年或5年的的业务原始数据；
     FDM 通过ODS和HDS主题建模加工后的数据；
	 ADM 为低粒度汇总数据，如按日周月季等汇总；
	 MDM 为面向应用层数据。

5层架构：
              |DWB
--ODS-->DWD-->|   -->DM-->ST
              |DWS
原文链接：https://blog.csdn.net/BabyFish13/article/details/90291668
说明：
	(1) ODS 数据准备层
		功能：ODS层是数据仓库准备区，为DWD层提供基础原始数据，可减少对业务系统的影响
		建模方式及原则：从业务系统增量抽取、保留时间由业务需求决定、可分表进行周期存储、数据不做清洗转换与业务系统数据模型保持一致、按主题逻辑划分 
	(2) DWD 数据明细层
		功能：为DW层提供来源明细数据，提供业务系统细节数据的长期沉淀，为未来分析类需求的扩展提供历史数据支撑
		建模方式及原则：数据模型与ODS层一致，不做清晰转换处理、为支持数据重跑可额外增加数据业务日期字段、可按年月日进行分表、用增量ODS层数据和前一天DWD相关表进行merge处理
	(3) DW(B/S) 数据汇总层
		功能：为DW、ST层提供细粒度数据，细化成DWB合DWS；
		DWB是根据DWD明细数据经行清晰转换，如维度转代理键、身份证清洗、会员注册来源清晰、字段合并、空值处理、脏数据处理、IP清晰转换、账号余额清洗、资金来源清洗等；
		DWS是根据DWB层数据按各个维度ID进行粗粒度汇总聚合，如按交易来源，交易类型进行汇合
		建模方式及原则：聚合、汇总增加派生事实；关联其它主题的事实表，DW层可能会跨主题域；DWB保持低粒度汇总加工数据，DWS保持高粒度汇总数据；数据模型可能采用反范式设计，合并信息等。
	(4) DM 数据集市层
		功能：可以是一些宽表，是根据DW层数据按照各种维度或多种维度组合把需要查询的一些事实字段进行汇总统计并作为单独的列进行存储；满足一些特定查询、数据挖掘应用；应用集市数据存储
		建模方式及原则：尽量减少数据访问时计算，优化检索；维度建模，星型模型；事实拉宽，度量预先计算；分表存储

	(5) ST 数据应用层
		功能：ST层面向用户应用和分析需求，包括前端报表、分析图表、KPI、仪表盘、OLAP、专题等分析，面向最终结果用户；适合作OLAP、报表模型，如ROLAP,MOLAP；根据DW层经过聚合汇总统计后的粗粒度事实表
		建模方式及原则：保持数据量小；维度建模，星形模型；各位维度代理键+度量；增加数据业务日期字段，支持数据重跑；不分表存储

		
最难：需求分析、模型设计

工作量最大：ETL（60-80%）

标准化：格式，缺省值，类型，长度，范围，去空格

Load: delete/rebuild index/RI

数据源调研：值域，空值，主外键，数据字典，ER关系，样本数据，业务规则

处理： Reject,error, rerun.

不要绝对正确，但要知道为什么不正确（统计口径）

























