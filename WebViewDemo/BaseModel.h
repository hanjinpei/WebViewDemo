//
//  BaseModel.h
//  PenPen
//
//  Created by FNT on 4/17/13.
//  Copyright (c) 2013 LiuChao. All rights reserved.
//

#import <Foundation/Foundation.h>

//自增长id
#define k_ID @"_ID"

//用户id（登陆帐号、邮箱、第三方帐号）
#define k_uid @"uid"

//时间戳
#define k_time @"time"

//数据1
#define k_data1 @"data1"

//数据2
#define k_data2 @"data2"

//分组id，系统分配，默认0
#define k_section_id @"section_id"

//名称
#define k_name @"name"

//备注/内容
#define k_notes @"notes"

//地址
#define k_address @"address"

//节日id
#define k_holiday_id @"holiday_id"

//类型
#define k_type @"type"

//好友id
#define k_friend_id @"friend_id"

//头像(URL)
#define k_avatar_url @"avatar_url"

//默认分组id＝0
#define k_default_section_id @"0"

//系统通知type=0
#define k_notification_type_system @"0"

//好友通知type=1
#define k_notification_type_friend @"1"

/**
 * 基础数据模型
 * Model-BaseModel－提供公用常量、属性
 * @author liuzh
 */
@interface BaseModel : NSObject<NSCopying>


//wjw 首字母
@property (nonatomic ,copy) NSString *strSZM;
//wjw


//自增长id
@property(nonatomic, assign) int ID;

//用户id（登陆帐号、邮箱、第三方帐号）
@property(nonatomic, retain) NSString *uid;

//时间戳
@property(nonatomic, retain) NSString *time;

//数据1
@property(nonatomic, retain) NSString *data1;

//数据2
@property(nonatomic, retain) NSString *data2;

//分组id，系统分配，默认0
@property(nonatomic, retain) NSString *section_id;

//名称
@property(nonatomic, retain) NSString *name;

//备注/内容
@property(nonatomic, retain) NSString *notes;

//地址
@property(nonatomic, retain) NSString *address;

//节日id
@property(nonatomic, retain) NSString *holiday_id;

//类型
@property(nonatomic, retain) NSString *type;

//好友id
@property(nonatomic, retain) NSString *friend_id;

//头像（URL）
@property(nonatomic, retain) NSString *avatar_url;
@end
