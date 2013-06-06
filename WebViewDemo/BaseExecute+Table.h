//
//  BaseExecute+Table.h
//  Play86
//
//  Created by FNT on 1/25/13.
//  Copyright (c) 2013 Play86. All rights reserved.
//

#import "BaseExecute.h"

/**
 * 数据库
 * 表－SQL类目
 * @author liuzh
 */
@interface BaseExecute (Table)

/**
 * @brief 判断数据库表是否存在
 * @param table 表名
 * @return BOOL yes 存在；no 不存在
 */
-(BOOL)isExistTable:(NSString *)table;

/**
 * @brief 创建表
 * @param table 表名
 * @param sql 表创建语句
 * @return BOOL yes 成功；no 不成功
 */
-(BOOL)creatTable:(NSString *)table withSql:(NSString *)sql;

/**
 * @brief 创建表
 */
-(void)creatTable;

/**
 * @brief 更新表
 * @param table 表名
 * @param sql 更新表语句
 * @return BOOL yes 成功；no 不成功
 */
-(BOOL)updateTable:(NSString *)table withSql:(NSString *)sql;

@end
