//
//  AnalyzeCtr.m
//  SaleApp
//
//  Created by zjy on 2018/12/16.
//  Copyright © 2018年 hechangqiye. All rights reserved.
//

#import "AnalyzeCtr.h"

@interface AnalyzeCtr ()
{
    HeadView *_headView;
    
}
@end

@implementation AnalyzeCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configHeadView];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
- (void)configHeadView{
    _headView = [HeadView new];
    [self.view addSubview:_headView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
