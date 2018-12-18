//
//  ProductCell.h
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/18.
//  Copyright © 2018 harmony. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductModel;
NS_ASSUME_NONNULL_BEGIN

@interface ProductCell : UITableViewCell

- (void)setModel:(ProductModel *)model;
@end

@interface GLineView : UIView

@property(nonatomic, assign) float linewdith;
@property (nonatomic, assign) float spaceWdith;
@property (nonatomic, retain) UIColor *lineColor;

@end


NS_ASSUME_NONNULL_END
