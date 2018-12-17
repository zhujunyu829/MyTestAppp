//
//  OrderModel.m
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/17.
//  Copyright © 2018 harmony. All rights reserved.
//

#import "OrderModel.h"
#import "ProductModel.h"
@implementation OrderModel

- (id)init{
    self = [super init];
    if (self) {
        self.time = @"12月17日";
        int cout = arc4random()%10;
        self.productArr = [NSMutableArray new];
        for (int  i = 0; i <cout; i ++) {
            [self.productArr addObject:[ProductModel new]];
        }
    }
    return self;
}
@end
