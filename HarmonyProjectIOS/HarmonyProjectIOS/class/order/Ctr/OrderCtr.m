//
//  OrderCtr.m
//  SaleApp
//
//  Created by zjy on 2018/12/16.
//  Copyright © 2018年 hechangqiye. All rights reserved.
//

#import "OrderCtr.h"
#import "ProductModel.h"
#import "ProductCell.h"
#import "SeriesCell.h"
#import "ConfirmOrderCtr.h"
#import "HistoryCtr.h"

typedef NS_ENUM(NSInteger,OrderBottomTyp) {
    OrderBottomTypTemp =10,
    OrderBottomTypHistory,
    OrderBottomTypOrder
};

@interface OrderCtr ()<UITableViewDelegate,UITableViewDataSource>
{
    HeadView *_headView;
    UIView *_headBtnView;
    UIButton *_currentbnt;
    UITableView *_productTable;//产品列表
    UITableView *_listTable;//系列列表
    NSMutableArray *_seriesArr;
    NSMutableArray *_productArr;
    NSMutableArray *_useTemplateArr;
}
@end

@implementation OrderCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configHeadView];
    [self configHeadbtnview];
    [self configBottomBtn];
    [self configTable];
    _productArr = [NSMutableArray new];
    _seriesArr = [NSMutableArray new];
    _useTemplateArr  = [NSMutableArray new];
    self.view.backgroundColor = [UIColor whiteColor];
    [self requsetList];
    // Do any additional setup after loading the view.
}
- (void)configHeadView{
    _headView = [HeadView new];
    _headView.title =@"商城";
    _headView.hiddenback = YES;
    [_headView endRefresh];
    DefineWeakSelf(weakSelf);
    _headView.homeCallBack = ^{
        [weakSelf requsetList];
    };
    [self.view addSubview:_headView];
}

- (void)configBottomBtn{
    NSArray *btnArr = @[@"使用模版",@"历史订单",@"提交新订单"];
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
        btn.tag = OrderBottomTypTemp+i;
        [btn addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(width *i -1);
            make.height.mas_equalTo(height);
            make.width.mas_equalTo(width);
            make.bottom.offset(-(50+safeBottomHeight));
        }];
    }
}

- (void)configTable{
    _productTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_productTable];
    _listTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_listTable];
    _productTable.delegate = _listTable.delegate = self;
    _productTable.dataSource = _listTable.dataSource = self;
    _productTable.tableFooterView = [UIView new];
    [_productTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headBtnView.mas_bottom);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.3);
        make.left.offset(0);
        make.bottom.mas_equalTo(-(40+50+safeBottomHeight));
    }];
    [_listTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(_productTable.mas_height);
        make.top.equalTo(_productTable.mas_top);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.7);
        make.right.offset(0);
    }];
    UIView *lineView = [UIView new];
    lineView.backgroundColor = ZJYColorHex(@"D9D9D9");
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_listTable.mas_left);
        make.width.mas_equalTo(1);
        make.height.equalTo(_listTable.mas_height);
        make.top.equalTo(_listTable.mas_top);
    }];
    _listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if ([_productTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [_productTable setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_productTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [_productTable setLayoutMargins:UIEdgeInsetsZero];
    }
    
}
- (void)configHeadbtnview{

    UIView *headBtnView = [UIView new];
    headBtnView.backgroundColor = ZJYColorHex(@"#7D7D7D");
    [self.view addSubview:headBtnView];
    [headBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView.mas_bottom);
        make.height.mas_offset(50);
        make.width.mas_equalTo(self.view.mas_width);
    }];
    _headBtnView = headBtnView;

    NSArray *btnArr = @[@"企业订单",@"业务员订单"];
    float widht = ZJYDeviceWidth/btnArr.count;
    for (int i = 0; i < btnArr.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [headBtnView addSubview:btn];
        [btn setTitle:btnArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:ZJYColorHex(@"AAABAB") forState:UIControlStateNormal];
        [btn setTitleColor:ZJYColorHex(@"ffffff") forState:UIControlStateSelected];
        [headBtnView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(widht*i);
            make.width.equalTo(headBtnView.mas_width).dividedBy(2);
            make.height.equalTo(headBtnView.mas_height);
            make.top.offset(0);
        }];
        btn.tag = 10+i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.selected = i ==0;
        if (i == 0) {
            _currentbnt =btn;
        }
        btn.backgroundColor = btn.selected?ZJYColorHex(@"019944"):[UIColor clearColor];

    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _productTable) {
        return 40;
    }
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (nullable UIView *)tableView:(UITableView *)tableView {
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _productTable) {
        [_productArr removeAllObjects];
        [_productArr addObjectsFromArray:[_seriesArr[indexPath.row]productList]];
        _listTable.contentOffset = CGPointZero;
        [_listTable reloadData];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _productTable) {
        return _seriesArr.count;
    }
    return _productArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _productTable) {
        SeriesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"_productTable"];
        if (!cell) {
            cell = [[SeriesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_productTable"];
        }
        [cell setModel:_seriesArr[indexPath.row]];
        return cell;
    }
    ProductCell *pCell = [tableView dequeueReusableCellWithIdentifier:@"pCell"];
    if (!pCell) {
        pCell = [[ProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pCell"];
    }
    [pCell setModel:_productArr[indexPath.row]];
    return pCell;
}

#pragma mark - Action
- (void)bottomAction:(UIButton *)sender{
    switch (sender.tag ) {
        case OrderBottomTypTemp:
        {
            [self requsetuseTemplate];
        }break;
        case OrderBottomTypHistory:
        {
            HistoryCtr *ctr = [HistoryCtr new];
            [self.navigationController pushViewController:ctr animated:YES];
        }break;
        case OrderBottomTypOrder:
        {
            NSMutableArray*arr = [NSMutableArray new];
            for (SeriesModel *mode in _seriesArr) {
                NSMutableArray *pMoelArr = [NSMutableArray new];
                for (ProductModel *pModel in mode.productList) {
                    if (pModel.count) {
                        [pMoelArr addObject:pModel];
                    }
                }
                if (pMoelArr.count) {
                    SeriesModel *newM = [SeriesModel new];
                    newM.seriesName = mode.seriesName;
                    newM.seriesCode = mode.seriesCode;
                    newM.seriesCount = mode.seriesCount;
                    newM.productList = pMoelArr;
                    [arr addObject:newM];
                }
               
            }
            if (!arr.count) {
                [AppAlertView showErrorMeesage:@"请选择商品"];
                return;
            }
            [self addShoppingCart:arr];
        }break;
        default:
            break;
    }
}
- (void)btnAction:(UIButton *)sender{
    if (_currentbnt == sender) {
        return;
    }
    _currentbnt.selected = NO;
    _currentbnt.backgroundColor = [UIColor clearColor];
    sender.selected = YES;
    sender.backgroundColor = ZJYColorHex(@"019944");
    _currentbnt = sender;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)requsetList{
    //apps/order/queryOrderList
    //apps/product/list
    [_headView beginRefresh];
    [[RequestManger sharedClient] GET:@"apps/product/list" parameters:@{}  showMessage:NO success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [_headView endRefresh];
        [_seriesArr removeAllObjects];
        [_productArr removeAllObjects];
        for (NSDictionary *dic in responseObject[@"result"]) {
            [_seriesArr addObject:[SeriesModel mj_objectWithKeyValues:dic]];
        }
        if (_seriesArr.count) {
            [_productArr addObjectsFromArray:[_seriesArr[0] productList]];
        }
        [_productTable reloadData];
        [_listTable reloadData];
        NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_productTable selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [_headView endRefresh];
    }];
}

- (void)addShoppingCart:(NSArray *)arr{
    ///apps/order/addShoppingCart
    
    NSMutableArray *list = [NSMutableArray new];
    for (SeriesModel *sModel in arr) {
        for (ProductModel *m in sModel.productList ) {
            NSLog(@"%@",m.mj_keyValues);
            NSMutableDictionary *dic = m.mj_keyValues;
            [dic setObject:@(m.count) forKey:@"piece"];
            [dic removeObjectForKey:@"count"];
            [list addObject:dic];
        }
    }
    DefineWeakSelf(weakSelf);
    [[RequestManger sharedClient] POST:@"apps/order/addShoppingCart" parameters:list  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [weakSelf enterConfirmOrder:arr];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}
- (void)requsetuseTemplate{
    //apps/order/useTemplate
    [_headView beginRefresh];
    [[RequestManger sharedClient] GET:@"apps/order/useTemplate" parameters:@{} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [_headView endRefresh];
        [_useTemplateArr removeAllObjects];
        [_useTemplateArr addObjectsFromArray:[SeriesModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"seriesList"]]];
        [self enterTemplate];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [_headView endRefresh];
    }];
}
- (void)enterTemplate{
    if (!_useTemplateArr.count) {
        [AppAlertView showErrorMeesage:@"没获取到模版"];
        return;
    }
    [self addShoppingCart:_useTemplateArr];
}
- (void)enterConfirmOrder:(NSArray *)arr{
    ConfirmOrderCtr *ctr = [ConfirmOrderCtr new];
    ctr.dataArr = arr;
    [self.navigationController pushViewController:ctr animated:YES];
}

@end
