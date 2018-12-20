//
//  RequestManger.h
//  HarmonyProjectIOS
//
//  Created by zjy on 2018/12/17.
//  Copyright © 2018年 harmony. All rights reserved.
//

#import <Foundation/Foundation.h>

#define  APPURL @"http://134.175.70.113:8000/"
NS_ASSUME_NONNULL_BEGIN

@interface RequestManger : NSObject
+ (instancetype)sharedClient;
- (void )POST:(NSString *)URLString
   parameters:(id)parameters
  showMessage:(BOOL)show
      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (void )GET:(NSString *)URLString
  parameters:(id)parameters
 showMessage:(BOOL)show
     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void )POST:(NSString *)URLString
   parameters:(id)parameters
      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (void )GET:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void )TokenPOST:(NSString *)URLString
   parameters:(id)parameters
      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (void )TokenGET:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)cheakHeartbeat; 

@end

NS_ASSUME_NONNULL_END
