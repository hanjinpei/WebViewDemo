//
//  BaseExecute+AvatarSQL.h
//  PenPen
//
//  Created by FNT on 4/18/13.
//  Copyright (c) 2013 LiuChao. All rights reserved.
//

#import "BaseExecute.h"
#import "AvatarModel.h"

/**
 * 头像信息表数据操作
 * Adapter-AvatarSQL
 * @author liuzh
 */
@interface BaseExecute (AvatarSQL)

/**
 * 添加头像信息
 * @param model 头像信息数据
 * @return BOOL YES, 成功;NO,失败
 */
-(BOOL)insertAvatarSQL:(AvatarModel *)model;

/**
 * 批量头像信息
 * @param arr 头像信息数组
 * @return BOOL YES, 成功;NO,失败
 */
-(BOOL)insertAvatarSQLWithArray:(NSArray *)arr;

/**
 * 删除头像信息
 * @param uid 用户id
 * @return BOOL YES, 成功;NO,失败
 */
-(BOOL)deleteAvatarSQLWithUid:(NSString *)uid;

/**
 * 更新头像信息，根据用户/好友uid进行修改
 * @param uid 用户/好友id
 * @param model 头像信息
 * @return BOOL YES, 成功;NO,失败
 */
-(BOOL)updateAvatarSQLWithUid:(NSString *)uid withData:(AvatarModel *)model;

/**
 * 查询头像信息
 * @param uid 用户id
 * @return NSArray 头像信息数据列表
 */
-(NSArray *)queryAvatarSQLWithUid:(NSString *)uid;
@end
