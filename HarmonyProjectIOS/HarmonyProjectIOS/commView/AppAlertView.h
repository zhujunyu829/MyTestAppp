//
//  AppAlertView.h
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/17.
//  Copyright © 2018 harmony. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppAlertView : UIView


@property (nonatomic, copy) voidBlock confirm;
@property (nonatomic, copy) voidBlock cancel;

+ (void)showTitle:(NSString *)title confirm:(voidBlock)confirm cancel:(voidBlock)cancel;
- (void)show;
- (void)showMessage:(NSString *)message;

+ (void)showErrorMeesage:(NSString *)message;
@end

NS_ASSUME_NONNULL_END
