
drop procedure if exists proc_sevend_fenqika_DayLoan;
-- 
create procedure proc_sevend_fenqika_DayLoan(in v_DateFrom varchar(10),in v_DateTo varchar(10),in v_dateType VARCHAR(4))
begin 
    /*
        目的：计算借款情况
        时间：2018-01-03
        编写：
    */

    set @dateFrom=v_DateFrom;
    set @dateTo=v_DateTo;
    set @dateType=v_dateType;
    set @dataType=10; 
    
	-- 删除数据支撑重跑
    delete from tb_common_loan where dateType=@dateType and dataType=@dataType and dateFrom=@dateFrom and dateTo=@dateTo;
    
	-- 临时表过度计算分期卡
    drop table if exists tmp_sevend_fenqika;
    create table `tmp_sevend_fenqika` (
      `loanCount` int(11)   DEFAULT '0' COMMENT '提现笔数',
      `loanPerCount` int(11)   DEFAULT '0' COMMENT '提现人数',
      `loanMoney` int(11)   DEFAULT '0' COMMENT '提现金额',
      `loanAvg` int(11)  DEFAULT '0' COMMENT '提现笔均',
      `loanPerAvg` int(11)   DEFAULT '0' COMMENT '提现人均',
      `sumLoanPeople` int(11)  DEFAULT '0' COMMENT '累计借款人数',
      `sumLoanMoney` bigint(20) DEFAULT '0' COMMENT '累计提现金额'
    ) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='助保贷分期提现情况';
    -- 插入临时表数据
    insert tmp_sevend_fenqika(loanCount,loanPerCount,loanMoney)
    select count(1),count(distinct customer_id),sum(principal/100)
      from ODS_QIDAI.t_loan_order_ok
     where success_time BETWEEN concat(@dateFrom,' 00:00:00') and concat(@dateTo,' 23:59:59')
       and biz_type=3
       and state=1; 
	   
	-- 插入目标表数据
	insert tb_common_loan(dateFrom,dateTo,dataType,dateType,
                          loanCount,loanPerCount,loanMoney,
                          loanAvg,loanPerAvg,sumLoanPeople,sumLoanMoney)
    select @dateFrom,@dateTo,@dataType,@dateType,
           loanCount,loanPerCount,loanMoney,
           loanAvg,loanPerAvg,sumLoanPeople,sumLoanMoney
      from tmp_sevend_fenqika;
	   

	-- 删除过度的临时表
    drop table if exists tmp_sevend_fenqika;
    commit;
	

end ;

-- 调用
call proc_sevend_fenqika_DayLoan('2017-06-01','2017-06-30','M');




























