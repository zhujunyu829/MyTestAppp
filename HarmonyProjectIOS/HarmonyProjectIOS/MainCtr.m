//
//  MainCtr.m
//  SaleApp
//
//  Created by zjy on 2018/12/16.
//  Copyright © 2018年 hechangqiye. All rights reserved.
//

#import "MainCtr.h"
#import "AnalyzeCtr.h"
#import "PersonCtr.h"
#import "OrderCtr.h"

@interface MainCtr ()
{
    UITabBarController *_tab;
    UIView *_tabV;
    UIButton *_lastBtn;
}
@end

@implementation MainCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =ZJYColorHex(@"ffffff");
    self.navigationController.navigationBarHidden = YES;
    UITabBarController *tab = [[UITabBarController alloc] init];
    
    tab.viewControllers =@[[self changeNav:[AnalyzeCtr new]],[self changeNav:[OrderCtr new]],[self changeNav:[PersonCtr new]]];
    [self.view addSubview:tab.view];
    tab.selectedIndex = 1;
    _tab = tab;
    [self configBtn];
    // Do any additional setup after loading the view.
}
- (UIViewController *)changeNav:(UIViewController *)ctr{
    UINavigationController *nave = [[UINavigationController alloc] initWithRootViewController:ctr];
    nave.navigationBarHidden = YES;
    return nave;
}
- (void)configBtn{
    _tabV = [[UIView alloc] init];
    _tabV.height = 50;
    _tabV.width = ZJYDeviceWidth;
    
    _tabV.top = _tab.tabBar.top - safeBottomHeight;
    [_tab.view addSubview:_tabV];
    _tabV.backgroundColor = [UIColor whiteColor];
    _tab.tabBar.hidden = YES;
    NSArray *titleArr = @[@"分析统计",@"订单",@"我的"];
    NSArray *imgeArr = @[@"fenxitongji_",@"dindan_",@"wode_"];
    NSMutableArray *tabArr = [NSMutableArray new];
    float widht = _tabV.width/titleArr.count;

    for (int i = 0 ; i < titleArr.count; i ++) {
        NSString *imgeName = [NSString stringWithFormat:@"%@1",imgeArr[i]];
        NSString *imgeNameSel = [NSString stringWithFormat:@"%@2",imgeArr[i]];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imgeName] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imgeNameSel] forState:UIControlStateSelected];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:ZJYColorHex(@"019944") forState:UIControlStateNormal];
        [btn setTitleColor:ZJYColorHex(@"ffffff") forState:UIControlStateSelected];
        btn.height = _tabV.height;
        btn.left = widht*i;
        btn.width = widht;
        btn.top = 0;
        btn.tag = 10+i;
        btn.titleLabel.font = ZJYSYFont(10);
        float widht = [btn.titleLabel sizeThatFits:CGSizeMake(btn.width, btn.height)].width;
        CGSize imgaSize = [[UIImage imageNamed:imgeName] size];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(8, (btn.width - imgaSize.width)/2.0 , 0, 0)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(8+imgaSize.height + 5, (btn.width - widht)/2.0 -imgaSize.width, 0, 0)];
        btn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_tabV addSubview:btn];
        if (i == 1) {
            [self btnAction:btn];
        }
//        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:titleArr[i] image:[UIImage imageNamed:imgeName] selectedImage:[UIImage imageNamed:imgeNameSel]];
//        UIViewController *ctr = _tab.viewControllers[i];
//        ctr.tabBarItem = item;
//        item.tag = i;
//        [tabArr addObject:item];
    }

}
- (void)btnAction:(UIButton *)sender{
    if (_lastBtn == sender) {
        return;
    }
    if (_lastBtn) {
        _lastBtn.selected = NO;
        _lastBtn.backgroundColor = [UIColor clearColor];
    }
    sender.backgroundColor = ZJYColorHex(@"#14AD3D");
    sender.selected = !sender.selected;
    _lastBtn = sender;
    [_tab setSelectedIndex:sender.tag -10];
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
