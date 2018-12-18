//
//  ProductModel.h
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/17.
//  Copyright © 2018 harmony. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SeriesModel : NSObject


@property (nonatomic, copy) NSString *seriesName;
@property (nonatomic, retain) NSNumber *seriesCode;
@property (nonatomic, retain)  NSNumber*seriesCount;
@property (nonatomic, retain) NSArray *productList;
@end

@interface ProductModel : NSObject
@property (nonatomic, copy) NSString *awardTemplateRemark;
@property (nonatomic, copy) NSString *coverPic;
@property (nonatomic, copy) NSString *packageRemark;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *specRemark;
@property (nonatomic, retain)  NSNumber *awardTemplateId;
@property (nonatomic, retain)  NSNumber *confirm;
@property (nonatomic, retain)  NSNumber *enabledNumbers;
@property (nonatomic, retain)  NSNumber *numbers;
@property (nonatomic, retain)  NSNumber *orderId;
@property (nonatomic, retain)  NSNumber *piece;
@property (nonatomic, retain)  NSNumber *productId;
@property (nonatomic, retain)  NSNumber *specId;
@property (nonatomic, assign) int count;
@end

NS_ASSUME_NONNULL_END
