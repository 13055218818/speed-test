//
//  CSCustomCalendarView.m
//  ColorStar
//
//  Created by gavin on 2020/11/28.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSCustomCalendarView.h"
#import "CSCustomCalendarScrollView.h"


@interface CSCustomCalendarView ()

@property (nonatomic, strong)UIView  * weekView;

@property (nonatomic, strong)CSCustomCalendarScrollView * calendarView;

@end

@implementation CSCustomCalendarView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self setupWeekView];
    [self setupDaysView];
    
}

- (void)setupWeekView{
    
    self.weekView = [[UIView alloc]initWithFrame:CGRectMake(12, 0, self.width - 24, 24)];
    [self addSubview:self.weekView];
    
    CGFloat height = self.weekView.height;
    CGFloat width = self.weekView.width / 7.0;
   
    NSArray *weekArray = @[@"Sun.", @"Mon.", @"Tues.", @"Wed.", @"Thur.", @"Fri.", @"Sat."];
    for (int i = 0; i < 7; ++i) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * width, 0.0, width, height)];
        label.backgroundColor = [UIColor clearColor];
        label.text = weekArray[i];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        [self.weekView addSubview:label];
        
    }
    
}

- (void)setupDaysView{
    
    self.calendarView = [[CSCustomCalendarScrollView alloc]initWithFrame:CGRectMake(0, self.weekView.bottom, self.width, self.height - self.weekView.bottom)];
//    [self.calendarView refreshToCurrentMonth];
    CS_Weakify(self, weakSelf);
    self.calendarView.didSelectDayHandler = ^(NSInteger year, NSInteger month, NSInteger day) {
        if (weakSelf.calendarBlock) {
            weakSelf.calendarBlock(year,month,day);
        }
    };
    [self addSubview:self.calendarView];
    
}

- (void)reloadRedInfo:(NSArray*)redInfo{
    [self.calendarView reloadRedInfo:redInfo];
}


@end
