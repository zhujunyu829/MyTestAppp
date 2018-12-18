//
//  HistoryCtr.m
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/18.
//  Copyright © 2018 harmony. All rights reserved.
//

#import "HistoryCtr.h"

@interface HistoryCtr ()<UITableViewDelegate,UITableViewDataSource>
{
    HeadView *_headView;
    UITableView *_table;

}
@end

@implementation HistoryCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configHeadView];
    [self configTable];
    // Do any additional setup after loading the view.
}
- (void)configHeadView{
    _headView = [HeadView new];
    _headView.title =@"商城";
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
- (void)configTable{
    _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _table.delegate =self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    [_table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.bottom.offset(-(50+safeBottomHeight));
        make.top.equalTo(_headView.mas_bottom);
    }];
}
#pragma mark - action
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [UIView new];
    headView.width = tableView.width;
    headView.height = 30;
    headView.backgroundColor = ZJYColorHex(@"#D7D7D7");
    
    UILabel *textLabel = [UILabel new];
    textLabel.font = ZJYSYFont(14);
    textLabel.textColor = ZJYColorHex(@"#4C4948");
    textLabel.text = @"12月17日";
    textLabel.left = 15;
    textLabel.height = headView.height;
    textLabel.width = 120;
    [headView addSubview:textLabel];
    return headView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
