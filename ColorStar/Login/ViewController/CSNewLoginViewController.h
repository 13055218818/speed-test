//
//  CSNewLoginViewController.h
//  ColorStar
//
//  Created by apple on 2020/11/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^CSNewLoginBlock)(BOOL success);
@interface CSNewLoginViewController : CSBaseViewController
@property (nonatomic, copy)CSNewLoginBlock loginBlock;
@end

NS_ASSUME_NONNULL_END
