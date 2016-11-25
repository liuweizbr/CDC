//
//  CDCBaseInfoCell.m
//  CDC
//
//  Created by weiwei on 16/10/9.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import "CDCBaseInfoCell.h"

@interface CDCBaseInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@end
@implementation CDCBaseInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.contentLabel.textColor = UIColorFromRGB(0x333333) ;
//    self.contentLabel.textColor = [UIColor redColor] ;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithCellData:(id)aData atIndexPath:(NSIndexPath *)indexPath {
    self.contentLabel.text = (NSString *)aData ;
}

- (void)updateWithCellData:(id)aData {
    self.titleNameLabel.text = (NSString *)aData ;
}

@end
