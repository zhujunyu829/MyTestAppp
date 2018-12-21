//
//  RequestManger.m
//  HarmonyProjectIOS
//
//  Created by zjy on 2018/12/17.
//  Copyright © 2018年 harmony. All rights reserved.
//

#import "RequestManger.h"
#import "LoginCtr.h"

@interface RequestManger(){
    AFHTTPSessionManager *_manager;
}
@end
@implementation RequestManger

+ (instancetype)sharedClient
{
    static RequestManger *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [RequestManger new];

    });
    
    return _sharedClient;
}
- (id)init{
    self = [super init];
    if (self) {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:APPURL]];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer  = [AFJSONResponseSerializer serializer];
//        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}
- (void )POST:(NSString *)URLString
   parameters:(id)parameters
      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    [self POST:URLString parameters:parameters showMessage:YES success:success failure:failure];
}
- (void )GET:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    [self GET:URLString parameters:parameters showMessage:YES success:success failure:failure];

}
- (void )POST:(NSString *)URLString
   parameters:(id)parameters
  showMessage:(BOOL)show
      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@%@",APPURL,URLString];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:tokenKey];
    if (token && token.length) {
        [_manager.requestSerializer setValue:token?:@"" forHTTPHeaderField:@"Authentication-Key"];
    }
    [_manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *message = responseObject[@"message"];
        if (show && message) {
            [AppAlertView showErrorMeesage:message];
        }
        if ([responseObject isKindOfClass:[NSDictionary class]] && [responseObject[@"code"] intValue] == 1) {
            success(task,responseObject);
        }else{
            failure(task,[NSError new]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == 3840) {
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:tokenKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            LoginCtr *ctr = [LoginCtr new];
            [UIApplication sharedApplication].keyWindow.rootViewController = ctr;
            return ;
        }
        [AppAlertView showErrorMeesage:@"服务器异常"];
        
        failure(task,error);
    }];
}
- (void )GET:(NSString *)URLString
  parameters:(id)parameters
 showMessage:(BOOL)show
     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@%@",APPURL,URLString];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:tokenKey];
    if (token && token.length) {
        [_manager.requestSerializer setValue:token?:@"" forHTTPHeaderField:@"Authentication-Key"];
    }
    [_manager GET:url parameters:parameters?:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *message = responseObject[@"message"];
        if (show && message) {
            [AppAlertView showErrorMeesage:message];
        }
        if ([responseObject isKindOfClass:[NSDictionary class]] && [responseObject[@"code"] intValue] == 1) {
            success(task,responseObject);
        }else{
           
            failure(task,[NSError new]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == 3840) {
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:tokenKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            LoginCtr *ctr = [LoginCtr new];
            [UIApplication sharedApplication].keyWindow.rootViewController = ctr;
            return ;
        }
        [AppAlertView showErrorMeesage:@"服务器异常"];
        
        failure(task,error);
    }];
}

- (void)cheakHeartbeat{
    NSString *url = [NSString stringWithFormat:@"%@%@",APPURL,@"apps/user/heartbeat"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:tokenKey];
    if (token && token.length) {
        [_manager.requestSerializer setValue:token?:@"" forHTTPHeaderField:@"Authentication-Key"];
    }
    [_manager GET:url parameters:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"---->%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]] && [responseObject[@"code"] intValue] == 1) {
        }else{
            NSString *message = responseObject[@"message"];
            if (message) {
                [AppAlertView showErrorMeesage:message];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
   
}
@end
