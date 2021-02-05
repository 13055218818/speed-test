//
//  CSHomeSpecialCell.h
//  ColorStar
//
//  Created by gavin on 2020/8/4.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeBaseTopiceCell.h"


@interface CSHomeBigCell : CSHomeBaseTopiceCell

@property (nonatomic, strong)UIButton  * playBtn;

@property (nonatomic, copy  ) void(^playBlock)(UIButton *sender);

@end


