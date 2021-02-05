//
//  CSLiveGiftSelectedView.h
//  ColorStar
//
//  Created by gavin on 2020/10/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectGiftComplete)(NSString * giftCount, NSString * giftId, NSString * giftName,NSString * giftPrice,NSString * giftImage);

typedef void(^RecharegeGoldComplete)(void);
@interface CSLiveGiftSelectedView : UIView

@property (nonatomic, copy)SelectGiftComplete   giveClick;

@property (nonatomic, copy)RecharegeGoldComplete  rechargeClick;

@property (nonatomic, strong)NSString            * goldCount;

- (instancetype)initWithFrame:(CGRect)frame giftlist:(NSArray*)giftlist;

@end


