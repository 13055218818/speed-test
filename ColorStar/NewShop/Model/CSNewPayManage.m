//
//  CSNewPayManage.m
//  ColorStar
//
//  Created by apple on 2020/12/16.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewPayManage.h"
#import "YMApplePay.h"
#import "CSNewCourseCategoryView.h"
static CSNewPayManage * manager = nil;
@interface CSNewPayManage()<SKProductsRequestDelegate,SKPaymentTransactionObserver>
@property (nonatomic, strong)CSNewCourseCategoryView    *courseCategorySelectView;
@end
@implementation CSNewPayManage
+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CSNewPayManage alloc]init];
    });
    return manager;
}

- (instancetype)init{
    if (self = [super init]) {
    }
    return self;
}
//直播金币充值
-(void)gotoGoldPayWithPay:(CSNewPayManagePaySuccess)paysuccess{
    if ([[CSNewLoginUserInfoManager sharedManager] isLogin]) {
        if ([CSNewLoginUserInfoManager sharedManager].currentAppVersionInfo.ios_hide) {
            NSArray  *array = @[@"6",@"50",@"98",@"198"];
            NSMutableArray   *listArray = [NSMutableArray array];
            for (NSInteger  i = 0; i < array.count; i ++) {
                CSNewCourseCategoryModel *model = [[CSNewCourseCategoryModel alloc] init];
                model.categoryId = [NSString stringWithFormat:@"w2a.w2am.icolorstar.com%@",array[i]];
                model.name = [NSString stringWithFormat:@"%ld金币",10 *[array[i] integerValue]];
                [listArray addObject:model];
            }
            self.courseCategorySelectView= [[CSNewCourseCategoryView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
            self.courseCategorySelectView.clickBlock = ^(CSNewCourseCategoryModel * _Nonnull model) {
                [[YMApplePay shareIAPManager] addPurchWithProductID:model.categoryId completeHandle:^(IAPPurchType type, NSData * _Nonnull data) {
                    //购买成功后的操作
                    paysuccess(YES);
                }];
                
            };
            [self.courseCategorySelectView refreshUIWith:listArray];
            [self.courseCategorySelectView showView];
            
        }else{
            NSString  *url = [NSString stringWithFormat:@"%@/wap/special/recharge_index.html?from=my&token=%@",[CSAPPConfigManager sharedConfig].baseURL,[CSAPPConfigManager sharedConfig].sessionKey];
            [[CSWebManager sharedManager] enterWebVCWithURL:url title:csnation(@"充值") withSupVC:[CSTotalTool getCurrentShowViewController] successComplete:^(BOOL success) {
                paysuccess(success);
            }];
        }
        
    }else{
        [[CSNewLoginUserInfoManager sharedManager] goToLogin:^(BOOL success) {
            
        }];
    }
    
}

//课程购买
-(void)gotoMoneyPayWith:(NSString *)specialId WithPay:(CSNewPayManagePaySuccess)paysuccess{
    if ([[CSNewLoginUserInfoManager sharedManager] isLogin]) {
        NSString  *url = [NSString stringWithFormat:@"%@/wap/pay/payInfo?special_id=%@&pay_type_num=%@&total_num=%@&mark=''&token=%@",[CSAPPConfigManager sharedConfig].baseURL,specialId,@"60",@"1",[CSAPPConfigManager sharedConfig].sessionKey];
        [[CSWebManager sharedManager] enterWebVCWithURL:url title:@"" withSupVC:[CSTotalTool getCurrentShowViewController] successComplete:^(BOOL success) {
            paysuccess(success);
        }];
    }else{
        [[CSNewLoginUserInfoManager sharedManager] goToLogin:^(BOOL success) {
            
        }];
    }
}
- (void)gotoVipPayWithPay:(CSNewPayManagePaySuccess)paysuccess{
    NSString  *url = [NSString stringWithFormat:@"%@/wap/special/member_manage.html?token=%@",[CSAPPConfigManager sharedConfig].baseURL,[CSAPPConfigManager sharedConfig].sessionKey];
    [[CSWebManager sharedManager] enterWebVCWithURL:url title:@"" withSupVC:[CSTotalTool getCurrentShowViewController] successComplete:^(BOOL success) {
        paysuccess(success);
    }];
}

@end
