/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2022/6/20 9:53:38                            */
/*==============================================================*/

USE trade_stock;

drop table if exists t_seq;

drop table if exists t_trade_account;

drop table if exists t_trade_deal;

drop table if exists t_trade_global_config;

drop table if exists t_trade_group;

drop table if exists t_trade_order;

drop table if exists t_trade_position;

drop table if exists t_trade_stock;


drop table if exists t_trade_stock_category;


drop table if exists t_trade_user;


drop table if exists t_trade_user_file;

/*==============================================================*/
/* Table: t_seq                                                 */
/*==============================================================*/
create table t_seq
(
   code                 varchar(32) not null  comment '主键标识',
   nextId               bigint(21)  comment '下一个序列ID',
   primary key (code)
);

alter table t_seq comment '序列表';

/*==============================================================*/
/* Table: t_trade_account                                       */
/*==============================================================*/
create table t_trade_account
(
   id                   bigint(16) not null auto_increment  comment '主键标识',
   userId               bigint(16)  comment '用户ID',
   accountNo            varchar(16) not null  comment '交易账号',
   balance              double(12,2)  comment '余额',
   tradeGroupId         bigint not null  comment '账户组ID',
   active_time          datetime  comment '开户时间',
   status               tinyint(3) not null  comment '状态(0:有效， 1：锁定， 2：禁用）',
   primary key (id)
);

alter table t_trade_account comment '用户账号表';

/*==============================================================*/
/* Index: idx_accountNo                                         */
/*==============================================================*/
create index idx_accountNo on t_trade_account
(
   accountNo
);

/*==============================================================*/
/* Table: t_trade_deal                                          */
/*==============================================================*/
create table t_trade_deal
(
   id                   bigint not null auto_increment  comment '主键， 唯一标识',
   tradeOrderId         bigint not null  comment '交易订单号',
   accountId            bigint not null  comment '交易账号ID',
   stockId              bigint not null  comment '股票ID',
   stockMarket          tinyint(3)  comment '股票市场(0: 上交所， 1：深交所，2：港股， 3：美股）',
   execVolume           int  comment '成交数量',
   execPrice            double(8,2)  comment '成交价格',
   execTime             datetime  comment '成交时间',
   direction            tinyint(2) not null  comment '买卖方向',
   profit               double(8,2)  comment '盈亏',
   commission           double(6,2)  comment '佣金',
   taxes                double(6,2)  comment '税费',
   status               tinyint(2) not null  comment '状态(0:有效，1：无效）',
   primary key (id)
);

alter table t_trade_deal comment '成交记录表';

/*==============================================================*/
/* Index: idx_accountId                                         */
/*==============================================================*/
create index idx_accountId on t_trade_deal
(
   accountId
);

/*==============================================================*/
/* Index: idx_orderId                                           */
/*==============================================================*/
create index idx_orderId on t_trade_deal
(
   tradeOrderId
);

/*==============================================================*/
/* Table: t_trade_global_config                                 */
/*==============================================================*/
create table t_trade_global_config
(
   id                   bigint not null auto_increment  comment '主键标识',
   code                 varchar(32)  comment '配置项编号',
   category             varchar(32)  comment '分类编号(BASIC:基础配置， BUSINESS： 业务配置,  SYSTEM：系统项配置)',
   value                varchar(128)  comment '配置项的值',
   status               tinyint(2) not null  comment '状态(0:启用， 1：禁用）',
   primary key (id)
);

alter table t_trade_global_config comment '系统全局配置表';

/*==============================================================*/
/* Index: idx_key                                               */
/*==============================================================*/
create index idx_key on t_trade_global_config
(
   code
);

/*==============================================================*/
/* Table: t_trade_group                                         */
/*==============================================================*/
create table t_trade_group
(
   id                   bigint not null auto_increment  comment '主键标识',
   groupNo              varchar(16) not null  comment '账户组编号',
   groupName            varchar(16) not null  comment '账户组名称',
   currency             double(12,2)  comment '交易币种（CNY:人民币， HKD：港币，USD：美元）',
   companyId            bigint not null  comment '公司ID',
   commission_rate      double(2,2)  comment '佣金比例， 单位：%',
   taxes_rate           double(2,2)  comment '税费比例， 单位：%',
   level                tinyint(3)  comment '账户等级（0：普通，1：VIP）',
   status               tinyint(3) not null  comment '状态(0:启用， 1：禁用）',
   craeteTime           datetime  comment '创建时间',
   primary key (id)
);

alter table t_trade_group comment '用户账户组表';

/*==============================================================*/
/* Index: idx_groupNo                                           */
/*==============================================================*/
create index idx_groupNo on t_trade_group
(
   groupNo
);

/*==============================================================*/
/* Table: t_trade_order                                         */
/*==============================================================*/
create table t_trade_order
(
   id                   bigint not null auto_increment  comment '主键标识',
   accountId            bigint not null  comment '交易账号ID',
   stockId              bigint not null  comment '股票ID
             ',
   status               tinyint(3) not null  comment '状态(0:待成交, 1:部分成交， 2：完全成交, 3:手工撤单， 4:系统撤单)',
   type                 tinyint(3) not null  comment '挂单类型(0:市价单， 1:限价单)',
   direction            tinyint(2) not null  comment '买卖方向',
   initVolume           int not null  comment '挂单的数量',
   execVolume           int  comment '成交数量',
   execPrice            double(8,2)  comment '成交价格',
   execTime             datetime  comment '成交时间',
   primary key (id)
);

alter table t_trade_order comment '订单表';

/*==============================================================*/
/* Index: idx_account_id                                        */
/*==============================================================*/
create index idx_account_id on t_trade_order
(
   accountId
);

/*==============================================================*/
/* Index: idx_stockid                                           */
/*==============================================================*/
create index idx_stockid on t_trade_order
(
   stockId
);

/*==============================================================*/
/* Table: t_trade_position                                      */
/*==============================================================*/
create table t_trade_position
(
   id                   bigint not null auto_increment  comment '主键， 唯一标识',
   tradeOrderId         bigint not null  comment '交易订单号',
   accountId            bigint not null  comment '交易账号ID',
   stockId              bigint not null  comment '股票ID',
   costPrice            double(8,2)  comment '成本价',
   volume               int not null  comment '持仓数量',
   stockMarket          tinyint(3)  comment '股票市场(0: 上交所， 1：深交所，2：港股， 3：美股）',
   avgPrice             double(6,2) not null  comment '成交均价',
   validSellVolume      int  comment '可卖数量(T+1制度使用)',
   profit               double(8,2)  comment '盈亏',
   execTime             datetime  comment '成交时间',
   status               tinyint(2) not null  comment '状态(0:有效，1：无效）',
   interest             double(8,2)  comment '持仓累计利息',
   primary key (id)
);

alter table t_trade_position comment '仓位表';

/*==============================================================*/
/* Index: idx_accountId                                         */
/*==============================================================*/
create index idx_accountId on t_trade_position
(
   accountId
);

/*==============================================================*/
/* Index: idx_orderId                                           */
/*==============================================================*/
create index idx_orderId on t_trade_position
(
   tradeOrderId
);

/*==============================================================*/
/* Table: t_trade_stock                                         */
/*==============================================================*/
create table t_trade_stock
(
   id                   bigint not null auto_increment  comment '主键标识',
   name                 varchar(16)  comment '名称',
   code                 varchar(12)  comment '股票编号',
   categoryId           bigint not null  comment '股票分类ID',
   marketNo             tinyint(3)  comment '股票市场(0: 上交所， 1：深交所，2：港股， 3：美股）',
   currency             double(12,2)  comment '交易币种（CNY:人民币， HKD：港币，USD：美元）',
   unit                 int not null default 100  comment '股票单位（默认为：100）',
   tag                  tinyint(3)  comment '标签(0:普通， 1：热门)',
   status               tinyint(2) not null  comment '状态(0:启用， 1：禁用）',
   marketSource         varchar(32)  comment '行情来源',
   display_order        int  comment '显示顺序, 升序排列',
   updateTime           datetime  comment '修改时间',
   craeteTime           datetime  comment '创建时间',
   primary key (id)
);

alter table t_trade_stock comment '股票信息表';

/*==============================================================*/
/* Index: idx_code                                              */
/*==============================================================*/
create unique index idx_code on t_trade_stock
(
   code
);

/*==============================================================*/
/* Table: t_trade_stock_category                                */
/*==============================================================*/
create table t_trade_stock_category
(
   id                   bigint not null auto_increment  comment '主键标识',
   name                 varchar(16)  comment '名称',
   code                 varchar(12)  comment '分类编号',
   status               tinyint(2) not null  comment '状态(0:启用， 1：禁用）',
   primary key (id)
);

alter table t_trade_stock_category comment '股票分类表';

/*==============================================================*/
/* Index: idx_code                                              */
/*==============================================================*/
create index idx_code on t_trade_stock_category
(
   code
);

/*==============================================================*/
/* Table: t_trade_user                                          */
/*==============================================================*/
create table t_trade_user
(
   id                   bigint(16) not null auto_increment  comment '主键标识',
   userNo               varchar(16) not null  comment '用户编号',
   name                 varchar(16)  comment '用户名称',
   userPwd              varchar(32) not null  comment '用户密码',
   phone                varchar(16)  comment '电话号码',
   companyId            bigint  comment '公司ID',
   email                varchar(32)  comment '邮箱',
   address              varchar(255)  comment '地址',
   lastLoginIp          varchar(32)  comment '最近一次用户登陆IP',
   lastLoginTime        datetime  comment '最近一次登陆时间',
   status               tinyint(3) not null  comment '状态(0:有效， 1：锁定， 2：禁用）',
   craeteTime           datetime  comment '创建时间',
   primary key (id)
);

alter table t_trade_user comment '用户表';

/*==============================================================*/
/* Index: idx_userNo                                            */
/*==============================================================*/
create index idx_userNo on t_trade_user
(
   userNo
);

/*==============================================================*/
/* Table: t_trade_user_file                                     */
/*==============================================================*/
create table t_trade_user_file
(
   id                   bigint not null auto_increment  comment '主键标识',
   userId               bigint(16) not null  comment '用户ID',
   bizType              tinyint(3)  comment '业务类型（0：身份证， 1：银行卡， 2：信用卡）',
   fileId               varchar(32)  comment '文件ID',
   filename             varchar(64) not null  comment '文件名称',
   fileType             varchar(32)  comment '文件类型',
   filePath             varchar(255) not null  comment '文件路径',
   status               tinyint(3) not null  comment '状态(0:有效， 1：无效）',
   createTime           datetime  comment '创建时间',
   primary key (id)
);

alter table t_trade_user_file comment '用户文件表';

/*==============================================================*/
/* Index: idx_userId                                            */
/*==============================================================*/
create index idx_userId on t_trade_user_file
(
   userId
);

