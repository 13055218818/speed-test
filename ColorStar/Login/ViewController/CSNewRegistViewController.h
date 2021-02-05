//
//  CSNewRegistViewController.h
//  ColorStar
//
//  Created by apple on 2020/11/18.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^CSNewRegistLoginBlock)(BOOL success);
@interface CSNewRegistViewController : CSBaseViewController
@property (nonatomic, strong)NSString  *openId;
@property (nonatomic, copy)CSNewLoginBlock RegistLoginBlock;
@end

NS_ASSUME_NONNULL_END
