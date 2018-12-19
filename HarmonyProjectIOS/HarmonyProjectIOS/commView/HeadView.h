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

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL hiddenback;
@property (nonatomic, assign) BOOL hiddenRightback;

@property (nonatomic, copy) voidBlock backCallBack;
@property (nonatomic, copy) voidBlock homeCallBack;

- (void)beginRefresh;
- (void)endRefresh;

@end

NS_ASSUME_NONNULL_END
