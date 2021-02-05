//
//  CSNewPayManage.h
//  ColorStar
//
//  Created by apple on 2020/12/16.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CSNewPayManagePaySuccess)(BOOL success);
@interface CSNewPayManage : NSObject
+ (instancetype)sharedManager;
-(void)gotoGoldPayWithPay:(CSNewPayManagePaySuccess)paysuccess;
-(void)gotoMoneyPayWith:(NSString *)specialId WithPay:(CSNewPayManagePaySuccess)paysuccess;
-(void)gotoVipPayWithPay:(CSNewPayManagePaySuccess)paysuccess;
@end

NS_ASSUME_NONNULL_END
