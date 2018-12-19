//
//  HistoryCell.m
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/17.
//  Copyright © 2018 harmony. All rights reserved.
//

#import "HistoryCell.h"
#import "HistoryModel.h"

@interface HistoryCell(){
    UIView *_lastView;
    UIView *_newView;
    UILabel *_lastState;
    UILabel *_newState;
    GLineView *_lineView;
}
@end
@implementation HistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _lastView = [UIView new];
        _lastView.top = 0;
        [self.contentView addSubview:_lastView];
        
        _newView = [UIView new];
        [self.contentView addSubview:_newView];
        _lastView.width = _newView.width = ZJYDeviceWidth;
        
        _lastState = [UILabel new];
        [self.contentView addSubview:_lastState];
        _lastState.text = @"<< 原订单";
        _newState = [UILabel new];
        [self.contentView addSubview:_newState];
        _newState.text = @"<< 修改后的订单";
        
        _newState.font = _lastState.font = ZJYSYFont(12);
        _newState.backgroundColor = _lastState.backgroundColor = ZJYColorHex(@"E9E9E9");
        _newState.textAlignment  = _lastState.textAlignment = NSTextAlignmentRight;
        _newState.textColor = _lastState.textColor = ZJYColorHex(@"#777A77");
        CGSize size =[_newState sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
        _newState.width = size.width;
        _newState.height = size.height;
        
        CGSize size1 =[_lastState sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
        _lastState.width = size1.width;
        _lastState.height = size1.height;
        
        _lastState.right = _newState.right = ZJYDeviceWidth - 15;
        
        _lineView = [GLineView new];
        _lineView.width = ZJYDeviceWidth;
        _lineView.height = 1;
        [self.contentView addSubview:_lineView];
    }
    return self;
}

- (void)setModel:(HistoryModel *)model{
    [_lastView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_newView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    float top = 10;
    for (OrderModel *m in model.sourceOrder) {
        UILabel *lab = [self labelWithModel:m];
        lab.top = top;
        [_lastView addSubview:lab];
        top = lab.bottom;
    }
    _newView.height = 0;
    _lastState.hidden = _newState.hidden = _lineView.hidden = !model.neworder;
    top = 10;
    for (OrderModel *m in model.neworder) {
        UILabel *lab = [self labelWithModel:m];
        lab.top = top;
        [_newView addSubview:lab];
        top = lab.bottom;
    }
    _lastView.top = 0;
    _lastView.height = model.sourceHeight;
    _newView.height = model.neworderHeight;
    _lineView.top = _lastView.bottom;
    _newView.top = _lineView.bottom;
    _lastState.bottom = _lineView.bottom - 15;
    _newState.bottom = _newView.bottom - 15;

}
- (UILabel *)labelWithModel:(OrderModel *)model{
    UILabel *label = [UILabel new];
    label.font = ZJYSYFont(12);
    label.textColor = ZJYColorHex(@"4C4948");
    label.textAlignment = NSTextAlignmentLeft;
    label.height = 20;
    label.width = ZJYDeviceWidth;
    label.left = 15;
    label.text = [NSString stringWithFormat:@"%@ %@件",model.productName,model.piece];
    return label;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
