//
//  CSLiveGiftCell.h
//  ColorStar
//
//  Created by gavin on 2020/10/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSLiveGiftModel.h"


@interface CSLiveGiftCell : UICollectionViewCell

@property (nonatomic, strong)UIView * containerView;

@property (nonatomic, strong)CSLiveGiftModel  * giftModel;

@end


