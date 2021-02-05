//
//  CSPersonModifyManager.h
//  ColorStar
//
//  Created by gavin on 2020/12/20.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CSPersonModifyComplete)(CSNetResponseModel * response, NSError * error);
@interface CSPersonModifyManager : NSObject

+ (instancetype)shared;

- (void)modifyName:(NSString*)name complete:(CSPersonModifyComplete)complete;

@end


