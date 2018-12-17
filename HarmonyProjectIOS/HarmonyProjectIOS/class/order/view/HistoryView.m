//
//  HistoryView.m
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/17.
//  Copyright © 2018 harmony. All rights reserved.
//

#import "HistoryView.h"
@interface HistoryView()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_table;
}
@end
@implementation HistoryView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
    }
    return self;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        [self configView];
    }
    return self;
}

- (void)configView{
    UILabel *titleLabel = [UILabel new];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).offset(0);
        make.height.mas_equalTo(45);
        make.centerX.offset(0);
    }];
    titleLabel.text = @"历史订单";
    titleLabel.backgroundColor = ZJYColorHex(@"#019944");
    titleLabel.font = ZJYSYFont(14);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _table.delegate =self;
    _table.dataSource = self;
    [self addSubview:_table];
    [_table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height).offset(-85);
        make.top.equalTo(titleLabel.mas_bottom);
    }];
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
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
