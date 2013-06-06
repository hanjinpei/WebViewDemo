//
//  DBManager.h
//  Play86
//
//  Created by FNT on 1/24/13.
//  Copyright (c) 2013 Play86. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabaseAdditions.h"
#import "FMDatabase.h"

/**
 * 对数据链接进行管理，包括链接，关闭连接
 * 可以建立长连接 长连接
 * @author liuzh
 */
@interface DBManager : NSObject
{
    //数据库路径
    NSString *dbPath;
}

// 数据库操作对象，当数据库被建立时，会存在次至
@property (nonatomic, readonly) FMDatabase *dataBase;

// 单例模式
+(DBManager *) shareIsrance;

// 连接数据库
- (void) connect;

// 关闭数据库
- (void) close;
@end
