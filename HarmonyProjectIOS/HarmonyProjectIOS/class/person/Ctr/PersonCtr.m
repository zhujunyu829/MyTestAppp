//
//  PersonCtr.m
//  SaleApp
//
//  Created by zjy on 2018/12/16.
//  Copyright © 2018年 hechangqiye. All rights reserved.
//

#import "PersonCtr.h"
#import "LoginCtr.h"

@interface PersonCtr ()
{
    HeadView *_headView;
    UILabel *_nameLabel;
    UISwitch *_switch;

}
@end

@implementation PersonCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configHeadView];
    [self confiView];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}
- (void)configHeadView{
    _headView = [HeadView new];
    _headView.hiddenback = YES;
    _headView.title = @"我的";
    [_headView endRefresh];
    _headView.homeCallBack = ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:mainKey object:nil];
    };
    [self.view addSubview:_headView];
}

- (void)confiView{
    UILabel *title = [UILabel new];
    [self.view addSubview:title];
    title.font = ZJYSYFont(14);
    title.textColor = ZJYColorHex(@"#4C4948");
    title.textAlignment = NSTextAlignmentLeft;
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_headView.mas_bottom).offset(20);
        make.left.offset(40);
    }];
    title.text =@"姓名";
    
    _nameLabel = [UILabel new];
    [self.view addSubview:_nameLabel];
    _nameLabel.font = ZJYSYFont(14);
    _nameLabel.textColor = ZJYColorHex(@"#4C4948");
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.text = @"/";
    float width = ZJYDeviceWidth - 115;
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(width);
        make.centerY.equalTo(title.mas_centerY).offset(0);
    }];
    _nameLabel.layer.masksToBounds = YES;
    _nameLabel.layer.borderColor = ZJYColorHex(@"#A7A8A8").CGColor;
    _nameLabel.layer.borderWidth = 1;
    UIView *line = [self getLine];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(_nameLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(ZJYDeviceWidth);
    }];
    UILabel *noticeLable = [UILabel new];
    noticeLable.textColor = ZJYColorHex(@"#4C4948");
    noticeLable.font = ZJYSYFont(14);
    [self.view addSubview:noticeLable];
    [noticeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title.mas_left).offset(0);
        make.top.equalTo(line.mas_bottom).offset(15);

    }];
    noticeLable.text = @"授权电脑端下单";
    _switch = [[UISwitch alloc] init];
    [_switch addTarget:self action:@selector(swithcValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_switch];
    [_switch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(noticeLable.mas_centerY);
        make.right.equalTo(_nameLabel.mas_right);
    }];
    
    UIView *line1 = [self getLine];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(noticeLable.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(ZJYDeviceWidth);
    }];

    UIButton *logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:logOutBtn];
    logOutBtn.backgroundColor = ZJYColorHex(@"#019944");
    [logOutBtn setTitle:@"退出APP" forState:UIControlStateNormal];
    [logOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logOutBtn addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
    [logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width).multipliedBy(0.8);
        make.height.mas_equalTo(40);
        make.centerX.offset(0);
        make.top.equalTo(line1.mas_bottom).offset(30);
    }];
    
    UILabel *phoneLabel = [UILabel new];
    [self.view addSubview:phoneLabel];
    phoneLabel.textColor = ZJYColorHex(@"#4C4948");
    phoneLabel.text =@"软件反馈：0731-55519003";
    phoneLabel.font =ZJYSYFont(14);
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-(safeBottomHeight + 50+50));
        make.centerX.offset(0);
    }];
    
}
- (UIView *)getLine{
    UIView *lineView = [UIView new];
    lineView.backgroundColor = ZJYColorHex(@"#4C4948");
    return lineView;
}

- (void)logOut{
    DefineWeakSelf(weakSelf);
    [AppAlertView showTitle:@"确认退出" confirm:^{
        [weakSelf logOutAction];
    } cancel:^{
        
    }];
  
}
- (void)swithcValueChange:(UISwitch *)swthc{
    //apps/user/changeSwitch?pcSwitch=1
    [[RequestManger sharedClient] GET:@"apps/user/changeSwitch" parameters:@{@"pcSwitch":@(_switch.on)
                                                                         }
                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                                  NSDictionary *result = responseObject[@"result"];
                                  
                                 
                                  
                              }
                              failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                  
                              }];
}
- (void)logOutAction{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:tokenKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    LoginCtr *ctr = [LoginCtr new];
    [UIApplication sharedApplication].keyWindow.rootViewController = ctr;
}
- (void)getData{
    //apps/user/findUser
//    [_headView beginRefresh];
    [[RequestManger sharedClient] GET:@"apps/user/findUser" parameters:@{
                                                                      } showMessage:NO
                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                                  NSDictionary *result = responseObject[@"result"];
                                  _nameLabel.text = [NSString stringWithFormat:@"%@",result[@"districtName"]];
                                  _switch.on = [result[@"isPcOrder"] intValue];
                                  
                              }
                              failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                                                          
                                                                      }];
    
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
