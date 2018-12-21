//
//  AppAlertView.m
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/17.
//  Copyright © 2018 harmony. All rights reserved.
//

#import "AppAlertView.h"
@interface AppAlertView(){
    UILabel *_titleLabel;
    UIButton *_confirmBtn;
    UIButton *_cancelBtn;
    
}
@end
@implementation AppAlertView
+ (void)showTitle:(NSString *)title confirm:(voidBlock)confirm cancel:(voidBlock)cancel{
    AppAlertView *alert = [AppAlertView new];
    alert.confirm = confirm;
    alert.cancel = cancel;
    [alert showMessage:title];
}
- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (void)showMessage:(NSString *)message{
    _titleLabel.text = message;
    [self show];
}
- (id)init{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        UIView *contentView = [[UIView alloc] init];
        [self addSubview:contentView];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.masksToBounds = YES;
        contentView.layer.borderColor = ZJYColorHex(@"019944").CGColor;
        contentView.layer.borderWidth = 1;
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.mas_width).multipliedBy(0.7);
            make.height.mas_equalTo(129);
            make.centerX.offset(0).centerY.offset(0);
        }];
        _titleLabel = [UILabel new];
        [contentView addSubview:_titleLabel];
        _titleLabel.backgroundColor = ZJYColorHex(@"019944");
        _titleLabel.textColor = ZJYColorHex(@"ffffff");
        _titleLabel.font = ZJYBodyFont(20);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(42);
            make.top.offset(0);
            make.width.equalTo(contentView.mas_width).offset(0);
            make.left.offset(0);
        }];
        _confirmBtn = [self bttonWithName:@"是"];
        _cancelBtn = [self bttonWithName:@"否"];
        [contentView addSubview:_confirmBtn];
        [contentView addSubview:_cancelBtn];
        self.backgroundColor =ZJYRGB(0, 0, 0, 0.45);
        _cancelBtn.backgroundColor = ZJYColorHex(@"727272");
        _confirmBtn.backgroundColor = ZJYColorHex(@"019944");
        [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentView.mas_centerX).offset(-20);
            make.centerY.equalTo(contentView.mas_centerY).offset(20);
            make.width.mas_equalTo(60);
        }];
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView.mas_centerX).offset(20);
            make.centerY.equalTo(contentView.mas_centerY).offset(20);
            make.width.mas_equalTo(60);
        }];
        [_cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAction:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (UIButton *)bttonWithName:(NSString *)name{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = ZJYBodyFont(18);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 2;
    return btn;
}

- (void)cancelAction:(id)sender{
    if (self.cancel) {
        self.cancel();
    }
    [self removeFromSuperview];
}

- (void)confirmAction:(id)sender{
    if (self.confirm) {
        self.confirm();
    }
    [self removeFromSuperview];
}

+ (void)showErrorMeesage:(NSString *)message{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    hud.userInteractionEnabled = NO;
    hud.removeFromSuperViewOnHide = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    hud.labelText = message;
    hud.mode = MBProgressHUDModeText;
    [hud show:YES];
    
//    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES].labelText = message ;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
    });
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
