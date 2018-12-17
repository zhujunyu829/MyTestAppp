//
//  ProductModel.h
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/17.
//  Copyright © 2018 harmony. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) float money;
@property (nonatomic, assign) float count;
@property (nonatomic, copy) NSString *des;
@end

NS_ASSUME_NONNULL_END
