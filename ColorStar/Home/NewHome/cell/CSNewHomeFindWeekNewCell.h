//
//  CSNewHomeFindWeekNewCell.h
//  ColorStar
//
//  Created by apple on 2020/11/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSNewHomeRecommendModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CSNewHomeFindWeekNewCell : UITableViewCell
@property (nonatomic, strong)CSNewHomeFindWeekModel   *model;
@property(nonatomic,strong) UILabel  *lefTitleLabel;
@property(nonatomic,strong) UIImageView  *leftImage;
@property(nonatomic, assign)BOOL    isFirst;
@end

NS_ASSUME_NONNULL_END
