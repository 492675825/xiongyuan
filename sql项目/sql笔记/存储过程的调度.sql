/*---存储过程怎么定时调度---*/
1.DBMS_JOB.SUBMIT   -- 单个存储过程什么时候自动运行
2.shell/python 脚本连接数据库调用存储过程, 用linux的crontab -e 设置定时运行shell/python脚本
3.kettle 连接数据库调用存储过程
4.可视化调度工具:ctm(control-m,azkaban,oozie等)

















