数据清洗

----步骤
1.找到业务库对应系统数据库中的表（确认数据来源）
2.在数据仓库的ODS层建立目标表（增加2个字段,其它字段的长度相对拓长1倍）
3.确认数据抽取方式（增量/全量）和抽取频率
4.在Kettle的Spoon设计转换和作业（清洗规则）
5.设置定时调度任务（作业运行的时间以及作业之间的依赖）
6.检查数据同步情况（数据质量保证）





二、数据ETL
-- ODS层对接业务库数据
ods/ods
192.168.3.3/ods
全量同步数据并简单清洗（去重/缺省值/空格和分行符等）、转换（字段类型/字段格式/值映射/大小写等）、加载（录入数据）到ods层
1.连接业务库, 查看要同步的表结构和数据
2.在ODS建立目标表(字段长度扩充1倍),表结构和源表相同,同时上加2个字段(同步时间戳可以在ODS建表时候给定默认值) 
  表名：ODS_表名_cyk
  同步时间戳（到时分秒）：etl_dt  
  源系统编号：src_no
2.ETL转换和作业设计
  (1)全量还是增量抽取？
  (2)清洗数据规则？
  (3)设置转换和作业直接的依赖关系？
3.设置定时调度ETL作业
  (1)job的start设置定时（一直开着kettle）
  (2)windows--任务计划程序
  (2)linxu  --shell脚本+crontab设置
4.Kettle常用控件介绍
5.同步数据后,中文出现乱码,解决方法:
  命令参数:characterEncoding 
  值:utf8
  具体操作过程:
  https://blog.csdn.net/zhaohong_bo/article/details/88116189
  
吴老师(00D8611ABEF1对话) 17:58:09
-- 3个系统,每个系统100张表
ETL
1个转换对应1张表
1个作业关联20个转换
300个转换和15个作业

-- 每个系统1套转换流程
ELT
  
  
  
.kjb  作业后缀
.ktr  转换后缀

转换就可以搞定表的etl过程,为什么需要作业？
1.便于管理多个转换
2.可以在作业中设置各个转换之间的依赖关系
3.可以在作业中设置定时调度以及运行失败的邮件发送
  
  
  
  

8.Kettle优化（课后查看）
  https://blog.csdn.net/smooth00/article/details/64441362
  kettle 原理
  https://blog.csdn.net/gogoliub/article/details/52189010
  




9.Kettle作业定时调度
  1.在kettle 的kjb的start中设置定时（需要打开kettel的作业）
  2.WINDOWS定时设置--任务计划程序
    (1) bat脚本跑kettle作业和转换
    (2) 任务计划程序设置定时
  3.LINUX定时设置（linux系统上有kettle程序）-- 生产
    (1)开发和测试通过的kettle作业和转换上传到linux系统
    (2)shell脚本执行kettle作业和转换
    (3)crontab -e 设置shell定时运行
  4.用调度平台-- Control-M/ Azkaban等
    (1)开发和测试通过的kettle作业和转换上传到linux系统
    (2)shell脚本执行kettle作业和转换
	(3)在平台上设置sh脚本的依赖关系,设置定时调度
	

       https://blog.csdn.net/u010102390/article/details/80505451
  先在windows上开发和测试, 上线前要更改数据库的连接信息, 作业引用的转换路径,
  上传后还有更改作业和转换的可执行权限！
  
  
  
10.总结ETL过程的问题以及优化方法！！
	/*
	1.了解业务源系统，有数据同步的需求让你同步数据（业务库的只读账号密码）
	2.比如业务源数据来自mysql,同步src_employee数据库中的某些表（employee_data）
	3.查看employee_data的建表语句
	4.数仓是oracle，有贴源层ods
	5.在ods层建立employee_data表(字段长度加大1倍，数据类型更改)，表中新加两个字段etl_time(同步时间）和src_name(数据来源)
	6.kettle制作转换ktr文件和作业kjb（ETL过程）,第一次同步用全量，然后设置每日增量同步（用时间限定增量）
	7.现在windows的开发环境测试kettle转换和作业
	8.上传kettle转换和作业到linux(linux也部署kettle工具)
	9.用shell编写调度脚本（运行哪个转换ktr或作业kjb）
	10.如果没有调度系统（可以在linux上用crontab设置定时）
		crontab -e
		10 00 * * *   /home/hadoop/etl/test_job.sh >> /log/auto.out
		设置每天凌晨12点10分跑test_job.sh这个shell脚本
	11.如果有调度系统如ctm(control-m),或者azkaban等可视化工具
	12.比如azkaban
	   主要设置shell脚本直接的先后运行关系（依赖），以及定时作业，最后打包上传到服务