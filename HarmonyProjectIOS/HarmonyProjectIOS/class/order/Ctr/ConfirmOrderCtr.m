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
    ConfirmOrderBottomTypSaveTemp =10,
    ConfirmOrderBottomTypTemp,
    ConfirmOrderBottomTypOrder
};
@interface ConfirmOrderCtr ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_table;
    HeadView *_headView;
    UIView *_noticeView;
    UIButton *_confirmBtn;
    UIView *_countView;
    NSMutableArray *_useTemplateArr;

}
@end

@implementation ConfirmOrderCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configHeadView];
    [self configBottomBtn];
    [self configNoticeView];
    [self configTable];
    [self configCountView];
    _useTemplateArr = [NSMutableArray new];
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
- (void)configCountView{
    _countView = [UIView new];
    _countView.width = self.view.width;
    _countView.height = 50;
    _table.tableFooterView = _countView;
    _countView.backgroundColor = [UIColor whiteColor];
    
    UILabel *coutLabel = [UILabel new];
    [_countView addSubview:coutLabel];
    
    UILabel *totalLabel = [UILabel new];
    [_countView addSubview:totalLabel];
    
    UILabel *moneyLable = [UILabel new];
    [_countView addSubview:moneyLable];
    
    [coutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(12.5);
        make.right.offset(-15);
    }];
    
    [moneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(37.5);
        make.right.offset(-15);
    }];
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(moneyLable.mas_centerY);
        make.right.equalTo(moneyLable.mas_left).offset(-15);
    }];
    
}
- (void)configBottomBtn{
    NSArray *btnArr = @[@"存为模版",@"使用模版",@"确认订单"];
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
        btn.tag = ConfirmOrderBottomTypSaveTemp+i;
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
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
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
- (void)bottomAction:(UIButton *)sender{
    switch (sender.tag ) {
        case ConfirmOrderBottomTypTemp:
        {
            [self requsetuseTemplate];
        }break;
        case ConfirmOrderBottomTypSaveTemp:
        {
            [self saveTemplate];
        }break;
        case ConfirmOrderBottomTypOrder:
        {
            
        }break;
    }
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SeriesModel *model = self.dataArr[section];

    UIView *headView = [UIView new];
    headView.width = tableView.width;
    headView.height = 30;
    headView.backgroundColor = ZJYColorHex(@"#D7D7D7");
    
    UILabel *textLabel = [UILabel new];
    textLabel.font = ZJYSYFont(14);
    textLabel.textColor = ZJYColorHex(@"#4C4948");
    textLabel.text = model.seriesName;
    textLabel.left = 15;
    textLabel.height = headView.height;
    textLabel.width = 120;
    [headView addSubview:textLabel];
    return headView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SeriesModel *model = self.dataArr[section];
    
    return model.productList.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ConfirmOrderCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ConfirmOrderCell"];
    if (!cell) {
        cell = [[ConfirmOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ConfirmOrderCell"];
    }
    SeriesModel *model = self.dataArr[indexPath.section];
    [cell setModel:model.productList[indexPath.row]];
    return cell;
    
    return [UITableViewCell new];
}
#pragma mark- requset
- (void)requsetuseTemplate{
    //apps/order/useTemplate
    [[RequestManger sharedClient] GET:@"apps/order/useTemplate" parameters:@{} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        [_useTemplateArr removeAllObjects];
        [_useTemplateArr addObjectsFromArray:[SeriesModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"seriesList"]]];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
    }];
}
- (void)saveTemplate{
    //apps/order/savecollect?qbpostcheckkey=154520371003
    NSMutableArray *list = [NSMutableArray new];
    for (SeriesModel *sModel in self.dataArr) {
        for (ProductModel *m in sModel.productList ) {
            NSLog(@"%@",m.mj_keyValues);
            NSMutableDictionary *dic = m.mj_keyValues;
            [dic setObject:m.remark?:@"999" forKey:@"remark"];
            [dic setObject:m.remark?:@"" forKey:@"packageRemark"];

            [dic removeObjectForKey:@"count"];

            [list addObject:dic];
        }
    }
//    NSError *error ;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:list
//                                                       options:kNilOptions
//                                                         error:&error];
//
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData
//                                                 encoding:NSUTF8StringEncoding];
    [[RequestManger sharedClient] POST:@"apps/order/savecollect" parameters:@{@"list":list} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
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
