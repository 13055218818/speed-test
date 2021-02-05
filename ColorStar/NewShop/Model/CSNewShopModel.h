//
//  CSNewShopModel.h
//  ColorStar
//
//  Created by apple on 2020/11/26.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSNewShopModel : NSObject
@property(nonatomic, strong)NSString        *productId;
@property(nonatomic, strong)NSString        *store_name;
@property(nonatomic, strong)NSString        *image;
@property(nonatomic, strong)NSString        *sales;
@property(nonatomic, strong)NSString        *price;
@property(nonatomic, strong)NSString        *stock;
@property(nonatomic, strong)NSString        *store_info;
@end

@interface CSNewShopBannerModel : NSObject
@property(nonatomic, strong)NSString        *bannerId;
@property(nonatomic, strong)NSString        *title;
@property(nonatomic, strong)NSString        *url;
@property(nonatomic, strong)NSString        *pic;
@end

@interface CSNewShopCategoryModel : NSObject
@property(nonatomic, strong)NSString        *categoryId;
@property(nonatomic, strong)NSString        *cate_name;
@property(nonatomic, strong)NSString        *pic;
@end

@interface CSNewListDetailModel : NSObject
@property(nonatomic, strong)NSString        *detailProductId;
@property(nonatomic, strong)NSString        *store_name;
@property(nonatomic, strong)NSString        *image;
@property(nonatomic, strong)NSMutableArray  *slider_image;
@property(nonatomic, strong)NSString        *store_info;
@property(nonatomic, strong)NSString        *keyword;
@property(nonatomic, strong)NSString        *ot_price;
@property(nonatomic, strong)NSString        *is_postage;
@property(nonatomic, strong)NSString        *give_gold_num;
@property(nonatomic, strong)NSString        *free_shipping;
@property(nonatomic, strong)NSString        *postage;
@property(nonatomic, strong)NSString        *price;
@property(nonatomic, strong)NSString        *vip_price;
@property(nonatomic, strong)NSString        *stock;
@property(nonatomic, strong)NSString        *sales;
@property(nonatomic, strong)NSString        *h5_url;
@property(nonatomic, strong)NSString        *isfollow;
@end

@interface CSNewShopAddressModel : NSObject
@property(nonatomic, strong)NSString        *addressId;
@property(nonatomic, strong)NSString        *real_name;
@property(nonatomic, strong)NSString        *phone;
@property(nonatomic, strong)NSString        *province;
@property(nonatomic, strong)NSString        *city;
@property(nonatomic, strong)NSString        *district;
@property(nonatomic, strong)NSString        *detail;
@property(nonatomic, strong)NSString        *is_default;
@property(nonatomic, strong)NSString        *area_code;
@end

NS_ASSUME_NONNULL_END
