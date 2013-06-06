//
//  BaseModel.m
//  PenPen
//
//  Created by FNT on 4/17/13.
//  Copyright (c) 2013 LiuChao. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

@synthesize strSZM;
@synthesize ID;
@synthesize uid;
@synthesize time;
@synthesize data1;
@synthesize data2;
@synthesize section_id;
@synthesize name;
@synthesize notes;
@synthesize address;
@synthesize holiday_id;
@synthesize type;
@synthesize friend_id;
@synthesize avatar_url;

- (void)dealloc
{
    //wjw
    [strSZM release];
    //wjw
    
    
    [uid release];
    [time release];
    [data1 release];
    [data2 release];
    [section_id release];
    [name release];
    [notes release];
    [address release];
    [holiday_id release];
    [type release];
    [friend_id release];
    [avatar_url release];
    
    [super dealloc];
}

- (id)copyWithZone:(NSZone *)zone{
    return self;
}
@end
