//
//  CSShareManager.h
//  ColorStar
//
//  Created by gavin on 2020/12/19.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSShareModel.h"

@interface CSShareManager : NSObject

+ (instancetype)shared;

@property(nonatomic, strong)UIImage         *qcodeImage;

- (void)showShareView;

- (void)shareMessage:(CSShareModel*)shareModel;

@end


