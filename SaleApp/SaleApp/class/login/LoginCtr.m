//
//  LoginCtr.m
//  SaleApp
//
//  Created by zjy on 2018/12/16.
//  Copyright © 2018年 hechangqiye. All rights reserved.
//

#import "LoginCtr.h"
#import "MainCtr.h"

@interface LoginCtr ()<UITextFieldDelegate>
{
    HeadView *_headView;
    UITextField *_phone;
    UITextField *_password;
    UIButton *_senderBtn;
}
@end

@implementation LoginCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configHeadView];
    [self confiView];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
- (void)configHeadView{
    _headView = [HeadView new];
    _headView.title = @"登陆";
    [_headView endRefresh];
    [self.view addSubview:_headView];
}
- (void)confiView{
    _phone = [self fieldWithLeftTitle:@"手机号码"];
    [self.view addSubview:_phone];
    _password = [self fieldWithLeftTitle:@"验证码"];
    [self.view addSubview:_password];
    
    UIView *line1 = [self getLine];
    [self.view addSubview:line1];
    
    UIView *line2 = [self getLine];
    [self.view addSubview:line2];
    
    UIView *line3 = [self getLine];
    [self.view addSubview:line3];
    
    line1.top = 20 +_headView.bottom;
    _phone.top = line1.bottom;
    line2.bottom = _phone.bottom;
    _password.top = line2.bottom;
    line3.bottom = _password.bottom;
    
    _senderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _senderBtn.width = 80;
    _senderBtn.height = _password.height - 20;
    [_senderBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_senderBtn setTitleColor:AppTextColor forState:UIControlStateNormal];
    _senderBtn.titleLabel.font = ZJYSYFont(14);
    _senderBtn.layer.masksToBounds = YES;
    _senderBtn.layer.borderColor = ZJYColorHex(@"#A7A8A8").CGColor;
    _senderBtn.layer.borderWidth = 1;
    _senderBtn.layer.cornerRadius = 2;
    _password.rightViewMode = UITextFieldViewModeAlways;
    _password.rightView = _senderBtn;

    UIButton *logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:logOutBtn];
    logOutBtn.backgroundColor = ZJYColorHex(@"#019944");
    [logOutBtn setTitle:@"登录" forState:UIControlStateNormal];
    [logOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width).multipliedBy(0.8);
        make.height.mas_equalTo(40);
        make.centerX.offset(0);
        make.top.equalTo(_password.mas_bottom).offset(30);
    }];
    
    UIButton *wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:wechatBtn];
    [wechatBtn setTitle:@"微信授权登录>" forState:UIControlStateNormal];
    [wechatBtn setTitleColor:ZJYColorHex(@"#019944") forState:UIControlStateNormal];
    wechatBtn.titleLabel.font = ZJYSYFont(12);
    [wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.centerX.offset(0);
        make.top.equalTo(logOutBtn.mas_bottom).offset(10);
    }];
    [wechatBtn addTarget:self action:@selector(weichatAction:) forControlEvents:UIControlEventTouchUpInside];
    [logOutBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [_senderBtn addTarget:self action:@selector(sentCodeAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (UITextField *)fieldWithLeftTitle:(NSString *)title{
    UITextField *fled = [UITextField new];
    fled.height = 50;
    fled.width = ZJYDeviceWidth -50;
    fled.left = 20;
    fled.keyboardType = UIKeyboardTypeASCIICapable;
    fled.font = ZJYSYFont(14);
    fled.placeholder = [NSString stringWithFormat:@"请输入%@",title];
    fled.leftViewMode = UITextFieldViewModeAlways;
    fled.delegate = self;
    UILabel *titleLabel = [UILabel new];
    titleLabel.textColor = AppTextColor;
    titleLabel.font = ZJYSYFont(14);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = title;
    titleLabel.width = 80;
    titleLabel.height= fled.height;
    fled.leftView = titleLabel;
    return fled;
}

- (UIView *)getLine{
    UIView *lineView = [UIView new];
    lineView.backgroundColor = ZJYColorHex(@"#4C4948");
    lineView.width = ZJYDeviceWidth;
    lineView.height = 1;
    return lineView;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)loginAction:(id)sener{
    
    MainCtr *mainCtr = [MainCtr new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainCtr];
    nav.navigationBarHidden = YES;
        [UIApplication sharedApplication].keyWindow.rootViewController = nav;
}
- (void)weichatAction:(id)sener{
    
}
- (void)sentCodeAction:(id)sener{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
