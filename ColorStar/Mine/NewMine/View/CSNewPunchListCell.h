//
//  CSNewPunchListCell.h
//  ColorStar
//
//  Created by apple on 2021/1/14.
//  Copyright © 2021 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSNewMineModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSNewPunchListCell : UITableViewCell
@property(nonatomic, strong)CSNewPunchListModel   *model;
@property(nonatomic, strong)CSNewShareListModel   *sharmodel;

@end

NS_ASSUME_NONNULL_END
