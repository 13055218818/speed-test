//
//  CSCustomCalendarScrollView.h
//  LXCalendarDemo
//
//  Created by gavin on 2020/11/26.
//  Copyright © 2020 https://github.com/nick8brown. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidSelectDayHandler)(NSInteger year, NSInteger month, NSInteger day);

@interface CSCustomCalendarScrollView : UIScrollView

@property (nonatomic, copy) DidSelectDayHandler didSelectDayHandler; // 日期点击回调

- (void)refreshToCurrentMonth; // 刷新 calendar 回到当前日期月份

- (void)reloadRedInfo:(NSArray*)redInfo;

@end


