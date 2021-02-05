//
//  CSNewMyOrderListCell.h
//  ColorStar
//
//  Created by apple on 2020/12/19.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSNewMineModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^CSNewMyOrderListCellDeleteClickBlock)(CSNewMineOrderModel *model);
@interface CSNewMyOrderListCell : UITableViewCell
@property(nonatomic, strong)CSNewMineOrderModel   *model;
@property (nonatomic, copy)CSNewMyOrderListCellDeleteClickBlock clickBlock;
@end

NS_ASSUME_NONNULL_END
