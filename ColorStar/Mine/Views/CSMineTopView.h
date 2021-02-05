//
//  CSMineTopView.h
//  ColorStar
//
//  Created by gavin on 2020/8/10.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSMineTopViewModel.h"
#import "CSMineConfigModel.h"

typedef void(^CSMineItemClick)(CSMineConfigModel * config);

typedef void(^CSMineSettingClick)(void);

typedef void(^CSMineMemberClick)(void);

@interface CSMineTopView : UIView

@property (nonatomic, copy)CSMineItemClick click;

@property (nonatomic, copy)CSMineSettingClick setting;

@property (nonatomic, copy)CSMineMemberClick  memberClick;

- (instancetype)initWithTopViewModel:(CSMineTopViewModel*)model;

- (void)reloadData;

@end


