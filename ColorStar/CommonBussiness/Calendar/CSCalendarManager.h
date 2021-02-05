//
//  CSCalendarManager.h
//  ColorStar
//
//  Created by gavin on 2020/11/28.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNetResponseModel.h"

typedef void(^CSCalendarInfoComplete)(CSNetResponseModel * response, NSError * error);

@interface CSCalendarManager : NSObject

+ (instancetype)shared;

- (void)fetchCalendarRedPointInfo:(NSString*)year month:(NSString*)month complete:(CSCalendarInfoComplete)complete;

- (void)fetchCalendarDaysNewsInfo:(NSString*)date complete:(CSCalendarInfoComplete)complete;

- (void)fetchCalendarMonthNewsInfo:(NSString*)date complete:(CSCalendarInfoComplete)complete;

@end


