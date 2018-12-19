//
//  HistoryModel.m
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/19.
//  Copyright © 2018 harmony. All rights reserved.
//

#import "HistoryModel.h"

@implementation HistoryModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"neworder" : [OrderModel class],@"sourceOrder" : [OrderModel class]};
}
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"neworder" : @"newOrder",
             };
}
- (float)neworderHeight{
    float height =self.neworder.count? 20:0;
    height += (self.neworder.count *20);
    return height;
}
- (float)sourceHeight{
    float height = 20;
    height += (self.sourceOrder.count *20);
    return height;
}
@end

@implementation OrderModel



@end
