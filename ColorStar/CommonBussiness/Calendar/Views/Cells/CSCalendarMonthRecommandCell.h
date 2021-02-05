//
//  CSCalendarMonthRecommandCell.h
//  LXCalendarDemo
//
//  Created by gavin on 2020/11/26.
//  Copyright © 2020 https://github.com/nick8brown. All rights reserved.
//

#import "CSBaseTableCell.h"

typedef void(^CSCalendarMonthRecommandClick)(void);

@interface CSCalendarMonthRecommandCell : CSBaseTableCell

@property (nonatomic, copy)CSCalendarMonthRecommandClick  monthClick;

@end


