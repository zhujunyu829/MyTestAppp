//
//  ProductModel.m
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/17.
//  Copyright © 2018 harmony. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

- (instancetype)init{
    self = [super init];
    if (self) {
        int i = arc4random()%100;
        self.name = [NSString stringWithFormat:@"叼嘴巴%d",i];
        self.money = 3*i;
        self.count = i;
    }
    return self;
}


@end
