//
//  CSTutorPlayerView.h
//  ColorStar
//
//  Created by gavin on 2020/12/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CSTutorPlayerContainerBlockTypeBack,
    CSTutorPlayerContainerBlockTypeRecharge,
    CSTutorPlayerContainerBlockTypeVip,
} CSTutorPlayerContainerBlockType;

typedef void(^CSTutorPlayerContainerBlock)(CSTutorPlayerContainerBlockType type);

@interface CSTutorPlayerContainerView : UIView

@property (nonatomic,copy)CSTutorPlayerContainerBlock containerBlock;

@property (nonatomic, strong)UIButton  * vipBtn;

@property (nonatomic, strong)NSString * moneyDes;

@property (nonatomic, strong)NSString * titleDes;

- (void)showBackView;

- (void)showRechargeView;

@end


