//
//  CSNewShopModel.m
//  ColorStar
//
//  Created by apple on 2020/11/26.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewShopModel.h"

@implementation CSNewShopModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"productId":@"id"};
}
@end

@implementation CSNewShopBannerModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"bannerId":@"id"};
}
@end


@implementation CSNewShopCategoryModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"categoryId":@"id"};
}
@end

@implementation CSNewListDetailModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"detailProductId":@"id"
    };
}
@end

@implementation CSNewShopAddressModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"addressId":@"id"
    };
}
@end


