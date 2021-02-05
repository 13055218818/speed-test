//
//  CSMineTopViewModel.h
//  ColorStar
//
//  Created by gavin on 2020/8/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseModel.h"
#import "CSUserModel.h"


@interface CSMineTopViewModel : CSBaseModel

@property (nonatomic, strong)CSUserModel  * userInfo;

@property (nonatomic, strong)NSArray      * configs;


@end


