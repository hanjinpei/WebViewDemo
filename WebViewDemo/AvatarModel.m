//
//  Avatar.m
//  PenPen
//
//  Created by FNT on 4/17/13.
//  Copyright (c) 2013 LiuChao. All rights reserved.
//

#import "AvatarModel.h"

@implementation AvatarModel

@synthesize avatar;
@synthesize avatar_filepath;
@synthesize data;

-(NSString *)description{
    return [NSString stringWithFormat:@"uid=%@,avatar=%@,avatar_filepath=%@,avatar_url=%@,time=%@",self.uid,self.avatar,self.avatar_filepath,self.avatar_url,self.time];
}

- (void)dealloc
{
    [avatar release];
    [avatar_filepath release];
    [data release];

    [super dealloc];
}

@end
