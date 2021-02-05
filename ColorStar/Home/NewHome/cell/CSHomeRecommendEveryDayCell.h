//
//  CSHomeRecommendEveryDayCell.h
//  ColorStar
//
//  Created by apple on 2020/11/10.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSHomeRecommendEveryDayCell : UITableViewCell
@property (nonatomic, strong)NSMutableArray   *everyDayArray;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier with:(NSMutableArray *)array;
@end

NS_ASSUME_NONNULL_END
