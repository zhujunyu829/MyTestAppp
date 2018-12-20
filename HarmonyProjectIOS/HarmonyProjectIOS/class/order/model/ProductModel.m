//
//  ProductModel.m
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/17.
//  Copyright © 2018 harmony. All rights reserved.
//

#import "ProductModel.h"
@implementation SeriesModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"productList" : [ProductModel class]};
}
@end
@implementation ProductModel

- (void)setCount:(int)count{
    self.piece = [NSNumber numberWithInt:count];
}
- (int)count{
    return self.piece.intValue;
}

@end
