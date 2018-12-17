//
//  OrderCtr.m
//  SaleApp
//
//  Created by zjy on 2018/12/16.
//  Copyright © 2018年 hechangqiye. All rights reserved.
//

#import "OrderCtr.h"
#import "HistoryView.h"

@interface OrderCtr ()
{
    HeadView *_headView;
    UIView *_headBtnView;
    UIImageView *_selimgeView;
    UIButton *_currentbnt;
    HistoryView *_personHistory;
    HistoryView *_company;
}
@end

@implementation OrderCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configHeadView];
    [self configHeadbtnview];
    [self configHistory];
    self.view.backgroundColor = [UIColor whiteColor];

    // Do any additional setup after loading the view.
}
- (void)configHeadView{
    _headView = [HeadView new];
    [self.view addSubview:_headView];
}
- (void)configHistory{
    _personHistory = [[HistoryView alloc] initWithFrame:CGRectMake(0, _headView.bottom +50, _headView.width, self.view.height - (_headView.bottom +50))];;
    [self.view addSubview:_personHistory];
    _company = [[HistoryView alloc] initWithFrame:CGRectMake(0, _headView.bottom +50, _headView.width, self.view.height - (_headView.bottom +50))];
    [self.view addSubview:_company];
    
//    [_personHistory mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_headBtnView.mas_bottom);
//        make.width.equalTo(self.view.mas_width);
//        make.height.equalTo(self.view.mas_height).offset(-(50+_headView.height));
//    }];
//    [_company mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_headBtnView.mas_bottom);
//        make.width.equalTo(self.view.mas_width);
//        make.height.equalTo(self.view.mas_height).offset(-(50+_headView.height));
//    }];
    _personHistory.hidden = YES;
    
}
- (void)configHeadbtnview{

    UIView *headBtnView = [UIView new];
    headBtnView.backgroundColor = ZJYColorHex(@"#7D7D7D");
    [self.view addSubview:headBtnView];
    _headBtnView = headBtnView;
    [headBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView.mas_bottom);
        make.height.mas_offset(50);
        make.width.mas_equalTo(self.view.mas_width);
    }];
  
    
    _selimgeView.centerX = ZJYDeviceWidth/2.0;
    NSArray *btnArr = @[@"返回",@"企业订单",@"业务员订单"];
    float widht = ZJYDeviceWidth/btnArr.count;
    _selimgeView = [UIImageView new];
    _selimgeView.contentMode = UIViewContentModeScaleToFill;
    _selimgeView.image = [UIImage imageNamed:@"Navigation_Greenbottom"];
    [headBtnView addSubview:_selimgeView];
    _selimgeView.clipsToBounds = YES;
    headBtnView.clipsToBounds =YES;
    [_selimgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(widht +50);
        make.centerX.offset(0);
        make.height.equalTo(headBtnView.mas_height).offset(5);
        make.top.offset(-2);
    }];
    for (int i = 0; i < btnArr.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [headBtnView addSubview:btn];
        [btn setTitle:btnArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:ZJYColorHex(@"AAABAB") forState:UIControlStateNormal];
        [btn setTitleColor:ZJYColorHex(@"ffffff") forState:UIControlStateSelected];
        [headBtnView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(widht*i);
            make.width.equalTo(headBtnView.mas_width).dividedBy(3);
            make.height.equalTo(headBtnView.mas_height);
        }];
        btn.tag = 10+i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.selected = i ==1;
    }
}
- (void)btnAction:(UIButton *)sender{
    if (_currentbnt == sender) {
        return;
    }
    _currentbnt.selected = NO;
    sender.selected = YES;
    _currentbnt = sender;
    float widht  = ZJYDeviceWidth/3.0;
    switch (sender.tag -10) {
        case 0:
        {
//            [_selimgeView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.width.mas_equalTo(widht  +50);
//                make.left.offset(-30);
//                make.height.equalTo(_headView.mas_height).offset(10);
//                make.top.offset(-5);
//            }];
           
        }break;
        case 1:
        {
            _company.hidden = NO;
            _personHistory.hidden = YES;
            [_selimgeView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(widht );
                make.centerX.offset(0);
                make.height.equalTo(_headView.mas_height).offset(10);
                make.top.offset(-5);
            }];
        }break;
        case 2:
        {
            _company.hidden = YES;
            _personHistory.hidden = NO;
            [_selimgeView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(widht+50 );
                make.right.offset(30);
                make.height.equalTo(_headView.mas_height).offset(10);
                make.top.offset(-5);
            }];
        }break;
        default:
            break;
    }
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
