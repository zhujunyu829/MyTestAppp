//
//  HeadView.h
//  SaleApp
//
//  Created by zjy on 2018/12/16.
//  Copyright © 2018年 hechangqiye. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeadView : UIView

@property (nonnull, copy) NSString *title;

- (void)beginRefresh;
- (void)endRefresh;

@end

NS_ASSUME_NONNULL_END
