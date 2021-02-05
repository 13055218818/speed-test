//
//  CSVideoPlayeRechargeAlertView.h
//  ColorStar
//
//  Created by gavin on 2020/12/7.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBasePopupView.h"

typedef void(^CSVideoPlayeRechargeAlertBlock)(void);
@interface CSVideoPlayeRechargeAlertView : CSBasePopupView

@property (nonatomic, copy)CSVideoPlayeRechargeAlertBlock alertBlock;

@property (nonatomic, strong)NSString  * price;

@end


