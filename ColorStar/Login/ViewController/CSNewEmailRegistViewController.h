//
//  CSNewEmailRegistViewController.h
//  ColorStar
//
//  Created by apple on 2020/12/14.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^CSNewEmailRegistBlock)(BOOL success);
@interface CSNewEmailRegistViewController : CSBaseViewController
@property(nonatomic, strong)NSString        *type;
@property (nonatomic, copy)CSNewEmailRegistBlock EmailRegistBlock;

@end

NS_ASSUME_NONNULL_END
