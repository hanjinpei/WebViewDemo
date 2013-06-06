//
//  THCaptureUtilities.h
//  ScreenCaptureViewTest
//
//  Created by wayne li on 11-9-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuartzCore/QuartzCore.h>

@interface VideoUtil : NSObject

+ (NSString *)docDir;
+ (void)deleteFile:(NSString *)filePath;
+ (void)deleteURL:(NSURL *)fileURL;
@end
