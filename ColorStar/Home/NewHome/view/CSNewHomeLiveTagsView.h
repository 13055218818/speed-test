//
//  CSNewHomeLiveTagsView.h
//  ColorStar
//
//  Created by apple on 2020/11/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSNewHomeRecommendModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^CSNewHomeLiveTagsViewCellClickBlock)(CSNewHomeLiveTagModel *model);

@interface CSNewHomeLiveTagsView : UIView
@property (nonatomic, strong)NSMutableArray         *array;
@property (nonatomic, copy)CSNewHomeLiveTagsViewCellClickBlock clickBlock;
@end

NS_ASSUME_NONNULL_END
