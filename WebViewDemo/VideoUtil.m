//
//  THCaptureUtilities.m
//  ScreenCaptureViewTest
//
//  Created by wayne li on 11-9-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "VideoUtil.h"


@implementation VideoUtil


+ (NSString *)docDir{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = nil;
    if ([paths count] > 0) {
        docDir = [paths objectAtIndex:0];
    }
    return docDir;
}

+ (void)deleteFile:(NSString *)filePath{
    NSFileManager *fm = [[NSFileManager alloc] init];
    // 是否存在
    BOOL isExistsOk = [fm fileExistsAtPath:filePath];
    if (isExistsOk) {
        [fm removeItemAtPath:filePath error:nil];
        NSLog(@"file deleted:%@",filePath);
    }
    else {
        NSLog(@"file not exists:%@",filePath);
    }
    [fm release];
}

+ (void)deleteURL:(NSURL *)fileURL{
    NSFileManager *fm = [[NSFileManager alloc] init];
    // 是否存在
    BOOL isExistsOk = [fm fileExistsAtPath:[fileURL path]];
    if (isExistsOk) {
        [fm removeItemAtURL:fileURL error:nil];
        NSLog(@"file deleted:%@",fileURL);
    }
    else {
        NSLog(@"file not exists:%@",fileURL);
    }
    [fm release];
}

@end
