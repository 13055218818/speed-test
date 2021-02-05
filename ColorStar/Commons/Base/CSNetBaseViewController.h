//
//  CSNetBaseViewController.h
//  ColorStar
//
//  Created by 陶涛 on 2020/9/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseViewController.h"
#import "CSNetworkManager.h"


@interface CSNetBaseViewController : CSBaseViewController

- (void)processNetWorkSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

- (void)processData:(CSNetResponseModel*)response;


@end


