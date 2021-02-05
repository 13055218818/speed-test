//
//  CSIMClient.h
//  ColorStar
//
//  Created by gavin on 2020/9/30.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMS.h"

@interface CSIMClient : NSObject

@property (nonatomic, strong)DMS   * dms;

- (instancetype)initWithClientId:(NSString*)clientId;

@end


