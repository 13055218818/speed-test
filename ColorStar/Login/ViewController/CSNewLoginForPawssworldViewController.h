//
//  CSNewLoginForPawssworldViewController.h
//  ColorStar
//
//  Created by apple on 2020/11/18.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^CSNewLoginForPawssworlLoginBlock)(BOOL success);
@interface CSNewLoginForPawssworldViewController : CSBaseViewController
@property (nonatomic, copy)CSNewLoginForPawssworlLoginBlock PawssworlLoginBlock;
@end

NS_ASSUME_NONNULL_END
