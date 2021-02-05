//
//  CSNewLoginNetManager.h
//  ColorStar
//
//  Created by apple on 2020/12/4.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CSNetWorkSuccessCompletion)(CSNetResponseModel * response);
typedef void(^CSNetWorkFailureCompletion)(NSError * error);
@interface CSNewLoginNetManager : NSObject
+ (instancetype)sharedManager;

@property (nonatomic, strong)AFHTTPSessionManager  * netManager;
//微信授权注册/登陆
- (void)getLoginTokenWithWXCode:(NSString *)code Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//手机号绑定--用于微信注册后
- (void)getLoginToWechatPhoneCode:(NSString *)code  withPhone:(NSString *)phone withOpenid:(NSString *)openId withPwd:(NSString *)pwd Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//验证token获取用户信息
- (void)getUserInfoWithTokenComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

//登录/注册
- (void)getLoginWithPhone:(NSString *)phone withCode:(NSString *)code Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

//登录/注册facebook/google
- (void)getLoginFacebookAndGoogleWithDict:(NSDictionary *)dict Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//密码登录
- (void)getLoginWithPhone:(NSString *)phone withPws:(NSString *)pws Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

//密码重置
- (void)getRestPwdWithPhone:(NSString *)phone withPws:(NSString *)pws withCode:(NSString *)code Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//发送短信验证码
-(void)getSendPhoneCodeWithPhone:(NSString *)phone Withprefix:(NSString *)prefix Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

//发送邮箱验证
-(void)getsendEmailCode:(NSString *)email Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//邮箱注册登陆
-(void)getEmailLoginWithEmail:(NSString *)email WithVerify:(NSString *)verfiy Withpws:(NSString *)pws Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//版本更新接口
- (void)getNewVersionInfoComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
- (void)getAppleLoginWith:(NSDictionary *)dict Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//绑定邀请码
- (void)getUserInviteCodeWith:(NSString *)code Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
@end

NS_ASSUME_NONNULL_END
