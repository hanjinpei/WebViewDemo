//
//  WebViewViewController.m
//  WebViewDemo
//
//  Created by FNT on 5/24/13.
//  Copyright (c) 2013 WebViewDemo. All rights reserved.
//

#import "WebViewViewController.h"
#import "VideoUtil.h"
#import "BaseExecute+AvatarSQL.h"

@interface WebViewViewController ()
{
    NSMutableData *receiveData;
    BaseExecute *dbExecute;
}
@end

@implementation WebViewViewController

@synthesize webUrl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dbExecute = [[BaseExecute alloc] init];
    NSArray *dataArr = [dbExecute queryAvatarSQLWithUid:@"1"];
    AvatarModel *model;
    if (dataArr && [dataArr count] > 0) {
        model = [dataArr objectAtIndex:0];
    }else{
        model = [AvatarModel new];
    }
	
    //预约赏车最新图照
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = CGRectMake(0, 0, 320, 480 - 20 - 44);
    [webView setBackgroundColor:[UIColor clearColor]];
    webView.scalesPageToFit = YES;
    
    [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:webUrl]]];
    
    
//    if (model.data) {
//        [webView loadData:model.data MIMEType: @"text/html" textEncodingName: @"UTF-8" baseURL:nil];
//    }else{
//        NSMutableURLRequest * requests = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://59.151.109.230/eventftms/wangzhuan86/mobile/apply.html"]];
//                [requests setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
//                [webView loadRequest:requests];
//
//    }
    
//    NSString *file = [[VideoUtil docDir] stringByAppendingPathComponent:@"output_v.html"];
//    
//    NSFileManager *fm = [NSFileManager defaultManager];
//    BOOL isExistsOk = [fm fileExistsAtPath:file];
//    if ( isExistsOk) {
//        NSURL *url = [NSURL fileURLWithPath:file];
//        NSLog(@"url:%@",url);
//        NSURLRequest *request =[NSURLRequest requestWithURL:url];
//        [webView loadRequest:request];
//    }else{
//        NSMutableURLRequest * requests = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://59.151.109.230/eventftms/wangzhuan86/mobile/apply.html"]];
//        [requests setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
//        [webView loadRequest:requests];
//
//    }
    
    
    webView.delegate = self;
    [self.view addSubview:webView];
    [webView release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebView Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
	NSLog(@"webViewDidFinishLoad");
    //获取所有html:
    NSString *lJs = @"document.documentElement.innerHTML";
    //获取网页title:
    NSString *lJs2 = @"document.title";
    NSString *lHtml1 = [aWebView stringByEvaluatingJavaScriptFromString:lJs];
    NSString *lHtml2 = [aWebView stringByEvaluatingJavaScriptFromString:lJs2];
    
    
    
    
    
    
//    NSLog(@"lHtml1=%@",lHtml1);
    NSLog(@"lHtml2=%@",lHtml2);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError");
}

- (BOOL)webView:(UIWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
//    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    receiveData = [[NSMutableData data] retain];    
    return YES;
}

-(void)connection:(NSURLConnection *) connectiondidReceiveResponse:(NSURLResponse*)response
{
    [receiveData setLength:0];
}

-(void) connection:(NSURLConnection *) connection didReceiveData:(NSData *) data
{
    [receiveData appendData:data];
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [connection release];
    
    [receiveData release];
    NSLog(@"Connection failed! Error - %@",error);
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //do something with the data
    NSLog(@"succeeded  %d byte received",[receiveData length]);
//    NSLog(@"data=%@",[[NSString alloc] initWithData:receiveData  encoding:NSASCIIStringEncoding]);
//    NSString *file = [[VideoUtil docDir] stringByAppendingPathComponent:@"output_v.html"];
//    NSFileManager *fm = [NSFileManager defaultManager];
//    [fm removeItemAtPath:file error:nil];
//    [receiveData writeToFile:file atomically:YES];
    
    
    AvatarModel *model = [AvatarModel new];
    model.uid = @"1";
    model.data = receiveData;
    [dbExecute insertAvatarSQL:model];
    
    [connection release];
    [receiveData release];
}
@end
