//
//  HistoryCell.h
//  HarmonyProjectIOS
//
//  Created by feng on 2018/12/17.
//  Copyright © 2018 harmony. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HistoryModel;
@interface HistoryCell : UITableViewCell

- (void)setModel:(HistoryModel *)model;
@end

NS_ASSUME_NONNULL_END
