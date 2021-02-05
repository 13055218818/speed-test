//
//  CSHomeRecommendInterestingCell.h
//  ColorStar
//
//  Created by apple on 2020/11/10.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSNewHomeRecommendModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CSHomeRecommendInterestingCell : UITableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier with:(NSMutableArray *)array;
@end

NS_ASSUME_NONNULL_END
