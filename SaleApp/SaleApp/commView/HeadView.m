//
//  HeadView.m
//  SaleApp
//
//  Created by zjy on 2018/12/16.
//  Copyright © 2018年 hechangqiye. All rights reserved.
//

#import "HeadView.h"

@interface HeadView ()
{
    UILabel *_titleLabel;
    UIActivityIndicatorView *_indicatorV;
}
@end
@implementation HeadView

- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, ZJYDeviceWidth, 75 + safeTopHeight)];
    self.backgroundColor = ZJYColorHex(@"000000");
    if (self) {
        _titleLabel = [UILabel new];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.bottom.offset(-15);
            
        }];
        _titleLabel.text = @"收取中...";
        _titleLabel.font = ZJYSYFont(18);
        _titleLabel.textColor = [UIColor whiteColor];
        _indicatorV  = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
        [self addSubview:_indicatorV];
        [_indicatorV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(10);
            make.right.equalTo(_titleLabel.mas_left).offset(-5);
            make.centerY.equalTo(_titleLabel.mas_centerY).offset(0);
        }];
        [_indicatorV startAnimating];
    }
    return self;
}
- (void)beginRefresh{
    [_indicatorV startAnimating];
    _titleLabel.text = @"收取中...";
    _indicatorV.hidden = NO;

}
- (void)endRefresh{
    _titleLabel.text = self.title;
    _indicatorV.hidden = YES;
    [_indicatorV stopAnimating];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
