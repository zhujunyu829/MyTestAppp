//
//  NSString+Cheak.m
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/20.
//  Copyright © 2018 harmony. All rights reserved.
//

#import "NSString+Cheak.h"

@implementation NSString (Cheak)
+ (BOOL)cheakIsNull:(NSString *)str notice:(NSString *)notice{
    if (!str || !str.length) {
        if (notice) {
            [AppAlertView showErrorMeesage:notice?:@""];
        }
        return YES;
    }
    return NO;
}

@end
