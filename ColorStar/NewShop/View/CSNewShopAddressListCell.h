//
//  CSNewShopAddressListCell.h
//  ColorStar
//
//  Created by apple on 2020/11/20.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSNewShopModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol CSNewShopAddressListCellCellDelegate <NSObject>
- (void)CSNewShopAddressListCellEditButton:(CSNewShopAddressModel *)model;
@end
@interface CSNewShopAddressListCell : UITableViewCell
@property (nonatomic, strong)CSNewShopAddressModel  *model;
@property(nonatomic,weak)id<CSNewShopAddressListCellCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
