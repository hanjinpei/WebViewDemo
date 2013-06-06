//
//  DBManager.m
//  Play86
//
//  Created by FNT on 1/24/13.
//  Copyright (c) 2013 Play86. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
#import "DBConstant.h"

@interface DBManager ()

@end

@implementation DBManager

@synthesize dataBase;

static DBManager *dbManager = nil;

// 单例模式,获取管理类对象
+(DBManager *) shareIsrance
{
    if (!dbManager) {
		dbManager = [[DBManager alloc] init];
	}
	return dbManager;
}

- (id) init {
    self = [super init];
    if (self) {
        int state = [self initWithDBName:kDBName];
        if (state == -1) {
            NSLog(@"数据库初始化失败");
        } else {
            [self connect];
        }
    }
    return self;
}

/**
 * @brief 初始化数据库操作
 * @param name 数据库名称
 * @return 返回数据库初始化状态， 0 为 已经存在，1 为创建成功，-1 为创建失败
 */
- (int) initWithDBName : (NSString *) name {
    if (!name) {
		return -1;  // 返回数据库创建失败
	}
    // 沙盒Docu目录
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
	dbPath = [dir stringByAppendingString:[NSString stringWithFormat:@"/%@",name]];
	NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL exist = [fileManager fileExistsAtPath:dbPath];
    NSLog(@"dbPath = %@",dbPath);
    if (!exist) {
        return 0;
    } else {
        return 1;          // 返回 数据库已经存在
	}
}

// 连接数据库
- (void) connect {
	if (!dataBase)
    {
		dataBase = [[FMDatabase alloc] initWithPath:dbPath];
	}
	if (![dataBase open])
    {
		NSLog(@"不能打开数据库");
	}
    else
    {
        NSLog(@"数据库初始化成功");
    }
}

// 关闭数据库
- (void) close
{
    [dataBase close];
    dbManager = nil;
}
@end
