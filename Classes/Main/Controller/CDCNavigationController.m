//
//  CDCNavigationController.m
//  CDC
//
//  Created by weiwei on 16/9/30.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import "CDCNavigationController.h"

@interface CDCNavigationController ()

@end

@implementation CDCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    
    if (self.viewControllers.count > 0) {
        // 如果先在push的不是栈底控制器(最先push进来的那个控制器)
        viewController.hidesBottomBarWhenPushed = YES ;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"narrow_left"] highImage:[UIImage imageNamed:@"narrow_left"] target:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside] ;
        //        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navi_back" highImageName:@"navi_back_highlight" target:self action:@selector(back)] ;
        //        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_more" highImageName:@"navigationbar_more_highlighted" target:self action:@selector(more)] ;
        
        
        
        // 设置导航控制器
    }
    //
    [super pushViewController:viewController animated:animated] ;
}
- (void)back
{
    [self popViewControllerAnimated:YES] ;
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
