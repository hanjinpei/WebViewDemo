//
//  DBConstant.h
//  Play86
//
//  Created by FNT on 1/24/13.
//  Copyright (c) 2013 Play86. All rights reserved.
//

/**
 * 数据库常量
 * 数据库名／表名／SQL语句
 * @author liuzh
 */

#ifndef Play86_DBConstant_h
#define Play86_DBConstant_h

#define kDBName @"webCached.sqlite" //数据库名称
#define kTableUser @"SUser"       //用户表
#define kTableAccount @"Account" //帐号表
#define kTableFriendInfo @"FriendInfo" //好友／个人信息表
#define kTableAvatar @"Avatar" //头像信息表
#define kTableRelationship @"Relationship" //关系帐号信息表
#define kTableFriendSection @"FriendSection" //分组信息表
#define kTableSchedule @"Schedule" //我的碰碰/日程信息表
#define kTablePengpeng @"Pengpeng" //我的碰碰/日程信息表
#define kTableHoliday @"Holiday" //日程信息表
#define kTableNotification @"Notification" //通知信息表
#define kTableFeedback @"Feedback" //反馈信息表
#define kTableSetting @"Setting" //设置信息表

#define kTableEmotions @"Emotions" //表情信息表 


//创建关键字
#define kSQLCreate @"CREATE TABLE "
//字段默认大小
#define kSQLDefaultSizs 100 
//主键字段
#define kSQLID @" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL"

//约束
#define kUNIQUE @" UNIQUE"

//字符串类型(不限制字符大小)
#define kSQLTextNotNull @" VARCHAR NOT NULL"
#define kSQLTextNull @" VARCHAR"

//字符串类型(限制字符大小)
#define kSQLTextWithSizeNotNull [NSString stringWithFormat:@" VARCHAR(%d) NOT NULL",kSQLDefaultSizs]
#define kSQLTextWithSizeNull [NSString stringWithFormat:@" VARCHAR(%d)",kSQLDefaultSizs]

//整型类型(不限制整型大小)
#define kSQLIntNotNull @" INTEGER NOT NULL"
#define kSQLIntNull @" INTEGER"

//整型类型(限制整型大小)
#define kSQLIntWithSizeNotNull [NSString stringWithFormat:@" INTEGER(%d) NOT NULL",kSQLDefaultSizs]
#define kSQLIntWithSizeNull [NSString stringWithFormat:@" INTEGER(%d)",kSQLDefaultSizs]

//浮点型类型(不限制浮点型大小)
#define kSQLFloatNotNull @" FLOAT NOT NULL"
#define kSQLFloatNull @" FLOAT"

//浮点型类型(限制浮点型大小)
#define kSQLFloatWithSizeNotNull [NSString stringWithFormat:@" FLOAT(%d) NOT NULL",kSQLDefaultSizs]
#define kSQLFloatWithSizeNull [NSString stringWithFormat:@" FLOAT(%d)",kSQLDefaultSizs]

//二进制数据流
#define kSQLBLOBNull @" BLOB"

#endif
