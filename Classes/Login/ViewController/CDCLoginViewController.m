//
//  CDCLoginViewController.m
//  CDC
//
//  Created by 刘维 on 16/10/3.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import "CDCLoginViewController.h"
#import "CDCMainPageViewController.h"


@interface CDCLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *passWordText;
@property (weak, nonatomic) IBOutlet UIButton *longButton;
@property (nonatomic, strong) LWDictionaryAllSourceManager *dicManager ;
@end

@implementation CDCLoginViewController

- (LWDictionaryAllSourceManager *)dicManager {
    if (!_dicManager) {
        _dicManager = [[LWDictionaryAllSourceManager alloc] init] ;
    }
    return _dicManager ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;

    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    
    if ([userDefaults valueForKey:@"userName"]) {
        self.userNameText.text = [userDefaults valueForKey:@"userName"] ;
    }
    
    if ([[userDefaults valueForKey:@"isSuccess"] isEqualToString:@"YES"]) {
        self.userNameText.text = [userDefaults valueForKey:@"userName"] ;
        self.passWordText.text = [userDefaults valueForKey:@"password"] ;
    }
    
    [self setUI] ;

    DebugLog(@"%s","") ;
    
}

- (void)setUI {
    self.longButton.layer.cornerRadius = 3 ;
    self.longButton.clipsToBounds = YES ;
    self.longButton.layer.borderWidth = 0.5 ;
    self.longButton.layer.borderColor = [UIColor whiteColor].CGColor ;
    
    self.userNameText.clearButtonMode = UITextFieldViewModeWhileEditing ;
    self.userNameText.rightViewMode = UITextFieldViewModeWhileEditing ;
    self.userNameText.tintColor = [UIColor whiteColor] ;
    self.passWordText.tintColor = [UIColor whiteColor] ;
}

/**
 *  登陆按钮
 */
- (IBAction)loginButton {
    
    if ([NSString isBlankString:self.userNameText.text] == YES) {
        [MBProgressHUD showError:@"请输入账号" toView:self.view];
    } else if ([NSString isBlankString:self.passWordText.text] == YES) {
        [MBProgressHUD showError:@"请输入密码" toView:self.view];
    } else {
        [self loadDataSource] ;
//        [self loginSuccessful] ;

    }

}
- (void)loadDataSource {
    
    __weak typeof(*&self)weakSelf = self ;
    [SVProgressHUD show];
    SVProgressHUD_ADD
    [self.dicManager loadDataSourceList:^(BOOL isSuccess, NSString *error) {
        if (isSuccess == YES)
        {
            [weakSelf loginSuccessful] ;
            [SVProgressHUD dismiss];
        }
        else
        {
            
            [SVProgressHUD dismiss];
            [MBProgressHUD showError:error toView:self.view];
        }
    } failBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
        [MBProgressHUD showError:error toView:self.view];
        
    } andWithParameters:@{@"loginName":self.userNameText.text,@"password":self.passWordText.text} lastUrl:@"/manager/json/login"] ;
}

/**
 *  登录成功
 */
- (void)loginSuccessful {
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setValue:self.userNameText.text forKey:@"userName"];
    [userDefaults setValue:self.passWordText.text forKey:@"password"];
    [userDefaults setValue:@"YES" forKey:@"isSuccess"];
    [userDefaults synchronize];
    
    CDCMainPageViewController *mainVc = [CDCMainPageViewController new] ;
    UINavigationController * navc = [[UINavigationController alloc] initWithRootViewController:mainVc];
    navc.navigationBar.barTintColor = Main_Color;
    
    navc.navigationBar.shadowImage = [[UIImage alloc] init];
    [navc.navigationBar setTranslucent:NO];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [navc.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    navc.navigationBar.tintColor = [UIColor whiteColor];
    kKeyWindow.rootViewController = navc ;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
