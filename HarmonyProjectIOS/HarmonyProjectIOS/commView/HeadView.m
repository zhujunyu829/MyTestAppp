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
    UIButton *_backBtn;
    UIButton *_rightBtn;
}
@end
@implementation HeadView

- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, ZJYDeviceWidth, 44 + safeTopHeight)];
    self.backgroundColor = ZJYColorHex(@"000000");
    if (self) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"back_arrow"] forState:UIControlStateNormal];
        [self addSubview:_backBtn];
        [_backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
     
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setImage:[UIImage imageNamed:@"huidaosouye"] forState:UIControlStateNormal];
        [self addSubview:_rightBtn];
        [_rightBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
       
        _titleLabel = [UILabel new];
        _titleLabel.text = @"收取中...";
        _titleLabel.font = ZJYSYFont(18);
        _titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.bottom.offset(-15);
            
        }];
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(40);
            make.centerY.equalTo(_titleLabel.mas_centerY);
        }];
        [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(40);
            make.centerY.equalTo(_titleLabel.mas_centerY);
        }];
       
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
- (void)setHiddenback:(BOOL)hiddenback{
    _hiddenback = hiddenback;
    _backBtn.hidden = hiddenback;
}
- (void)setHiddenRightback:(BOOL)hiddenRightback{
    _hiddenRightback = hiddenRightback;
    _rightBtn.hidden = hiddenRightback;
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
- (void)backAction:(id)sender{
    if (self.backCallBack) {
        self.backCallBack();
    }
}
- (void)rightAction:(id)sender{
    if (self.homeCallBack) {
        self.homeCallBack();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
