//
//  CDCDocumentDetailCell.m
//  CDC
//
//  Created by weiwei on 16/10/9.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import "CDCDocumentDetailCell.h"

@interface CDCDocumentDetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation CDCDocumentDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)updateWithCellData:(LWArrModel_d *)aData atIndexPath:(NSIndexPath *)indexPath {
    
    if ([NSString isBlankString:aData.name] == NO ) {
        self.name.text = aData.name ;
    } else {
        self.name.text = aData.catalog ;
    }
}

@end
