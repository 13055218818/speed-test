//
//  CSTopCalendarView.h
//  ColorStar
//
//  Created by 陶涛 on 2020/11/24.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CSTopCalendarBlock)(NSInteger year, NSInteger month, NSInteger day);

@interface CSTopCalendarView : UIView

@property (nonatomic, copy)CSTopCalendarBlock  calendarBlock;

- (void)reloadRedInfo:(NSArray*)redInfo;

@end


