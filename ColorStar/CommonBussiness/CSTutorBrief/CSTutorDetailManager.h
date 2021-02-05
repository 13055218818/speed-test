//
//  CSTutorDetailManager.h
//  ColorStar
//
//  Created by gavin on 2020/11/21.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNetResponseModel.h"


typedef void(^CSTutorDetailComplete)(CSNetResponseModel * response, NSError*error);

@interface CSTutorDetailManager : NSObject

+ (instancetype)sharedManager;

- (void)fetchTutorInfo:(NSString*)detailId complete:(CSTutorDetailComplete)complete;

@end


