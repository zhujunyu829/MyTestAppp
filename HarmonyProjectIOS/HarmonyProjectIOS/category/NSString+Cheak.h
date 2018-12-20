//
//  NSString+Cheak.h
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/20.
//  Copyright © 2018 harmony. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Cheak)

+ (BOOL)cheakIsNull:(NSString *)str notice:(NSString *)notice;
@end

NS_ASSUME_NONNULL_END
