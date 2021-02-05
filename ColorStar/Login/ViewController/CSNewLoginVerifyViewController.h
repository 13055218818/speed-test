//
//  CSNewLoginVerifyViewController.h
//  ColorStar
//
//  Created by apple on 2020/11/18.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^CSNewLoginVerifyBlock)(BOOL success);
@interface CSNewLoginVerifyViewController : CSBaseViewController
@property (nonatomic, strong)NSString  *phoneStr;
@property (nonatomic, strong)NSString  *prefixStr;
@property (nonatomic, copy)CSNewLoginVerifyBlock LoginVerifyBlock;

@end

NS_ASSUME_NONNULL_END
