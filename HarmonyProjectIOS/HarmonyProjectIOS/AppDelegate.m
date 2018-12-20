//
//  AppDelegate.m
//  SaleApp
//
//  Created by zjy on 2018/12/16.
//  Copyright © 2018年 hechangqiye. All rights reserved.
//

#import "AppDelegate.h"
#import "MainCtr.h"
#import "LoginCtr.h"
#import "WXApi.h"
#import "BangDingCtr.h"

#define wxAppID @"wx76200bd38be01432"
#define wxSecret @"513f888727b34d81c57a6a55e897c978"
@interface AppDelegate ()<WXApiDelegate>
{
    
}
@property (nonatomic, strong) NSTimer               *refreshLoginTimer;//刷新登陆timer

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [WXApi registerApp:wxAppID ];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self cheakLogin];
    [self startRefreshLoginTimer];
    [self.window makeKeyWindow];
    return YES;
}

- (void)cheakLogin{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:tokenKey];

    BOOL isLogin = (token&& token.length);
    if (isLogin) {
        MainCtr *mainCtr = [MainCtr new];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainCtr];
        nav.navigationBarHidden = YES;
        self.window.rootViewController = nav;
    }else{
        LoginCtr *login = [LoginCtr new];
        self.window.rootViewController = login;
        [self.window makeKeyAndVisible];
    }
}

- (void) startRefreshLoginTimer
{
    //每3分钟刷新一次登录
    if (!self.refreshLoginTimer)
    {
        self.refreshLoginTimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(refreshLogin) userInfo:nil repeats:YES];
    }
}

- (void)refreshLogin
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:tokenKey];
    if (token && token.length) {
        [[RequestManger sharedClient] cheakHeartbeat];
    }else{
        [self.refreshLoginTimer invalidate];
    }

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//return [WXApi handleOpenURL:url delegate:self];
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}
-(void) onResp:(BaseResp*)resp{
    
    SendAuthResp *res = (SendAuthResp*)resp;
    NSString *urlString = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", wxAppID, wxSecret, res.code];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *responseData = [NSData dataWithContentsOfURL:url];
    NSError *error;
    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:&error];
  
    NSLog(@"responseDic = %@", responseDic);
    
    [self weichatOpenID:responseDic[@"openid"]];
}
- (void)weichatOpenID:(NSString *)openID{
    
    [[RequestManger sharedClient] GET:@"apps/user/validOpenId" parameters:@{@"openId":openID?:@""} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}
@end
