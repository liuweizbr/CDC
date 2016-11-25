//
//  CDCAppDelegate+RootController.m
//  CDC
//
//  Created by 刘维 on 16/10/3.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import "CDCAppDelegate+RootController.h"
#import "CDCLoginViewController.h"
#import "CDCMainPageViewController.h"
#import "Reachability.h"

@interface CDCAppDelegate ()<UIScrollViewDelegate,UITabBarControllerDelegate>

@property (nonatomic, copy) NSString *userName ;
@property (nonatomic, copy) NSString *passWord ;
@end

@implementation CDCAppDelegate (RootController)

- (void)setAppWindows
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
}

- (void)setRootViewController
{
    if ([SZUserDefault objectForKey:@"isOne"])
    {//不是第一次安装
//        [self checkBlack];
        [self setRoot];
        
//        self.window.rootViewController = self.viewController;
//        self.window.rootViewController = self.viewController;
        
//         默认设置登录也是根视图 后期自动登录 继续修改
    }
    else
    {
//        CDCLoginViewController *emptyView = [[ CDCLoginViewController alloc ]init ];
//        self. window .rootViewController = emptyView;
        [self createLoadingScrollView];
    }
}

- (void)setRoot
{
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
//    self.userName = [userDefaults valueForKey:@"userName"] ;
//    self.passWord = [userDefaults valueForKey:@"password"] ;

    if ([[userDefaults valueForKey:@"isSuccess"] isEqualToString:@"YES"]) {
        [self loadDataSource] ;
        [NSThread sleepForTimeInterval:0.5] ;

        [self loginSuccessful] ;

    } else {
        CDCLoginViewController *emptyView = [[CDCLoginViewController alloc ]init];
    
        self.window.rootViewController = emptyView;
    }

//    CDCLoginViewController *emptyView = [[ CDCLoginViewController alloc ]init ];
//    self. window .rootViewController = emptyView;


}


- (void)loadDataSource {
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        WEAK_SELF
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager] ;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer] ;
    NSDictionary *parameters = @{@"loginName":[userDefaults valueForKey:@"userName"],@"password":[userDefaults valueForKey:@"password"]} ;
    NSString *URLString = [NSString stringWithFormat:@"%@%@",kBaseUrlStr_Phone,@"/manager/json/login"];
    [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation * operation, id responseObject) {
//        NSLog(@"%@",operation.responseString) ;
        STRONG_SELF
//        [self loginSuccessful] ;
    
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        NSLog(@"%@",error) ;
//        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"网络异常" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] ;
//        [alerView show] ;
    }] ;
    

    
//    WEAK_SELF
//    if ([self isConnectionAvailable])
//    {
//        NSString *URLString = [NSString stringWithFormat:@"%@%@",kBaseUrlStr_Phone,@"/manager/json/login"];
////        NSLog(@"dictionary:%@",dictionary);
//        
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//        // 设置超时时间
//        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//        manager.requestSerializer.timeoutInterval = 30.f;
//        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//        
//        NSDictionary *dictionary = @{@"loginName":[userDefaults valueForKey:@"userName"],@"password":[userDefaults valueForKey:@"password"]} ;
//        
//        [manager POST:URLString parameters:dictionary success:^(AFHTTPRequestOperation *operation,id responseObject)
//         {
//             STRONG_SELF
////                     NSDictionary *result=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
////             if ([result[@"m"] isEqualToString:@"success"]) {
////                 [self loginSuccessful] ;
////             } else {
////                 UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"网络异常" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] ;
////                 [alerView show] ;
////             }
//         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//             NSString * errorString =[NSString stringWithFormat:@"%@",error];
//             NSLog(@"===%@",error);
//             if ([errorString rangeOfString:@"Code=-1001"].location != NSNotFound)
//             {
////                 if (failBlock)
////                 {
////                     failBlock(@"请求超时，请重试");
////                 }
//             }
//             else if ([errorString rangeOfString:@"Code=-1004"].location != NSNotFound)
//             {
////                 if (failBlock)
////                 {
////                     failBlock(@"未能连接到服务器");
////                 }
//                 NSLog(@"未能连接到服务器") ;
//             }
//             else
//             {
////                 if (failBlock)
////                 {
////                     failBlock(@"请求超时");
////                 }
//             }
//         }];
//    }
//    else
//    {
//        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"网络异常" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] ;
//        [alerView show] ;
//    }

}

#pragma mark - 判断网络连接情况
// 加号方法里只能够调用加号方法
- (BOOL)isConnectionAvailable
{
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus])
    {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    if (!isExistenceNetwork) {
        return NO;
    }
    return isExistenceNetwork;
}

/**
 *  登录成功
 */
- (void)loginSuccessful {
    
    CDCMainPageViewController *mainVc = [CDCMainPageViewController new] ;
    
    UINavigationController * navc = [[UINavigationController alloc] initWithRootViewController:mainVc];
    navc.navigationBar.barTintColor = Main_Color;
    
    navc.navigationBar.shadowImage = [[UIImage alloc] init];
    [navc.navigationBar setTranslucent:NO];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [navc.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    navc.navigationBar.tintColor = [UIColor whiteColor];
    self.window.rootViewController = navc ;
}


#pragma mark - 引导页
- (void)createLoadingScrollView
{//引导页
//    UIScrollView *sc = [[UIScrollView alloc]initWithFrame:self.window.bounds];
//    sc.pagingEnabled = YES;
//    sc.delegate = self;
//    sc.showsHorizontalScrollIndicator = NO;
//    sc.showsVerticalScrollIndicator = NO;
//    [self.window.rootViewController.view addSubview:sc];
//    
//    NSArray *arr = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
//    for (NSInteger i = 0; i<arr.count; i++)
//    {
//        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width*i, 0, kScreen_Width, kScreen_Height)];
//        img.image = [UIImage imageNamed:arr[i]];
//        [sc addSubview:img];
//        img.userInteractionEnabled = YES;
//        if (i == arr.count - 1)
//        {
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//            btn.frame = CGRectMake((kScreen_Width/2)-50, kScreen_Height-110, 100, 40);
//            btn.backgroundColor = Main_Color;
//            [btn setTitle:@"开始体验" forState:UIControlStateNormal];
//            [btn addTarget:self action:@selector(goToMain) forControlEvents:UIControlEventTouchUpInside];
//            [img addSubview:btn];
//            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            btn.layer.borderWidth = 1;
//            btn.layer.borderColor = Main_Color.CGColor;
//        }
//    }
//    sc.contentSize = CGSizeMake(kScreen_Width*arr.count, kScreen_Height);
    
    [self goToMain];

}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (scrollView.contentOffset.x>kScreen_Width *4+30)
//    {
//        [self goToMain];
//    }
//}

- (void)goToMain
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:@"isOne" forKey:@"isOne"];
    [user synchronize];
    CDCLoginViewController *emptyView = [[ CDCLoginViewController alloc ]init ];
    self.window.rootViewController = emptyView;
    // self.window.rootViewController = self.viewController;
}


@end
