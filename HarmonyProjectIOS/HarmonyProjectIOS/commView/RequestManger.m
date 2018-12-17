//
//  RequestManger.m
//  HarmonyProjectIOS
//
//  Created by zjy on 2018/12/17.
//  Copyright © 2018年 harmony. All rights reserved.
//

#import "RequestManger.h"
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

    }
    return self;
}

- (void )POST:(NSString *)URLString
   parameters:(id)parameters
      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@%@",APPURL,URLString];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:tokenKey];
    if (token && token.length) {
        [_manager.requestSerializer setValue:token?:@"" forHTTPHeaderField:@"Authentication-Key"];
    }
    [_manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}
- (void )GET:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@%@",APPURL,URLString];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:tokenKey];
    if (token && token.length) {
        [_manager.requestSerializer setValue:token?:@"" forHTTPHeaderField:@"Authentication-Key"];
    }
    [_manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}
@end
