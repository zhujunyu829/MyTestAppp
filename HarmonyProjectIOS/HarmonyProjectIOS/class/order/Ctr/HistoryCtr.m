//
//  HistoryCtr.m
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/18.
//  Copyright © 2018 harmony. All rights reserved.
//

#import "HistoryCtr.h"
#import "HistoryModel.h"
#import "HistoryCell.h"

@interface HistoryCtr ()<UITableViewDelegate,UITableViewDataSource>
{
    HeadView *_headView;
    UITableView *_table;
    NSMutableArray *_dataArr;
}
@end

@implementation HistoryCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray new];
    [self configHeadView];
    [self configTable];
    [self requsetList];
    // Do any additional setup after loading the view.
}
- (void)configHeadView{
    _headView = [HeadView new];
    _headView.title =@"历史订单";
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
    HistoryModel *model = _dataArr[indexPath.section];

    return model.sourceHeight + model.neworderHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HistoryModel *model = _dataArr[section];
    
    UIView *headView = [UIView new];
    headView.width = tableView.width;
    headView.height = 30;
    headView.backgroundColor = ZJYColorHex(@"#D7D7D7");
    
    UILabel *textLabel = [UILabel new];
    textLabel.font = ZJYSYFont(14);
    textLabel.textColor = ZJYColorHex(@"#4C4948");
    textLabel.text = model.orderDate;
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
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryCell"];
    if (!cell) {
        cell = [[HistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HistoryCell"];
    }
    [cell setModel:_dataArr[indexPath.row]];
    return cell;
}
//apps/order/queryOrderList

- (void)requsetList{
    //apps/order/queryOrderList
    //apps/product/list
    [_headView beginRefresh];
    [[RequestManger sharedClient] GET:@"apps/order/queryOrderList" parameters:@{} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [_headView endRefresh];
        [_dataArr removeAllObjects];
        [_dataArr addObjectsFromArray:[HistoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]]];
        [_table reloadData];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [_headView endRefresh];
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
