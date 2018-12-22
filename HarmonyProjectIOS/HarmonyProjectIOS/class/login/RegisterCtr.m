//
//  RegisterCtr.m
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/20.
//  Copyright © 2018 harmony. All rights reserved.
//

#import "RegisterCtr.h"
#import "MainCtr.h"
#import "UserNotice.h"
@interface RegisterCtr ()
{
    HeadView *_headView;
    UITextField *_phone;
    UITextField *_password;
    UITextField *_name;
    UIButton *_senderBtn;
    UIButton *_logOutBtn;
}
@end

@implementation RegisterCtr


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configHeadView];
    [self confiView];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
- (void)configHeadView{
    DefineWeakSelf(weakSelf);
    _headView = [HeadView new];
    _headView.title = @"注册";
    _headView.hiddenRightback = YES;
    _headView.backCallBack = ^{
        [weakSelf backAction];
    };
    [_headView endRefresh];
    [self.view addSubview:_headView];
}
- (void)confiView{
    _phone = [self fieldWithLeftTitle:@"手机号码"];
    [self.view addSubview:_phone];
    
    _name = [self fieldWithLeftTitle:@"用户名"];
    _name.hidden = YES;
    [self.view addSubview:_name];
    
    _password = [self fieldWithLeftTitle:@"验证码"];
    [self.view addSubview:_password];
    
    
    
    UIView *line1 = [self getLine];
    [self.view addSubview:line1];
    
    UIView *line2 = [self getLine];
    [self.view addSubview:line2];
   
    UIView *line3 = [self getLine];
    [self.view addSubview:line3];
    
    UIView *line4 = [self getLine];
    [self.view addSubview:line4];
    
    line1.top = 20 +_headView.bottom;
    _phone.top = line1.bottom;
    line2.bottom = _phone.bottom;
//    _name.top = line2.bottom;
//    line3.bottom = _name.bottom;
    _password.top = line2.bottom;
    line4.top = _password.bottom;
//    _phone.text = @"13786143385";
    _senderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _senderBtn.width = 80;
    _senderBtn.height = _password.height - 20;
    [_senderBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_senderBtn setTitleColor:AppTextColor forState:UIControlStateNormal];
    _senderBtn.titleLabel.font = ZJYSYFont(14);
    _senderBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    _senderBtn.layer.masksToBounds = YES;
    _senderBtn.layer.borderColor = ZJYColorHex(@"#A7A8A8").CGColor;
    _senderBtn.layer.borderWidth = 1;
    _senderBtn.layer.cornerRadius = 2;
    _password.rightViewMode = UITextFieldViewModeAlways;
    _password.rightView = _senderBtn;
    
    UIButton *logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:logOutBtn];
    logOutBtn.backgroundColor = ZJYColorHex(@"#019944");
    [logOutBtn setTitle:@"注册并登录" forState:UIControlStateNormal];
    [logOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width).multipliedBy(0.8);
        make.height.mas_equalTo(40);
        make.centerX.offset(0);
        make.top.equalTo(_password.mas_bottom).offset(30);
    }];
    _logOutBtn = logOutBtn;
    UIButton *wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:wechatBtn];
    [wechatBtn setTitle:@"我同意《注册用户须知》" forState:UIControlStateNormal];
    [wechatBtn setTitleColor:ZJYColorHex(@"#019944") forState:UIControlStateNormal];
    wechatBtn.titleLabel.font = ZJYSYFont(12);
    [wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.centerX.offset(0);
        make.top.equalTo(logOutBtn.mas_bottom).offset(10);
    }];
    
    UIButton *bodyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:bodyBtn];
    [bodyBtn setImage:[UIImage imageNamed:@"anybody_selecte"] forState:UIControlStateNormal];
    [bodyBtn setImage:[UIImage imageNamed:@"anybody_selecte_on"] forState:UIControlStateSelected];
    bodyBtn.selected = YES;
    [bodyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.right.equalTo(wechatBtn.mas_left).offset(-5);
        make.centerY.equalTo(wechatBtn.mas_centerY);
    }];
    [bodyBtn addTarget:self action:@selector(bodyAction:) forControlEvents:UIControlEventTouchUpInside];

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
    NSString *phone = _phone.text;
    NSString *code = _password.text;
    NSString *name = _name.text;
    if ([NSString cheakIsNull:phone notice:@"请输入手机号码"]) {
        return;
    }
//    if ([NSString cheakIsNull:name notice:@"请输入用户名"]) {
//        return;
//    }
    if ([NSString cheakIsNull:code notice:@"请输入验证码"]) {
        return;
    }
    //apps/user/regist?moble=1&name=1&smsCode=1
    DefineWeakSelf(weakSelf);
    [[RequestManger sharedClient] GET:@"apps/user/regist" parameters:@{@"moble":phone?:@"",
                                                                       @"name":name?:@"",
                                                                      @"smsCode":code?:@""
                                                                      } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                                                                          NSString *token = responseObject[@"result"][@"tokenId"];
                                                                          [[NSUserDefaults standardUserDefaults] setObject:token?:@"" forKey:tokenKey];
                                                                          [[NSUserDefaults standardUserDefaults] synchronize];
                                                                          [weakSelf loginSuccess];
                                                                      } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                                                          
                                                                      }];
    
}
- (void)loginSuccess{
    MainCtr *mainCtr = [MainCtr new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainCtr];
    nav.navigationBarHidden = YES;
    [UIApplication sharedApplication].keyWindow.rootViewController = nav;
}



- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)weichatAction:(id)sender{
    UserNotice *ctr = [UserNotice new];
    [self presentViewController:ctr animated:YES completion:nil];
}
- (void)sentCodeAction:(id)sener{
    NSString *phone = _phone.text;
    if ([NSString cheakIsNull:phone notice:@"请输入手机号码"]) {
        return;
    }
    /*
     0/apps/user/getRegistSmsCode?moble=13786143385
     我的手机  10:47:53
     00/apps/user/regist?moble=1&name=1&smsCode=1
     */
    [self startTime];
     [_headView beginRefresh];
    [[RequestManger sharedClient] GET:@"apps/user/getRegistSmsCode" parameters:@{@"moble":phone?:@""
                                                                           } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                                                                       [_headView endRefresh];
                                                                           } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                                                             [_headView endRefresh];
                                                                           }];
}
- (void)bodyAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    _logOutBtn.backgroundColor = sender.selected?ZJYColorHex(@"#019944"):ZJYColorHex(@"999999");
    _logOutBtn.userInteractionEnabled = sender.selected;

}

-(void)startTime{
    
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_senderBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                _senderBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_senderBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                _senderBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
