//
//  SeriesCell.m
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/18.
//  Copyright © 2018 harmony. All rights reserved.
//

#import "SeriesCell.h"
@interface SeriesCell (){
    UIView *_lineView;
    UILabel *_nameLabel;
}

@end
@implementation SeriesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _nameLabel = [UILabel new];
        _nameLabel.font = ZJYSYFont(15);
        _nameLabel.textColor = ZJYColorHex(@"595757");
        _nameLabel.adjustsFontSizeToFitWidth = YES;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nameLabel];

        _lineView = [UIView new];
//        _lineView.hidden = YES;
        _lineView.backgroundColor = ZJYColorHex(@"00A33E");
        [self.contentView addSubview:_lineView];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.mas_height);
            make.width.equalTo(self.mas_width);
            make.left.offset(0);
            make.top.offset(0);
        }];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.contentView.mas_width);
            make.height.mas_equalTo(2);
//            make.top.offset(10);
            make.bottom.equalTo(_nameLabel.mas_bottom).offset(-1);
            make.left.offset(0);
        }];
    }
    
    return self;
}

- (void)setModel:(SeriesModel *)model{
    _nameLabel.text = model.seriesName;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    _lineView.hidden = !selected;
    [self.contentView bringSubviewToFront:_lineView];
    _nameLabel.textColor = selected?ZJYColorHex(@"00A33E"):ZJYColorHex(@"595757");
    // Configure the view for the selected state
}

@end
