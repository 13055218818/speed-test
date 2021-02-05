//
//  CSMineConfigModel.m
//  ColorStar
//
//  Created by gavin on 2020/8/10.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSMineConfigModel.h"

@implementation CSMineConfigModel


- (CSMineConfigType)configType{
    switch (self.type) {
        case 0:
            return CSMineConfigTypeCourse;
            break;
        case 1:
            return CSMineConfigTypeRecord;
            break;
        case 2:
            return CSMineConfigTypeFavorite;
            break;
        case 3:
            return CSMineConfigTypeSign;
            break;
        case 4:
            return CSMineConfigTypeMember;
            break;
        case 5:
            return CSMineConfigTypeSpread;
            break;
        case 6:
            return CSMineConfigTypePink;
            break;
        case 7:
            return CSMineConfigTypeApply;
            break;
        case 8:
            return CSMineConfigTypePresent;
            break;
        case 9:
            return CSMineConfigTypeRecharge;
            break;
        case 10:
            return CSMineConfigTypeAbout;
            break;
        case 11:
            return CSMineConfigTypeService;
        break;
    }
    return CSMineConfigTypeNone;
}

@end
