//
//  DBSQLHelper.m
//  Play86
//
//  Created by FNT on 1/24/13.
//  Copyright (c) 2013 Play86. All rights reserved.
//

#import "BaseExecute.h"
#import "DBManager.h"
#import "FMDatabase.h"


@interface BaseExecute ()

@end

@implementation BaseExecute

@synthesize db;

- (id)init {
    self = [super init];
    if (self) {
        db = [DBManager shareIsrance].dataBase;
    }
    return self;
}

/**
 * @brief 执行sql
 * @param sql 数据库执行语句
 */
-(BOOL)executeUpdate:(NSString *) sql{
    if (sql) {
        return [db executeUpdate:sql];
    }
    return NO;
}

/**
 * @brief 执行sql
 * @param query sql语句
 * @param arguments sql中的站位符
 */
-(void)executeUpdate:(NSString *)query withArgumentsInArray:(NSArray *)arguments
{
    if (query && arguments) {
        BOOL result = [db executeUpdate:query withArgumentsInArray:arguments];
        NSLog(@"result = %d",result);
    }
}

/**
 * 查询
 * @param sql 数据库执行语句
 * @return FMResultSet
 */
-(FMResultSet *)executeQuery:(NSString *) sql
{
    NSLog(@"sql = %@",sql);
    if (sql) {
       return [db executeQuery:sql];
    }
    return nil;
}

/**
 * 查询
 * @param query 基本查询语句
 * @param arguments 查询语句中的站位符
 * @return FMResultSet 返回的结果集
 */
-(FMResultSet *)executeQuery:(NSString *)query withArgumentsInArray:(NSArray *)arguments
{
    if (query && arguments) {
        return [db executeQuery:query withArgumentsInArray:arguments];
    }
    return nil;
}

/**
 * @value 判断字符串是否为空
 * @param str 字符串
 * @return BOOL YES,非空;NO,是空
 */
- (BOOL)isEmpty:(NSString *)str
{
    if (!str) {
        return NO;
    }
    if ([@"" isEqualToString:str]) {
        return NO;
    }
    return YES;
}
@end
