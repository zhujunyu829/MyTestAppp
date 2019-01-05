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
    UILabel *_coutLabel;
    UILabel *_totalLabel;
    UILabel *_moneyLable;
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
    _countView.height = 30;
    _table.tableFooterView = _countView;
    _countView.backgroundColor = [UIColor whiteColor];
    
    UILabel *coutLabel = [UILabel new];
    
    [_countView addSubview:coutLabel];
    _coutLabel = coutLabel;
    GLineView *line = [GLineView new];
    [_countView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.height.mas_equalTo(1);
        make.width.equalTo(_countView.mas_width);
    }];
    [coutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.offset(-15);
    }];
    _coutLabel.attributedText  = [self cheakTotal];
    
}
- (NSAttributedString *)cheakTotal{
    int co = 0;
    float mon = 0;
    for (SeriesModel *model in self.dataArr) {
        for (ProductModel *m in model.productList) {
            co += m.count;
        }
    }
   
    NSString *count = [NSString stringWithFormat:@"%d",co];
    NSString *money = [NSString stringWithFormat:@"¥%0.2f",mon];
    NSString *tS = [NSString stringWithFormat:@"件数合计:%@件  应付合计：%@",count,money];
    NSMutableAttributedString *totalS = [[NSMutableAttributedString alloc] initWithString:tS];
    [totalS addAttribute:NSFontAttributeName value:ZJYSYFont(10) range:NSMakeRange(0,tS.length)];
    [totalS addAttribute:NSFontAttributeName value:ZJYBodyFont(13) range:NSMakeRange(5,count.length)];
    [totalS addAttribute:NSFontAttributeName value:ZJYBodyFont(13) range:NSMakeRange(tS.length -money.length,money.length)];
    [totalS addAttribute:NSForegroundColorAttributeName value:ZJYColorHex(@"#4C4948") range:NSMakeRange(0,tS.length)];
    [totalS addAttribute:NSForegroundColorAttributeName value:ZJYColorHex(@"#F15A24") range:NSMakeRange(5,count.length)];
    [totalS addAttribute:NSForegroundColorAttributeName value:ZJYColorHex(@"#F15A24") range:NSMakeRange(tS.length -money.length,money.length)];
    return totalS;
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
        [btn setTitleColor:ZJYColorHex(@"F15A24") forState:UIControlStateSelected];
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
            _confirmBtn.selected = YES;
        }
    }
}
- (void)configNoticeView{
    _noticeView = [UIView new];
    _noticeView.backgroundColor = ZJYColorHex(@"00A33E");
    [self.view addSubview:_noticeView];
    [self.view sendSubviewToBack:_noticeView];
    [_noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView.mas_bottom);
        make.width.equalTo(self.view.mas_width);
        make.left.offset(0);
    }];
    UILabel *titleLabel = [UILabel new];
    [_noticeView addSubview:titleLabel];
    
    titleLabel.text = @"确认订单";
    titleLabel.font = ZJYBodyFont(15);
    titleLabel.textColor = ZJYColorHex(@"ffffff");
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.centerX.offset(0);
    }];
    UILabel *noticel = [UILabel new];
    [_noticeView addSubview:noticel];
    noticel.textAlignment = NSTextAlignmentCenter;
    noticel.numberOfLines = 0;
    noticel.font = ZJYBodyFont(12);
    noticel.textColor = ZJYColorHex(@"ffffff");
    [noticel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
        make.centerX.offset(0);
        make.bottom.offset(-10);
        make.width.equalTo(_noticeView.mas_width).offset(-20);
    }];
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *f = [NSDateFormatter new];
    [f setDateFormat:@"HH"];
    NSString *h = [f stringFromDate:nowDate];
    NSDate *nextDate = [self offsetDay:1 date:nowDate];
    if (h.intValue <10) {
        nowDate = [self offsetDay:-1 date:nowDate];
        nextDate = [NSDate date];
    }
    [f setDateFormat:@"YYYY年MM月dd日"];
    NSString *nowString = [f stringFromDate:nowDate];
    [f setDateFormat:@"dd日"];
    NSString *nextString = [f stringFromDate:nextDate];
    [f setDateFormat:@"MM月dd日"];
    NSString *nextDa = [f stringFromDate:nextDate];
    NSString *noticeString = [NSString stringWithFormat:@"%@16:00~%@10:00订单已提交，系统将在%@上午10点自动收单，如需修改，请更改数量后再次确认",nowString,nextString,nextDa];
    noticel.text = noticeString;

    if (self.dic) {
        NSString *time = self.dic[@"time"];
        NSString *endTime = self.dic[@"endTime"];
        NSArray *liste = self.dic[@"seriesList"];
        if (liste.count) {
            noticel.text = [NSString stringWithFormat:@"%@自动收单，如需修改，请更改数量后再次确认",time];
        }else{
            noticel.text = [NSString stringWithFormat:@"今日未提交订单，请及时下单，系统将在%@自动收单",endTime];
        }
    }
    //有效时间：2018年10月15日16:00-16日10:00
}
-(NSDate *)offsetDay:(int)numDays date:(NSDate*)dat {
    NSCalendar *gregorian = [[NSCalendar alloc]
                              initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:dat options:0];
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
        make.bottom.offset(-(40+safeBottomHeight+50));
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
            [self saveOrder];
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
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 30;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    SeriesModel *model = self.dataArr[section];

    UIView *footerView = [UIView new];
    footerView.width = tableView.width;
    footerView.height = 30;
    footerView.backgroundColor = ZJYColorHex(@"#ffffff");
    int count = 0;
    for (ProductModel *m in model.productList) {
        count += m.count;
    }
    NSString *counts = [NSString stringWithFormat:@"件数小计：%d件",count];
    NSMutableAttributedString *totalS = [[NSMutableAttributedString alloc] initWithString:counts];
    [totalS addAttribute:NSFontAttributeName value:ZJYSYFont(10) range:NSMakeRange(0,counts.length)];
    [totalS addAttribute:NSFontAttributeName value:ZJYBodyFont(13) range:NSMakeRange(5,counts.length-6)];
    [totalS addAttribute:NSFontAttributeName value:ZJYBodyFont(13) range:NSMakeRange(5,counts.length-6)];
    [totalS addAttribute:NSForegroundColorAttributeName value:ZJYColorHex(@"#4C4948") range:NSMakeRange(0,counts.length)];
    [totalS addAttribute:NSForegroundColorAttributeName value:ZJYColorHex(@"#F15A24") range:NSMakeRange(5,counts.length-6)];
    
    UILabel *textLabel = [UILabel new];
    textLabel.font = ZJYBodyFont(13);
    textLabel.height = footerView.height;
    textLabel.width = 120;
    textLabel.right = footerView.width - 15;
    textLabel.attributedText = totalS;
    textLabel.textAlignment = NSTextAlignmentRight;
    [footerView addSubview:textLabel];
    return footerView;
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
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    SeriesModel *sM = self.dataArr[indexPath.section];
    
    ProductModel *mode = [sM.productList objectAtIndex:indexPath.row];
    [self deletdaP:mode back:^{
        NSMutableArray *arr = [NSMutableArray arrayWithArray:sM.productList];
        [arr removeObjectAtIndex:indexPath.row];
        sM.productList = arr;
        if (arr.count <=0) {
            [self.dataArr removeObjectAtIndex:indexPath.section];

        }else{
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

        }
        _coutLabel.attributedText = [self cheakTotal];
        [tableView reloadData];
    }];
    

}
- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
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
    
    cell.valueChange = ^{
        _coutLabel.attributedText = [self cheakTotal];
        [tableView reloadData];
        _confirmBtn.selected = YES;
    };
    return cell;
    
    return [UITableViewCell new];
}
#pragma mark- requset
- (void)useTemplate{
    [[RequestManger sharedClient] GET:@"apps/order/useTemplate" parameters:@{}  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [_headView endRefresh];
        [self.dataArr removeAllObjects];
        [_useTemplateArr removeAllObjects];
        [_useTemplateArr addObjectsFromArray:[SeriesModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"seriesList"]]];
        [self.dataArr addObjectsFromArray:_useTemplateArr];
        _coutLabel.attributedText = [self cheakTotal];
        [_table reloadData];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [_headView endRefresh];
    }];

}
- (void)requsetuseTemplate{
    //apps/order/useTemplate
    [_headView beginRefresh];
    DefineWeakSelf(weakSelf);
    [self deleteShoppingSuccess:^{
        [weakSelf useTemplate];
    }];
}
- (void)saveOrder{
    //apps/order/confirmOrder
     [_headView beginRefresh];
    NSMutableArray *list = [NSMutableArray new];
    for (SeriesModel *sModel in self.dataArr) {
        for (ProductModel *m in sModel.productList ) {
            NSLog(@"%@",m.mj_keyValues);
            NSMutableDictionary *dic = m.mj_keyValues;
            [dic setObject:@(m.count) forKey:@"piece"];
            [dic removeObjectForKey:@"count"];
            [list addObject:dic];
        }
    }
    DefineWeakSelf(weakSelf);
    [[RequestManger sharedClient] POST:@"apps/order/confirmOrder" parameters:list  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [weakSelf orderSuccess];
        [_headView endRefresh];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [_headView endRefresh];
    }];
}
- (void)orderSuccess{
    _confirmBtn.selected = NO;
    //apps/order/addShoppingCart?qbpostcheckkey=1545281999269
}
- (void)saveTemplate{
     [_headView beginRefresh];
    //apps/order/savecollect?qbpostcheckkey=154520371003
    NSMutableArray *list = [NSMutableArray new];
    for (SeriesModel *sModel in self.dataArr) {
        for (ProductModel *m in sModel.productList ) {
            NSLog(@"%@",m.mj_keyValues);
            NSMutableDictionary *dic = m.mj_keyValues;
            [dic setObject:m.remark?:@"" forKey:@"remark"];
            [dic removeObjectForKey:@"count"];
            [list addObject:dic];
        }
    }

    [[RequestManger sharedClient] POST:@"apps/order/savecollect" parameters:list success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [_headView endRefresh];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
         [_headView endRefresh];
    }];
}

- (void)deleteShoppingSuccess:(voidBlock)success{
    __block int i = 0;
    for (SeriesModel *sModel in self.dataArr  ) {
        i += sModel.productList.count;
        
    }
    if (i <=0) {
        success();
        return;
    }
    for (SeriesModel *sModel in self.dataArr  ) {
        for (ProductModel *m in sModel.productList ) {
            [self backGroudDeletdaP:m back:^{
                i--;
                if (i <=0) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self getOrder];
                        success();

                    });
                }
            }];
        }
        
    }
}
- (void)getOrder{
    ///apps/order/getOrder
    [[RequestManger sharedClient] GET:@"apps/order/getOrder" parameters:@{} showMessage:NO  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"~~~~~~%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [_headView endRefresh];
    }];
}

- (void)addShoppingCart:(NSArray *)arr{
    ///apps/order/addShoppingCart
    [self getOrder];
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
    [[RequestManger sharedClient] POST:@"apps/order/addShoppingCart" parameters:list  showMessage:NO  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [self getOrder];
        //        [weakSelf enterConfirmOrder:arr];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}
- (void)backGroudDeletdaP:(ProductModel *)model back:(voidBlock)success{
    [[RequestManger sharedClient] GET:@"apps/order/deleteShoppingCart" parameters:@{@"productId":model.productId?:@""}  showMessage:NO  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success();
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        success();
    }];

}
- (void)deletdaP:(ProductModel *)model back:(voidBlock)success{

    [[RequestManger sharedClient] GET:@"apps/order/deleteShoppingCart" parameters:@{@"productId":model.productId?:@""} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success();
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        success();
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
