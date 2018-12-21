//
//  AnalyzeCtr.m
//  SaleApp
//
//  Created by zjy on 2018/12/16.
//  Copyright © 2018年 hechangqiye. All rights reserved.
//

#import "AnalyzeCtr.h"

@interface AnalyzeCtr ()
{
    HeadView *_headView;
    
}
@end

@implementation AnalyzeCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configHeadView];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
- (void)configHeadView{
    _headView = [HeadView new];
    _headView.hiddenback = YES;
    _headView.title = @"数据分析";
    [_headView endRefresh];
    [self.view addSubview:_headView];
    UIImageView *iamggeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defuat"]];
    [self.view addSubview:iamggeView];
    [iamggeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView.mas_bottom).offset(50);
        make.centerX.offset(0);
    }];
    UILabel *noticeLabel = [UILabel new];
    [self.view addSubview:noticeLabel];
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(iamggeView.mas_bottom).offset(10);
    }];
    noticeLabel.text = @"敬请期待";
    noticeLabel.textColor = ZJYColorHex(@"949494");
    noticeLabel.font = ZJYSYFont(15);
    noticeLabel.textAlignment = NSTextAlignmentCenter;
    
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
