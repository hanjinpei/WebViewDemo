//
//  BaseExecute+Table.m
//  Play86
//
//  Created by FNT on 1/25/13.
//  Copyright (c) 2013 Play86. All rights reserved.
//

#import "BaseExecute+Table.h"
#import "DBConstant.h"
#import "AvatarModel.h"



@interface BaseExecute (Tabel)

#pragma mark--用户帐号消息管理
-(void)account;
@end

@implementation BaseExecute (Table)

/**
 * @brief 判断数据库表是否存在
 * @param table 表名
 * @return BOOL yes 存在；no 不存在
 */
-(BOOL)isExistTable:(NSString *)table
{
    FMResultSet *set = [self.db executeQuery:[NSString stringWithFormat:@"select count(*) from sqlite_master where type ='table' and name = '%@'",table]];
    [set next];
    NSInteger count = [set intForColumnIndex:0];
    BOOL existTable = !!count;
    NSLog(@"existTable = %d",existTable);
    return existTable;
}

/**
 * @brief 创建表
 * @param table 表名
 * @param sql 表创建语句
 * @return BOOL yes 成功；no 不成功
 */
-(BOOL)creatTable:(NSString *)table withSql:(NSString *)sql
{
    BOOL res = NO;
    if ([self isExistTable:table]) {
        // TODO:是否更新数据库
        NSLog(@"%@表存在",table);
    } else {
        // TODO: 插入新的数据库
        res = [self.db executeUpdate:sql];
        if (!res) {
            NSLog(@"%@,%@,数据库创建失败",table,sql);
        } else {
            NSLog(@"%@,%@,数据库创建成功",table,sql);
        }
    }
    return res;
}

/**
 * @brief 创建表
 */
-(void)creatTable{
    //用户帐号消息管理
    [self avatar];
}

#pragma mark--头像信息表

-(void)avatar{
    NSString *ID = [NSString stringWithFormat:@"%@%@",k_ID,kSQLID];
    NSString *uid = [NSString stringWithFormat:@"%@%@%@",k_uid,kSQLTextNotNull,kUNIQUE];
    NSString *avatar = [NSString stringWithFormat:@"%@%@",k_avatar,kSQLTextNull];
    NSString *avatar_filepath = [NSString stringWithFormat:@"%@%@",k_avatar_filepath,kSQLTextNull];
    NSString *avatar_url = [NSString stringWithFormat:@"%@%@",k_avatar_url,kSQLTextNull];
    NSString *data = [NSString stringWithFormat:@"%@%@",k_data,kSQLBLOBNull];
    NSString *time = [NSString stringWithFormat:@"%@%@",k_time,kSQLTextNull];
    NSString *sqlAvatar = [NSString stringWithFormat:@"%@%@(%@,%@,%@,%@,%@,%@,%@);",kSQLCreate,kTableAvatar,ID,uid,avatar,avatar_filepath,avatar_url,data,time];
    NSLog(@"sqlAvatar=%@",sqlAvatar);
    [self creatTable:kTableAvatar withSql:sqlAvatar];
}

/**
 * @brief 更新表
 * @param table 表名
 * @param sql 更新表语句
 * @return BOOL yes 成功；no 不成功
 */
-(BOOL)updateTable:(NSString *)table withSql:(NSString *)sql
{
    BOOL res = NO;
    if ([self isExistTable:table]) {
        // TODO:存在表
        res = [self.db executeUpdate:sql];
        if (!res) {
            NSLog(@"%@,%@,更新失败",table,sql);
        } else {
            NSLog(@"%@,%@,更新成功",table,sql);
        }

    } else {
        // TODO: 不存在表
        NSLog(@"%@更新表不存在",table);
    }
    return res;

}
@end
