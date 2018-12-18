//
//  ConfirmOrderCtr.m
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/18.
//  Copyright © 2018 harmony. All rights reserved.
//

#import "ConfirmOrderCtr.h"
#import "ConfirmOrderCell.h"
#import "ProductModel.h"

typedef NS_ENUM(NSInteger,ConfirmOrderBottomTyp) {
    ConfirmOrderBottomTypTemp =10,
    ConfirmOrderBottomTypHistory,
    ConfirmOrderBottomTypOrder
};
@interface ConfirmOrderCtr ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_table;
    HeadView *_headView;
    UIView *_noticeView;
    UIButton *_confirmBtn;
}
@end

@implementation ConfirmOrderCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configHeadView];
    [self configBottomBtn];
    [self configNoticeView];
    [self configTable];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

#pragma  mark - configView
- (void)configHeadView{
    _headView = [HeadView new];
    _headView.title =@"订单";
    DefineWeakSelf(weakSelf);
    _headView.backCallBack = ^{
        [weakSelf backAction];
    };
    _headView.homeCallBack = ^{
        [weakSelf backAction];
    };
    [_headView endRefresh];
    [self.view addSubview:_headView];
}
- (void)configBottomBtn{
    NSArray *btnArr = @[@"存为模版",@"使用订单",@"确认订单"];
    float width = self.view.width/btnArr.count +1;
    float height = 40;
    for (int i = 0 ; i < btnArr.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:btn];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 2;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = ZJYColorHex(@"D9D9D9").CGColor;
        [btn setTitle:btnArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:ZJYColorHex(@"595757") forState:UIControlStateNormal];
        btn.backgroundColor = ZJYColorHex(@"ffffff");
        btn.tag = ConfirmOrderBottomTypTemp+i;
        [btn addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(width *i -1);
            make.height.mas_equalTo(height);
            make.width.mas_equalTo(width);
            make.bottom.offset(-(50+safeBottomHeight));
        }];
        if (i == 2) {
            _confirmBtn = btn;
        }
    }
}
- (void)configNoticeView{
    _noticeView = [UIView new];
    _noticeView.backgroundColor = ZJYColorHex(@"00A33E");
    [self.view addSubview:_noticeView];
    [_noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView.mas_bottom);
        make.width.equalTo(self.view.mas_width);
        make.left.offset(0);
        make.height.mas_equalTo(50);
    }];
}
- (void)configTable{
    _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _table.delegate =self;
    _table.dataSource = self;
    _table.tableFooterView = [UIView new];
    _table.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_table];
    [_table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_noticeView.mas_bottom);
        make.width.equalTo(self.view.mas_width);
        make.left.offset(0);
        make.bottom.mas_equalTo(-(40+50+safeBottomHeight));
    }];
}
#pragma mark - action
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ConfirmOrderCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ConfirmOrderCell"];
    if (!cell) {
        cell = [[ConfirmOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ConfirmOrderCell"];
    }
    [cell setModel:_dataArr[indexPath.row]];
    return cell;
    
    return [UITableViewCell new];
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
