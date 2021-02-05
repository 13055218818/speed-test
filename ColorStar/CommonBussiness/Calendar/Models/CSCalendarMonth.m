//
//  CSCalendarMonth.m
//  ColorStar
//
//  Created by gavin on 2020/11/28.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSCalendarMonth.h"
#import "NSDate+CSCalendar.h"


@implementation CSCalendarMonth

- (instancetype)initWithDate:(NSDate *)date {
    
    if (self = [super init]) {
        
        _monthDate = date;
        
        _totalDays = [self setupTotalDays];
        _firstWeekday = [self setupFirstWeekday];
        _year = [self setupYear];
        _month = [self setupMonth];
        
    }
    
    return self;
    
}


- (NSInteger)setupTotalDays {
    return [_monthDate totalDaysInMonth];
}

- (NSInteger)setupFirstWeekday {
    return [_monthDate firstWeekDayInMonth];
}

- (NSInteger)setupYear {
    return [_monthDate dateYear];
}

- (NSInteger)setupMonth {
    return [_monthDate dateMonth];
}

@end
