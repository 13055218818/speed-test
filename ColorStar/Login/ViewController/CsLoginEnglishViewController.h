//
//  CsLoginEnglishViewController.h
//  ColorStar
//
//  Created by apple on 2020/12/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^CSNewLoginEnglishBlock)(BOOL success);
@interface CsLoginEnglishViewController : CSBaseViewController
@property (nonatomic, copy)CSNewLoginEnglishBlock LoginEnglishBlock;
@end

NS_ASSUME_NONNULL_END
