//
//  CSNewShopAllListPageViewController.h
//  ColorStar
//
//  Created by apple on 2020/11/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseViewController.h"
#import "JXCategoryListContainerView.h"
#import "CSNewShopModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CSNewShopAllListPageViewController : CSBaseViewController <JXCategoryListContentViewDelegate>
@property (nonatomic, strong)CSNewShopCategoryModel  *firstCategoryModel;
@property (nonatomic, strong)NSString  *searchKey;
@property (nonatomic, strong)NSString  *titleStr;
- (void)loadDataForFirst;
- (void)loadData;
@end

NS_ASSUME_NONNULL_END
