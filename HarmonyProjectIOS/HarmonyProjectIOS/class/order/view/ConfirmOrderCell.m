//
//  ConfirmOrderCell.m
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/18.
//  Copyright © 2018 harmony. All rights reserved.
//

#import "ConfirmOrderCell.h"
#import "ProductModel.h"
#import "ProductCell.h"

@interface ConfirmOrderCell()<UITextViewDelegate,UITextFieldDelegate>
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UITextField *_countField;
    GLineView *_lineView;
    ProductModel *_model;
    UITextView *_desView;
    UILabel         *_placeholderLable;

}
@end

@implementation ConfirmOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

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
        _countField.keyboardType = UIKeyboardTypeNumberPad;
        [self.contentView addSubview:_countField];
        
        _desView = [UITextView new];
        [self.contentView addSubview:_desView];
        _desView.font = ZJYSYFont(15);
        _desView.textAlignment = NSTextAlignmentLeft;
        _desView.layer.masksToBounds = YES;
        _desView.layer.borderColor = ZJYColorHex(@"#8B8B8B").CGColor;
        _desView.layer.borderWidth = 1;
        _desView.delegate = self;
        _desView.text = @"";
        
        _placeholderLable = [UILabel new];
        _placeholderLable.font = ZJYSYFont(15);
        _placeholderLable.text = @"备注:";
        _placeholderLable.textColor = ZJYColorHex(@"D4D4D4");
        _placeholderLable.width = [_placeholderLable sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width;
         _placeholderLable.height = [_placeholderLable sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].height;
        _placeholderLable.left = 4;
        _placeholderLable.top = 10;
        [_desView addSubview:_placeholderLable];
        
        _lineView = [GLineView new];
        //        _lineView.backgroundColor = ZJYColorHex(@"00ccff");
        [self.contentView addSubview:_lineView];
        
        UIButton *desBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        desBtn.layer.masksToBounds = YES;
        desBtn.layer.cornerRadius = 2;
        desBtn.backgroundColor = ZJYColorHex(@"#009944");
        desBtn.titleLabel.font = ZJYBodyFont(25);
        [desBtn setTitle:@"-" forState:UIControlStateNormal];
        [desBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:desBtn];
      
        [desBtn addTarget:self action:@selector(desBtnAction:) forControlEvents:UIControlEventTouchUpInside];
      
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.layer.masksToBounds = YES;
        addBtn.layer.cornerRadius = 2;
        addBtn.backgroundColor = ZJYColorHex(@"#009944");
        addBtn.titleLabel.font = ZJYBodyFont(25);
        [addBtn setTitle:@"+" forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:addBtn];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(45);
            make.centerY.offset(0);
        }];
        
        [_desView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_imageView.mas_right).offset(20);
            make.centerY.equalTo(_imageView.mas_centerY);
            make.height.equalTo(self.contentView.mas_height).multipliedBy(0.8);
            make.width.equalTo(self.contentView.mas_width).offset(-260);
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_desView.mas_right).offset(10);
            make.top.equalTo(_imageView.mas_top);
            make.width.equalTo(self.contentView).offset(-130);
        }];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(0);
            make.width.equalTo(self.contentView.mas_width).offset(-20);
            make.height.mas_equalTo(1);
            make.centerX.offset(0);
        }];
        [addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
   
        [desBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(5);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
            make.left.equalTo(_titleLabel.mas_left);
        }];
        [_countField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(desBtn.mas_right).offset(3);
            make.height.mas_equalTo(30);
            make.centerY.equalTo(desBtn.mas_centerY);
            make.width.mas_equalTo(80);
        }];
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(desBtn.mas_centerY);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
            make.left.equalTo(_countField.mas_right).offset(3);
        }];
    }
    return self;
}
- (void)setModel:(ProductModel *)model{
    _titleLabel.text = [NSString stringWithFormat:@"%@",model.productName];
    NSString *imgeUrl = [NSString stringWithFormat:@"%@%@",APPURL,model.coverPic];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imgeUrl]];
    _model = model;
    _countField.text = [NSString stringWithFormat:@"%d",_model.count];
    _desView.text = _model.remark;
    _placeholderLable.hidden = _desView.text.length >=1;

    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    _placeholderLable.hidden = textView.text.length >=1;
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    _model.count = [textField.text intValue];
    if (self.valueChange) {
        self.valueChange();
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    _model.remark = textView.text;
 
}
- (void)desBtnAction:(id)sender{
    if (_model.count < 1) {
        return;
    }
    _model.count--;
    _countField.text = [NSString stringWithFormat:@"%d",_model.count];
    if (self.valueChange) {
        self.valueChange();
    }
}
- (void)addBtnAction:(id)sender{
    _model.count ++;
    _countField.text = [NSString stringWithFormat:@"%d",_model.count];
    if (self.valueChange) {
        self.valueChange();
    }
}
@end
