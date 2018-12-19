//
//  HistoryModel.h
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/19.
//  Copyright © 2018 harmony. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderModel : NSObject

@property (nonatomic, retain) NSNumber *piece;
@property (nonatomic, copy) NSString *productName;
@end

@interface HistoryModel : NSObject

@property (nonatomic, copy) NSString *orderDate;
@property (nonatomic, retain) NSNumber *orderNo;
@property (nonatomic, retain) NSArray *neworder;
@property (nonatomic, retain) NSArray *sourceOrder;
@property (nonatomic, assign) float neworderHeight;
@property (nonatomic, assign) float sourceHeight;
@end


NS_ASSUME_NONNULL_END
