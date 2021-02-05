//
//  CSBaseViewController.h
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^EmptyViewTapBlock)(void);
@interface CSBaseViewController : UIViewController

@property (nonatomic, assign)BOOL firstLoad;

@property (nonatomic, copy)EmptyViewTapBlock  emptyBlock;

- (void)showProgressHUD;

- (void)hideProgressHUD;

- (void)showEmptyView;

- (void)hiddenEmptyView;

@end


