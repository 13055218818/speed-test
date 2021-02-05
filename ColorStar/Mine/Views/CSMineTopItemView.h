//
//  CSMineTopItemView.h
//  ColorStar
//
//  Created by gavin on 2020/8/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSMineConfigModel.h"


@interface CSMineTopItemView : UIControl

@property (nonatomic, strong)CSMineConfigModel * configModel;

- (instancetype)initWithConfigModel:(CSMineConfigModel*)model;

- (void)reloadData;
@end


