//
//  CDCMainPageView.m
//  CDC
//
//  Created by 刘维 on 2016/10/7.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import "CDCMainPageHeader.h"
#import "UIButton+Expand.h"

@interface CDCMainPageHeader ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *centerButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UITextField *inputText;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation CDCMainPageHeader


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.frame = CGRectMake(0, 0, kScreen_Width,72);
    self.bgView.layer.cornerRadius = 5 ;
    self.bgView.clipsToBounds = YES ;
    [self.inputText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self setButtonLocation] ;
    
    self.inputText.returnKeyType = UIReturnKeySearch ;
    self.inputText.delegate = self ;
    

    
}

- (void)setButtonLocation {
    self.selecteIndex = 1;

    [self.leftButton setLayout:JPImageLeftTitleRightStyle spacing:5] ;
    [self.centerButton setLayout:JPImageLeftTitleRightStyle spacing:5] ;
    [self.rightButton setLayout:JPTitleLeftImageRightStyle spacing:5] ;

//    self.leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10) ;

}

-(void)setSelecteIndex:(NSInteger)selecteIndex{
    _selecteIndex = selecteIndex;
    if (selecteIndex == 1) {
        [self.centerButton setImage:[UIImage imageNamed:@"choose_nor"] forState:UIControlStateNormal] ;
        [self.leftButton setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal] ;

    }else if (selecteIndex == 2){
        [self.leftButton setImage:[UIImage imageNamed:@"choose_nor"] forState:UIControlStateNormal] ;
        [self.centerButton setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal] ;

    }else{
        
        [self.rightButton setImage:[UIImage imageNamed:@"choose_drop_up"] forState:UIControlStateNormal] ;
    }
    
}

- (IBAction)leftButton:(id)sender {
    [self.leftButton setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal] ;
    [self.centerButton setImage:[UIImage imageNamed:@"choose_nor"] forState:UIControlStateNormal] ;

    if ([self.delegate respondsToSelector:@selector(mainTitleView:clickIndex:)]) {
        [self.delegate mainTitleView:sender clickIndex:1];
    }
}
- (IBAction)centerButton:(id)sender {
    [self.leftButton setImage:[UIImage imageNamed:@"choose_nor"] forState:UIControlStateNormal] ;
    [self.centerButton setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal] ;
    if ([self.delegate respondsToSelector:@selector(mainTitleView:clickIndex:)]) {
        [self.delegate mainTitleView:sender clickIndex:2];
    }

}
- (IBAction)rightButton:(id)sender {
    [self.rightButton setImage:[UIImage imageNamed:@"choose_drop_up"] forState:UIControlStateSelected] ;
    if ([self.delegate respondsToSelector:@selector(mainTitleView:clickIndex:)]) {
        [self.delegate mainTitleView:sender clickIndex:3];
    }
    
}


- (void) textFieldDidChange:(UITextField *) TextField{
    if ([self.delegate respondsToSelector:@selector(inputTextMainTitleView:)]) {
        [self.delegate inputTextMainTitleView:TextField];
    }
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(textFieldShouldReturnTitleView:)]) {
        [self.delegate textFieldShouldReturnTitleView:textField];
    }
    return YES;
}

@end
