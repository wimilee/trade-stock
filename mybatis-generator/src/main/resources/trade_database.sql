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
   code                 varchar(32) not null  comment '������ʶ',
   nextId               bigint(21)  comment '��һ������ID',
   primary key (code)
);

alter table t_seq comment '���б�';

/*==============================================================*/
/* Table: t_trade_account                                       */
/*==============================================================*/
create table t_trade_account
(
   id                   bigint(16) not null auto_increment  comment '������ʶ',
   userId               bigint(16)  comment '�û�ID',
   accountNo            varchar(16) not null  comment '�����˺�',
   balance              double(12,2)  comment '���',
   tradeGroupId         bigint not null  comment '�˻���ID',
   active_time          datetime  comment '����ʱ��',
   status               tinyint(3) not null  comment '״̬(0:��Ч�� 1�������� 2�����ã�',
   primary key (id)
);

alter table t_trade_account comment '�û��˺ű�';

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
   id                   bigint not null auto_increment  comment '������ Ψһ��ʶ',
   tradeOrderId         bigint not null  comment '���׶�����',
   accountId            bigint not null  comment '�����˺�ID',
   stockId              bigint not null  comment '��ƱID',
   stockMarket          tinyint(3)  comment '��Ʊ�г�(0: �Ͻ����� 1�������2���۹ɣ� 3�����ɣ�',
   execVolume           int  comment '�ɽ�����',
   execPrice            double(8,2)  comment '�ɽ��۸�',
   execTime             datetime  comment '�ɽ�ʱ��',
   direction            tinyint(2) not null  comment '��������',
   profit               double(8,2)  comment 'ӯ��',
   commission           double(6,2)  comment 'Ӷ��',
   taxes                double(6,2)  comment '˰��',
   status               tinyint(2) not null  comment '״̬(0:��Ч��1����Ч��',
   primary key (id)
);

alter table t_trade_deal comment '�ɽ���¼��';

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
   id                   bigint not null auto_increment  comment '������ʶ',
   code                 varchar(32)  comment '��������',
   category             varchar(32)  comment '������(BASIC:�������ã� BUSINESS�� ҵ������,  SYSTEM��ϵͳ������)',
   value                varchar(128)  comment '�������ֵ',
   status               tinyint(2) not null  comment '״̬(0:���ã� 1�����ã�',
   primary key (id)
);

alter table t_trade_global_config comment 'ϵͳȫ�����ñ�';

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
   id                   bigint not null auto_increment  comment '������ʶ',
   groupNo              varchar(16) not null  comment '�˻�����',
   groupName            varchar(16) not null  comment '�˻�������',
   currency             double(12,2)  comment '���ױ��֣�CNY:����ң� HKD���۱ң�USD����Ԫ��',
   companyId            bigint not null  comment '��˾ID',
   commission_rate      double(2,2)  comment 'Ӷ������� ��λ��%',
   taxes_rate           double(2,2)  comment '˰�ѱ����� ��λ��%',
   level                tinyint(3)  comment '�˻��ȼ���0����ͨ��1��VIP��',
   status               tinyint(3) not null  comment '״̬(0:���ã� 1�����ã�',
   craeteTime           datetime  comment '����ʱ��',
   primary key (id)
);

alter table t_trade_group comment '�û��˻����';

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
   id                   bigint not null auto_increment  comment '������ʶ',
   accountId            bigint not null  comment '�����˺�ID',
   stockId              bigint not null  comment '��ƱID
             ',
   status               tinyint(3) not null  comment '״̬(0:���ɽ�, 1:���ֳɽ��� 2����ȫ�ɽ�, 3:�ֹ������� 4:ϵͳ����)',
   type                 tinyint(3) not null  comment '�ҵ�����(0:�м۵��� 1:�޼۵�)',
   direction            tinyint(2) not null  comment '��������',
   initVolume           int not null  comment '�ҵ�������',
   execVolume           int  comment '�ɽ�����',
   execPrice            double(8,2)  comment '�ɽ��۸�',
   execTime             datetime  comment '�ɽ�ʱ��',
   primary key (id)
);

alter table t_trade_order comment '������';

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
   id                   bigint not null auto_increment  comment '������ Ψһ��ʶ',
   tradeOrderId         bigint not null  comment '���׶�����',
   accountId            bigint not null  comment '�����˺�ID',
   stockId              bigint not null  comment '��ƱID',
   costPrice            double(8,2)  comment '�ɱ���',
   volume               int not null  comment '�ֲ�����',
   stockMarket          tinyint(3)  comment '��Ʊ�г�(0: �Ͻ����� 1�������2���۹ɣ� 3�����ɣ�',
   avgPrice             double(6,2) not null  comment '�ɽ�����',
   validSellVolume      int  comment '��������(T+1�ƶ�ʹ��)',
   profit               double(8,2)  comment 'ӯ��',
   execTime             datetime  comment '�ɽ�ʱ��',
   status               tinyint(2) not null  comment '״̬(0:��Ч��1����Ч��',
   interest             double(8,2)  comment '�ֲ��ۼ���Ϣ',
   primary key (id)
);

alter table t_trade_position comment '��λ��';

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
   id                   bigint not null auto_increment  comment '������ʶ',
   name                 varchar(16)  comment '����',
   code                 varchar(12)  comment '��Ʊ���',
   categoryId           bigint not null  comment '��Ʊ����ID',
   marketNo             tinyint(3)  comment '��Ʊ�г�(0: �Ͻ����� 1�������2���۹ɣ� 3�����ɣ�',
   currency             double(12,2)  comment '���ױ��֣�CNY:����ң� HKD���۱ң�USD����Ԫ��',
   unit                 int not null default 100  comment '��Ʊ��λ��Ĭ��Ϊ��100��',
   tag                  tinyint(3)  comment '��ǩ(0:��ͨ�� 1������)',
   status               tinyint(2) not null  comment '״̬(0:���ã� 1�����ã�',
   marketSource         varchar(32)  comment '������Դ',
   display_order        int  comment '��ʾ˳��, ��������',
   updateTime           datetime  comment '�޸�ʱ��',
   craeteTime           datetime  comment '����ʱ��',
   primary key (id)
);

alter table t_trade_stock comment '��Ʊ��Ϣ��';

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
   id                   bigint not null auto_increment  comment '������ʶ',
   name                 varchar(16)  comment '����',
   code                 varchar(12)  comment '������',
   status               tinyint(2) not null  comment '״̬(0:���ã� 1�����ã�',
   primary key (id)
);

alter table t_trade_stock_category comment '��Ʊ�����';

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
   id                   bigint(16) not null auto_increment  comment '������ʶ',
   userNo               varchar(16) not null  comment '�û����',
   name                 varchar(16)  comment '�û�����',
   userPwd              varchar(32) not null  comment '�û�����',
   phone                varchar(16)  comment '�绰����',
   companyId            bigint  comment '��˾ID',
   email                varchar(32)  comment '����',
   address              varchar(255)  comment '��ַ',
   lastLoginIp          varchar(32)  comment '���һ���û���½IP',
   lastLoginTime        datetime  comment '���һ�ε�½ʱ��',
   status               tinyint(3) not null  comment '״̬(0:��Ч�� 1�������� 2�����ã�',
   craeteTime           datetime  comment '����ʱ��',
   primary key (id)
);

alter table t_trade_user comment '�û���';

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
   id                   bigint not null auto_increment  comment '������ʶ',
   userId               bigint(16) not null  comment '�û�ID',
   bizType              tinyint(3)  comment 'ҵ�����ͣ�0�����֤�� 1�����п��� 2�����ÿ���',
   fileId               varchar(32)  comment '�ļ�ID',
   filename             varchar(64) not null  comment '�ļ�����',
   fileType             varchar(32)  comment '�ļ�����',
   filePath             varchar(255) not null  comment '�ļ�·��',
   status               tinyint(3) not null  comment '״̬(0:��Ч�� 1����Ч��',
   createTime           datetime  comment '����ʱ��',
   primary key (id)
);

alter table t_trade_user_file comment '�û��ļ���';

/*==============================================================*/
/* Index: idx_userId                                            */
/*==============================================================*/
create index idx_userId on t_trade_user_file
(
   userId
);

