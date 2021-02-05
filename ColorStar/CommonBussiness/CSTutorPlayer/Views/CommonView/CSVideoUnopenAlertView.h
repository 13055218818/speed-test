//
//  CSVideoUnopenAlertView.h
//  ColorStar
//
//  Created by gavin on 2020/12/5.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBasePopupView.h"

typedef void(^CSVideoUnopenAlertBlock)(void);

@interface CSVideoUnopenAlertView : CSBasePopupView

@property (nonatomic, copy)CSVideoUnopenAlertBlock  alertBlock;

@end


