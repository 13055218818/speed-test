//
//  CSHomeCategoryModel.h
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseModel.h"

@interface CSHomeCategoryModel : CSBaseModel

@property (nonatomic, strong)NSString  * title;

@property (nonatomic, strong)NSString  * icon;

@property (nonatomic, assign)NSInteger   type;

@property (nonatomic, strong)NSString  * link;

@property (nonatomic, strong)NSString  * grade_id;

@property (nonatomic, strong)NSString  * categoryId;

@end


