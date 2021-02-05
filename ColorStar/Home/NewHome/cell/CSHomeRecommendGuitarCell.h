//
//  CSHomeRecommendGuitarCell.h
//  ColorStar
//
//  Created by apple on 2020/11/10.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSNewHomeRecommendModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol CSHomeRecommendGuitarCellDelegate <NSObject>
- (void)CSHomeRecommendGuitarCellPlayButton:(CSNewHomeRecommendGuitarListModel *)model;
- (void)CSHomeRecommendGuitarCellChangeButton;
@end
@interface CSHomeRecommendGuitarCell : UITableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withArray:(NSMutableArray *)array;
@property(nonatomic,weak)id<CSHomeRecommendGuitarCellDelegate> delegate;
@property(nonatomic, strong)CSNewHomeRecommendGuitarModel  *model;
@end

NS_ASSUME_NONNULL_END
