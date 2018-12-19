//
//  ProductCell.m
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/18.
//  Copyright © 2018 harmony. All rights reserved.
//

#import "ProductCell.h"
#import "ProductModel.h"

@interface ProductCell()<UITextFieldDelegate>{
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UITextField *_countField;
    GLineView *_lineView;
    ProductModel *_model;
}
@end

@implementation ProductCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        _imageView = [UIImageView new];
        [self.contentView addSubview:_imageView];
        _titleLabel = [UILabel new];
        _titleLabel.font = ZJYSYFont(13);
        _titleLabel.textColor = ZJYColorHex(@"000000");
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
        _countField = [UITextField new];
        _countField.font = ZJYSYFont(15);
        _countField.textAlignment = NSTextAlignmentCenter;
        _countField.adjustsFontSizeToFitWidth = YES;
        _countField.layer.masksToBounds = YES;
        _countField.layer.borderColor = ZJYColorHex(@"#8B8B8B").CGColor;
        _countField.layer.borderWidth = 1;
        _countField.delegate = self;
        _countField.text = @"0";
        [self.contentView addSubview:_countField];
        _lineView = [GLineView new];
//        _lineView.backgroundColor = ZJYColorHex(@"00ccff");
        [self.contentView addSubview:_lineView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(45);
            make.centerY.offset(0);
        }];
        _titleLabel.text = @" ";
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_imageView.mas_right).offset(24);
            make.top.equalTo(_imageView.mas_top);
            make.width.equalTo(self.contentView).offset(-100);
        }];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(0);
            make.width.equalTo(self.contentView.mas_width).offset(-20);
            make.height.mas_equalTo(1);
            make.centerX.offset(0);
        }];
        
        UIButton *desBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        desBtn.layer.masksToBounds = YES;
        desBtn.layer.cornerRadius = 2;
        desBtn.backgroundColor = ZJYColorHex(@"#009944");
        desBtn.titleLabel.font = ZJYBodyFont(15);
        [desBtn setTitle:@"-" forState:UIControlStateNormal];
        [desBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:desBtn];
        [desBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(15);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(20);
            make.left.equalTo(_titleLabel.mas_left);
        }];
        [desBtn addTarget:self action:@selector(desBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_countField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(desBtn.mas_right).offset(3);
            make.height.mas_equalTo(20);
            make.centerY.equalTo(desBtn.mas_centerY);
            make.width.mas_equalTo(80);
        }];
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.layer.masksToBounds = YES;
        addBtn.layer.cornerRadius = 2;
        addBtn.backgroundColor = ZJYColorHex(@"#009944");
        addBtn.titleLabel.font = ZJYBodyFont(15);
        [addBtn setTitle:@"+" forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:addBtn];
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(desBtn.mas_centerY);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(20);
            make.left.equalTo(_countField.mas_right).offset(3);
        }];
        [addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}

- (void)setModel:(ProductModel *)model{
    _titleLabel.text = [NSString stringWithFormat:@"%@",model.productName];
    NSString *imgeUrl = [NSString stringWithFormat:@"%@%@",APPURL,model.coverPic];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imgeUrl]];
    _model = model;
    _countField.text = [NSString stringWithFormat:@"%d",_model.count];

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    _model.count = [textField.text intValue];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - action
- (void)desBtnAction:(id)sender{
    if (_model.count < 0) {
        return;
    }
    _model.count--;
    _countField.text = [NSString stringWithFormat:@"%d",_model.count];
}
- (void)addBtnAction:(id)sender{
    _model.count ++;
    _countField.text = [NSString stringWithFormat:@"%d",_model.count];

}



@end



