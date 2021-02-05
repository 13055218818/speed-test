//
//  CSNewShopNetManage.h
//  ColorStar
//
//  Created by apple on 2020/11/26.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CSNetWorkSuccessCompletion)(CSNetResponseModel * response);
typedef void(^CSNetWorkFailureCompletion)(NSError * error);
@interface CSNewShopNetManage : NSObject
+ (instancetype)sharedManager;

@property (nonatomic, strong)AFHTTPSessionManager  * netManager;
//商城首页banner数据
- (void)getShopBannerInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//商城首页分类数据
- (void)getShopCategopryListSuccessWithLimit:(NSString *)limit Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//商城列表数据
- (void)getShopCategopryListSuccessWithCid:(NSString *)cid withKey:(NSString *)key withPage:(NSString *)page withLimit:(NSString *)limit Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//商城商品详情数据
- (void)getShopListDetailSuccessWithCid:(NSString *)shopId Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//商城商品购物车ID
- (void)getShopListShopCartIdSuccessWithproductId:(NSString *)shopId Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//商城商品订单key
- (void)getShopListShopCartIdSuccessWithcart_id:(NSString *)shopId Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//商城地址列表
- (void)getShopAddressListShopSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//商城地址新增和修改
- (void)getShopAddressAddAndEdit:(NSDictionary *)dict Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//商城地址删除
- (void)getShopAddressDelete:(NSString *)addressId Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//商品购买
- (void)getBuyShopWith:(NSDictionary *)dict Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

@end

NS_ASSUME_NONNULL_END
