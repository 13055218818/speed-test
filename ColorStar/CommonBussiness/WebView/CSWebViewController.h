//
//  CSWebViewController.h
//  ColorStar
//
//  Created by gavin on 2020/8/6.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseViewController.h"
typedef void(^CSWebViewControllerPayBlock)(BOOL success);
@interface CSWebViewController : CSBaseViewController
@property (nonatomic, strong)NSString *titleStr;
@property (nonatomic, strong)NSString * url;
@property (nonatomic, assign)BOOL  isPresent;
@property (nonatomic, strong)NSString * content;

@property (nonatomic, copy)CSWebViewControllerPayBlock payBlock;

@end


