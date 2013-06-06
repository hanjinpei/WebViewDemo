//
//  DBSQLHelper.h
//  Play86
//
//  Created by FNT on 1/24/13.
//  Copyright (c) 2013 Play86. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

//数据库执行完标示
#define kDBResult @"result"

//数据库执行成功
#define kDBResultSuccess @"1"
//数据库执行失败
#define kDBResultFailure @"0"

/**
 * 数据库SQL基本封装和数据库操作对象
 * 
 * @author liuzh
 */
@interface BaseExecute : NSObject
{
    FMDatabase *db;
}
@property (nonatomic, retain) FMDatabase *db;

/**
 * @brief 执行sql
 * @param sql 数据库执行语句
 */
-(BOOL)executeUpdate:(NSString *) sql;

/**
 * @brief 执行sql
 * @param query sql语句
 * @param arguments sql中的站位符
 */
-(void)executeUpdate:(NSString *)query withArgumentsInArray:(NSArray *)arguments;

/**
 * 查询
 * @param sql 数据库执行语句
 * @return FMResultSet
 */
-(FMResultSet *)executeQuery:(NSString *) sql;

/**
 * 查询
 * @param query 基本查询语句
 * @param arguments 查询语句中的站位符
 * @return FMResultSet 返回的结果集
 */
-(FMResultSet *)executeQuery:(NSString *)query withArgumentsInArray:(NSArray *)arguments;

/**
 * @value 判断字符串是否为空
 * @param str 字符串
 * @return BOOL YES,非空;NO,是空
 */
- (BOOL)isEmpty:(NSString *)str;
@end
