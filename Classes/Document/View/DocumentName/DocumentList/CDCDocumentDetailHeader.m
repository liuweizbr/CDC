//
//  CDCDocumentDetailHeader.m
//  CDC
//
//  Created by weiwei on 16/10/9.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import "CDCDocumentDetailHeader.h"

@interface CDCDocumentDetailHeader ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputText;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation CDCDocumentDetailHeader


- (void)drawRect:(CGRect)rect {
    self.frame = CGRectMake(0, 0, kScreen_Width, 40 );
    self.inputText.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.bgView.layer.cornerRadius = 5 ;
    self.bgView.clipsToBounds = YES ;
    [self.inputText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.inputText.returnKeyType = UIReturnKeySearch ;
    self.inputText.delegate = self ;
}

- (void) textFieldDidChange:(UITextField *) TextField{
    if ([self.delegate respondsToSelector:@selector(inputTexDocumentDetailView:)]) {
        [self.delegate inputTexDocumentDetailView:TextField];
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
