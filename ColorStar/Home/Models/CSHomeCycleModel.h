//
//  CSHomeCycleModel.h
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseModel.h"


@interface CSHomeCycleModel : CSBaseModel

@property (nonatomic, strong)NSString  * cycleId;

@property (nonatomic, strong)NSString  * title;

@property (nonatomic, strong)NSString  * url;

@property (nonatomic, strong)NSString  * pic;

@property (nonatomic, assign)BOOL        isSpecial;

@property (nonatomic, strong)NSString  * specialId;

@end


