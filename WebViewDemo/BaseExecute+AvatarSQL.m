//
//  BaseExecute+AvatarSQL.m
//  PenPen
//
//  Created by FNT on 4/18/13.
//  Copyright (c) 2013 LiuChao. All rights reserved.
//

#import "BaseExecute+AvatarSQL.h"
#import "DBConstant.h"

@implementation BaseExecute (AvatarSQL)

/**
 * 添加头像信息
 * @param model 头像信息数据
 * @return BOOL YES, 成功;NO,失败
 */
-(BOOL)insertAvatarSQL:(AvatarModel *)model{
    BOOL res;
    if (!model) {
        return NO;
    }
    if ([self.db open]) {
        res = [self.db executeUpdate:[self creatInsertSQL:model]];
        if (!res) {
            NSLog(@"error to insert data");
        } else {
            NSLog(@"succ to insert data");
        }
        [self.db close];
    }
    return res;
}

/**
 * 批量头像信息
 * @param arr 头像信息数组
 * @return BOOL YES, 成功;NO,失败
 */
-(BOOL)insertAvatarSQLWithArray:(NSArray *)arr{
    BOOL res;
    if (!arr || [arr count] <= 0) {
        return NO;
    }
    if ([self.db open]) {
        [self.db beginTransaction];
        @try {
            for (AvatarModel *model in arr) {
                res = [self.db executeUpdate:[self creatInsertSQL:model]];
                if (!res) {
                    NSLog(@"error to insert data");
                } else {
                    NSLog(@"succ to insert data");
                }
            }
        }
        @catch (NSException *exception) {
            [self.db rollback];
        }
        @finally {
            [self.db commit];
        }
        [self.db close];
    }
    return res;
}

-(NSString *)creatInsertSQL:(AvatarModel *)model{
    NSMutableString *keyStr = [[NSMutableString alloc] init];
    NSMutableString *valueStr = [[NSMutableString alloc] init];
    if ([self isEmpty:model.uid]) {
        [keyStr appendFormat:@",%@",k_uid];
        [valueStr appendFormat:@",'%@'",model.uid];
    }
    if ([self isEmpty:model.avatar]) {
        [keyStr appendFormat:@",%@",k_avatar];
        [valueStr appendFormat:@",'%@'",model.avatar];
    }
    if ([self isEmpty:model.avatar_filepath]) {
        [keyStr appendFormat:@",%@",k_avatar_filepath];
        [valueStr appendFormat:@",'%@'",model.avatar_filepath];
    }
    if ([self isEmpty:model.avatar_url]) {
        [keyStr appendFormat:@",%@",k_avatar_url];
        [valueStr appendFormat:@",'%@'",model.avatar_url];
    }
    if (model.data && [model.data length] > 0) {
        [keyStr appendFormat:@",%@",k_data];
        [valueStr appendFormat:@",'%@'",model.data];
    }
    if ([self isEmpty:model.time]) {
        [keyStr appendFormat:@",%@",k_time];
        [valueStr appendFormat:@",'%@'",model.time];
    }
    
    NSMutableString *sql = [NSMutableString stringWithFormat:@"insert into %@ (%@) values(%@)",kTableAvatar,keyStr,valueStr];
    
    //查找不合理语句
    NSRange ra1 = [sql rangeOfString:@"(,"];
    if (ra1.length > 0 && ra1.location > 0) {
        //替换不合理语句
        [sql replaceCharactersInRange:ra1 withString:@"("];
    }
    NSRange ra2 = [sql rangeOfString:@"values(,"];
    if (ra2.length > 0 && ra2.location > 0) {
        //替换不合理语句
        [sql replaceCharactersInRange:ra2 withString:@"values("];
    }
    NSLog(@"sql=%@",sql);
    return sql;
}

/**
 * 删除头像信息
 * @param uid 用户id
 * @return BOOL YES, 成功;NO,失败
 */
-(BOOL)deleteAvatarSQLWithUid:(NSString *)uid{
    BOOL res;
    if (![self isEmpty:uid]) {
        return NO;
    }
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@=?",kTableAvatar,k_uid];
    if ([self.db open]) {
        res = [self.db executeUpdate:sql withArgumentsInArray:[NSArray arrayWithObject:uid]];
        if (!res) {
            NSLog(@"error to delete data");
        } else {
            NSLog(@"succ to delete data");
        }
        [self.db close];
    }
    return res;
}

/**
 * 更新头像信息，根据用户/好友uid进行修改
 * @param uid 用户/好友id
 * @param model 头像信息
 * @return BOOL YES, 成功;NO,失败
 */
-(BOOL)updateAvatarSQLWithUid:(NSString *)uid withData:(AvatarModel *)model{
    BOOL res;
    if (![self isEmpty:uid] || !model ) {
        return NO;
    }
    NSMutableArray *data = [[NSMutableArray alloc] init];
    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendFormat:@"update %@ set ",kTableAvatar];
    if ([self isEmpty:model.avatar]) {
        [sql appendFormat:@",%@=?",k_avatar];
        [data addObject:model.avatar];
    }
    if ([self isEmpty:model.avatar_filepath]) {
        [sql appendFormat:@",%@=?",k_avatar_filepath];
        [data addObject:model.avatar_filepath];
    }
    if ([self isEmpty:model.avatar_url]) {
        [sql appendFormat:@",%@=?",k_avatar_url];
        [data addObject:model.avatar_url];
    }
    if (model.data && [model.data length] > 0) {
        [sql appendFormat:@",%@=?",k_data];
        [data addObject:model.data];
    }
    if ([self isEmpty:model.time]) {
        [sql appendFormat:@",%@=?",k_time];
        [data addObject:model.time];
    }
    [sql appendFormat:@" where %@=?",k_uid];
    [data addObject:uid];
    //查找不合理语句
    NSRange ra = [sql rangeOfString:@"set ,"];
    //替换不合理语句
    [sql replaceCharactersInRange:ra withString:@"set "];
    NSLog(@"sql=%@",sql);
    if ([self.db open]) {
        res = [self.db executeUpdate:sql withArgumentsInArray:data];
        if (!res) {
            NSLog(@"error to update data");
        } else {
            NSLog(@"succ to update data");
        }
        [self.db close];
    }
    return res;
}

/**
 * 查询头像信息
 * @param uid 用户id
 * @return NSArray 头像信息数据列表
 */
-(NSArray *)queryAvatarSQLWithUid:(NSString *)uid{
    if ([self isEmpty:uid]) {
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where %@=?",kTableAvatar,k_uid];
        NSLog(@"sql=%@",sql);
        if ([self.db open]) {
            FMResultSet *set = [self.db executeQuery:sql withArgumentsInArray:[NSArray arrayWithObject:uid]];
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            while ([set next]) {
                [arr addObject:[self getAvatarValues:set]];
            }
            [self.db close];
            return arr;
        }
    }
    return nil;
}

-(AvatarModel *)getAvatarValues:(FMResultSet *)set{
    AvatarModel *model = [AvatarModel new];
    model.uid = [set stringForColumn:k_uid];
    model.avatar = [set stringForColumn:k_avatar];
    model.avatar_filepath = [set stringForColumn:k_avatar_filepath];
    model.avatar_url = [set stringForColumn:k_avatar_url];
    model.data = [set dataForColumn:k_data];
    model.time = [set stringForColumn:k_time];
    NSLog(@"model:%@",[model description]);
    return model;
}
@end
