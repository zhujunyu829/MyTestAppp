//
//  OrderModel.h
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/17.
//  Copyright © 2018 harmony. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderModel : NSObject
@property (nonatomic, copy) NSString *time;
@property (nonatomic, retain) NSMutableArray *productArr;

@end

NS_ASSUME_NONNULL_END
