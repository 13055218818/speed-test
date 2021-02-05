//
//  CSNewMineNetManage.h
//  ColorStar
//
//  Created by apple on 2020/12/19.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CSNetWorkSuccessCompletion)(CSNetResponseModel * response);
typedef void(^CSNetWorkFailureCompletion)(NSError * error);
@interface CSNewMineNetManage : NSObject
+ (instancetype)sharedManager;

@property (nonatomic, strong)AFHTTPSessionManager  * netManager;
//我的收藏
- (void)getMineCollectionListInfoSuccessPagge:(NSString *)page withLimit:(NSString *)limit Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
- (void)getMineOrederListInfoSuccessPagge:(NSString *)page withLimit:(NSString *)limit Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
- (void)getDeleteOrederListInfoSuccessOrderId:(NSString *)orderid Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
- (void)getEditInfoSuccessNickname:(NSString *)nickname Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//ios app内购成功
- (void)getAppPaySuccess:(NSDictionary *)dict Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//签到信息
- (void)getSiginInfoComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//签到
- (void)getSiginComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//签到累计奖励
- (void)getSignRewardWithRid:(NSString *)rid Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//签到明细
- (void)getSignListWithPage:(NSString *)page Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//分享内容
-(void)getShareInforComplete:(CSNetWorkSuccessCompletion)success Complete:(CSNetWorkFailureCompletion)failure;

//分享列表
- (void)getShareListWithPage:(NSString *)page Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//获取直播推流地址
- (void)getLiveAddressComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
@end


NS_ASSUME_NONNULL_END
