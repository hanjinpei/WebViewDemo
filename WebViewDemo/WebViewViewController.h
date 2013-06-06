//
//  WebViewViewController.h
//  WebViewDemo
//
//  Created by FNT on 5/24/13.
//  Copyright (c) 2013 WebViewDemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic, retain) NSString *webUrl;
@end
