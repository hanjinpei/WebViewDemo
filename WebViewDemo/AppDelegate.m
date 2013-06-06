//
//  AppDelegate.m
//  WebViewDemo
//
//  Created by FNT on 5/24/13.
//  Copyright (c) 2013 WebViewDemo. All rights reserved.
//

#import "AppDelegate.h"
#import "WebViewViewController.h"
#import "DBManager.h"
#import "BaseExecute+Table.h"
#import "WebViewNavViewController.h"
#import "Product.h"
#import "RNCachingURLProtocol.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
     [NSURLProtocol registerClass:[RNCachingURLProtocol class]];
    // Create the master list for the main view controller.
	NSArray *listContent = [[NSArray alloc] initWithObjects:
                            [Product productWithType:@"Device" name:@"iPhone" url:@"http://www.ftms.com.cn/information/388.html"],
                            [Product productWithType:@"Device" name:@"iPod" url:@"http://59.151.109.230/eventftms/wangzhuan86/mobile/apply.html"],
                            [Product productWithType:@"Device" name:@"iPod touch" url:@"http://www.baidu.com"],
                            [Product productWithType:@"Desktop" name:@"iMac" url:@"http://www.google.com.hk"],
                            [Product productWithType:@"Desktop" name:@"Mac Pro" url:@"http://www.so.com"],
                            [Product productWithType:@"Portable" name:@"iBook" url:@"http://wanke.etao.com/user/signin.php"],
                            [Product productWithType:@"Portable" name:@"MacBook" url:@"http://www.meile.com"],
                            [Product productWithType:@"Portable" name:@"MacBook Pro" url:@"http://www.36kr.com"],
                            [Product productWithType:@"Portable" name:@"PowerBook" url:@"http://www.cocoachina.com"], nil];
    
    [[DBManager shareIsrance] init];
    BaseExecute *execute = [[BaseExecute alloc] init];
    [execute creatTable];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    
    
    WebViewNavViewController *webNav = [[WebViewNavViewController alloc] init];
    webNav.listContent = listContent;
    // Add create and configure the navigation controller.
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:webNav];
    self.window.rootViewController = navigationController;
    [webNav release];
    [navigationController release];
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
