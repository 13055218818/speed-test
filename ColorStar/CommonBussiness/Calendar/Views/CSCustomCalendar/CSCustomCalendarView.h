//
//  CSCustomCalendarView.h
//  ColorStar
//
//  Created by gavin on 2020/11/28.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CSCustomCalendarBlock)(NSInteger year, NSInteger month, NSInteger day);


@interface CSCustomCalendarView : UIView

@property (nonatomic, copy)CSCustomCalendarBlock   calendarBlock;

- (void)reloadRedInfo:(NSArray*)redInfo;

@end


