//
//  UserNotice.m
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/20.
//  Copyright © 2018 harmony. All rights reserved.
//

#import "UserNotice.h"
#import <WebKit/WebKit.h>
@interface UserNotice ()
{
    WKWebView *_webView;
    HeadView *_headView;

}
@end

@implementation UserNotice

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configHeadView];
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    _webView = [[WKWebView alloc] initWithFrame: CGRectMake(0,_headView.bottom,self.view.width,ZJYDeviceHeight - (_headView.bottom - safeBottomHeight - 50)) configuration:wkWebConfig];
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"userNotice" ofType:@"docx"]];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];    // Do any additional setup after loading the view.
    [self.view addSubview:_webView];
}
- (void)configHeadView{
    _headView = [HeadView new];
    _headView.title = @"用户须知";
    _headView.hiddenback = NO;
    _headView.hiddenRightback = YES;
    DefineWeakSelf(welkself);
    _headView.backCallBack = ^{
        [welkself dismissViewControllerAnimated:YES completion:nil];
    };
    [_headView endRefresh];
    [self.view addSubview:_headView];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
