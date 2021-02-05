//
//  CSNewShopAddressListViewController.h
//  ColorStar
//
//  Created by apple on 2020/11/20.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseViewController.h"
#import "CSNewShopModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^CSNewShopAddressListSelectBlock)(CSNewShopAddressModel *model);
@interface CSNewShopAddressListViewController : CSBaseViewController
@property (nonatomic, copy)CSNewShopAddressListSelectBlock  addressBlock;

@end

NS_ASSUME_NONNULL_END
