//
//  NEMediaCaptureEntity.h
//  ColorStar
//
//  Created by apple on 2021/1/11.
//  Copyright © 2021 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NEMediaCaptureEntity : NSObject

+ (instancetype)sharedInstance;

@property(nonatomic, strong) LSVideoParaCtxConfiguration* videoParaCtx;
@property(nonatomic, assign) NSUInteger encodeType;

@end

NS_ASSUME_NONNULL_END
