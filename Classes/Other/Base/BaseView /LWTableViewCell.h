//
//  QMTableViewCell.h
//  UIPageViewController学习
//
//  Created by weiwei on 16/9/6.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWTableViewCell : UITableViewCell

/**
 *  index
 */
@property (nonatomic, strong) NSIndexPath *indexPath;

/**
 *  代理
 */
@property (nonatomic, weak) id delegate;

/**
 *  缩进边界
 */
@property (nonatomic) UIEdgeInsets cellEdgeInsets;

/**
 *  功能:获取cell的唯一标识符
 */
+ (NSString *)cellReuseIdentifier;

/**
 *	功能:cell根据数据显示ui
 *
 *	@param aData:cell数据
 */
- (void)updateWithCellData:(id)aData;

/**
 *  功能:获取cell的高度。如果要根据数据获取cell的高度，必须等数据填充完毕后,再调用此方法才有用
 *
 *  @return
 */

- (CGFloat)getCellHeight;

/**
 *	功能:cell根据数据和位置显示ui
 *
 *	@param aData:cell数据
 *	@param indexPath:cell位置
 */
- (void)updateWithCellData:(id)aData atIndexPath:(NSIndexPath *)indexPath;

/**
 *	功能:获取cell的高度
 *
 *	@param aData:cell的数据
 *
 *	@return
 */
+ (CGFloat)heightForCellData:(id)aData;

/**
 *	功能:获取cell的高度
 *
 *	@param aData:cell的数据
 *  @param indexPath:cell位置
 *
 *	@return
 */
+ (CGFloat)heightForCellData:(id)aData atIndexPath:(NSIndexPath *)indexPath;

/**
 *  功能:返回Cell对应的nib
 */
+ (UINib *)nib;

@end
