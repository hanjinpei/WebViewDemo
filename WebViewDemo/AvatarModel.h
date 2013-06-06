//
//  Avatar.h
//  PenPen
//
//  Created by FNT on 4/17/13.
//  Copyright (c) 2013 LiuChao. All rights reserved.
//

#import "BaseModel.h"

//头像名
#define k_avatar @"avatar"

//头像(本地文件名)
#define k_avatar_filepath @"avatar_filepath"

//二进制数据
#define k_data @"data"

/**
 * 头像数据
 * Model-Avatar
 * @author liuzh
 */
@interface AvatarModel : BaseModel

//头像名
@property(nonatomic, retain) NSString *avatar;

//头像(本地文件名)
@property(nonatomic, retain) NSString *avatar_filepath;

//头像avatar_url(父类中有该属性)

//二进制数据
@property(nonatomic, retain) NSData *data;

@end
