//
//  CSCustonCalendarCell.h
//  LXCalendarDemo
//
//  Created by gavin on 2020/11/26.
//  Copyright © 2020 https://github.com/nick8brown. All rights reserved.
//

#import "CSBaseCollectionCell.h"

typedef enum : NSUInteger {
    CSCustonCalendarTypeNormal,
    CSCustonCalendarTypeSelect,
    CSCustonCalendarTypeIgnore
} CSCustonCalendarType;


@interface CSCustonCalendarCell : CSBaseCollectionCell

@property (nonatomic, strong) UIView *todayCircle; //!< 标示'今天'

@property (nonatomic, strong)UILabel  * dataLabel;//!< 标示日期（几号）

@property (nonatomic, assign) CSCustonCalendarType currentType;

@property (nonatomic, strong)UIView   * redPoint;

@end


