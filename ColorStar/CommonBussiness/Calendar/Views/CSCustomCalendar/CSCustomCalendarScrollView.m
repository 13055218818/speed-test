//
//  CSCustomCalendarScrollView.m
//  LXCalendarDemo
//
//  Created by gavin on 2020/11/26.
//  Copyright © 2020 https://github.com/nick8brown. All rights reserved.
//

#import "CSCustomCalendarScrollView.h"
#import "CSCustonCalendarCell.h"
#import "NSDate+CSCalendar.h"
#import "CSCalendarMonth.h"

@interface CSCustomCalendarScrollView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView   * collectionViewL;

@property (nonatomic, strong) UICollectionView   * collectionViewC;

@property (nonatomic, strong) UICollectionView   * collectionViewR;

@property (nonatomic, strong) NSDate            * currentMonthDate;

@property (nonatomic, strong) NSMutableArray    * monthArray;

@property (nonatomic, strong) NSIndexPath       * selectIndexPath;

@property (nonatomic, strong) NSArray           * reds;

@end

@implementation CSCustomCalendarScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.delegate = self;
        
        self.contentSize = CGSizeMake(3 * self.bounds.size.width, self.bounds.size.height);
        [self setContentOffset:CGPointMake(self.bounds.size.width, 0.0) animated:NO];
        
        _currentMonthDate = [NSDate date];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((self.width - 24) / 7.0, 40);
    flowLayout.minimumLineSpacing = 0.0;
    flowLayout.minimumInteritemSpacing = 0.0;
    
    
    CGFloat selfWidth = self.bounds.size.width;
    CGFloat selfHeight = self.bounds.size.height;
    
    self.collectionViewL = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, selfWidth, selfHeight) collectionViewLayout:flowLayout];
    self.collectionViewL.dataSource = self;
    self.collectionViewL.delegate = self;
    self.collectionViewL.backgroundColor = [UIColor clearColor];
    [self.collectionViewL registerClass:[CSCustonCalendarCell class] forCellWithReuseIdentifier:[CSCustonCalendarCell reuserIndentifier]];
    self.collectionViewL.contentInset = UIEdgeInsetsMake(0, 12, 0, 12);
    [self addSubview:self.collectionViewL];
    
    self.collectionViewC = [[UICollectionView alloc] initWithFrame:CGRectMake(selfWidth, 0.0, selfWidth, selfHeight) collectionViewLayout:flowLayout];
    self.collectionViewC.dataSource = self;
    self.collectionViewC.delegate = self;
    self.collectionViewC.backgroundColor = [UIColor clearColor];
    [self.collectionViewC registerClass:[CSCustonCalendarCell class] forCellWithReuseIdentifier:[CSCustonCalendarCell reuserIndentifier]];
    self.collectionViewC.contentInset = UIEdgeInsetsMake(0, 12, 0, 12);
    [self addSubview:self.collectionViewC];
    
    self.collectionViewR = [[UICollectionView alloc] initWithFrame:CGRectMake(selfWidth*2, 0.0, selfWidth, selfHeight) collectionViewLayout:flowLayout];
    self.collectionViewR.dataSource = self;
    self.collectionViewR.delegate = self;
    self.collectionViewR.backgroundColor = [UIColor clearColor];
    [self.collectionViewR registerClass:[CSCustonCalendarCell class] forCellWithReuseIdentifier:[CSCustonCalendarCell reuserIndentifier]];
    self.collectionViewR.contentInset = UIEdgeInsetsMake(0, 12, 0, 12);
    [self addSubview:self.collectionViewR];
    
}

- (void)reloadRedInfo:(NSArray*)redInfo{
    self.reds = redInfo;
    [self.collectionViewC reloadData];
    
}

- (NSMutableArray *)monthArray {
    
    if (!_monthArray) {
        
        _monthArray = [NSMutableArray arrayWithCapacity:4];
        
        NSDate *previousMonthDate = [_currentMonthDate previousMonthDate];
        NSDate *nextMonthDate = [_currentMonthDate nextMonthDate];
        
        [_monthArray addObject:[[CSCalendarMonth alloc] initWithDate:previousMonthDate]];
        [_monthArray addObject:[[CSCalendarMonth alloc] initWithDate:_currentMonthDate]];
        [_monthArray addObject:[[CSCalendarMonth alloc] initWithDate:nextMonthDate]];
        [_monthArray addObject:[self previousMonthDaysForPreviousDate:previousMonthDate]]; // 存储左边的月份的前一个月份的天数，用来填充左边月份的首部
        
        // 发通知，更改当前月份标题
//        [self notifyToChangeCalendarHeader];
    }
    
    return _monthArray;
}

- (NSNumber *)previousMonthDaysForPreviousDate:(NSDate *)date {
    return [[NSNumber alloc] initWithInteger:[[date previousMonthDate] totalDaysInMonth]];
}

- (void)notifyToChangeCalendarHeader {
    
    CSCalendarMonth *currentMonthInfo = self.monthArray[1];
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:2];
    
    [userInfo setObject:[[NSNumber alloc] initWithInteger:currentMonthInfo.year] forKey:@"year"];
    [userInfo setObject:[[NSNumber alloc] initWithInteger:currentMonthInfo.month] forKey:@"month"];
    
    NSNotification *notify = [[NSNotification alloc] initWithName:@"ChangeCalendarHeaderNotification" object:nil userInfo:userInfo];
    [[NSNotificationCenter defaultCenter] postNotification:notify];
}

- (void)refreshToCurrentMonth {
    
    // 如果现在就在当前月份，则不执行操作
    CSCalendarMonth *currentMonthInfo = self.monthArray[1];
    if ((currentMonthInfo.month == [[NSDate date] dateMonth]) && (currentMonthInfo.year == [[NSDate date] dateYear])) {
        return;
    }
    
    _currentMonthDate = [NSDate date];
    
    NSDate *previousMonthDate = [_currentMonthDate previousMonthDate];
    NSDate *nextMonthDate = [_currentMonthDate nextMonthDate];
    
    [self.monthArray removeAllObjects];
    [self.monthArray addObject:[[CSCalendarMonth alloc] initWithDate:previousMonthDate]];
    [self.monthArray addObject:[[CSCalendarMonth alloc] initWithDate:_currentMonthDate]];
    [self.monthArray addObject:[[CSCalendarMonth alloc] initWithDate:nextMonthDate]];
    [self.monthArray addObject:[self previousMonthDaysForPreviousDate:previousMonthDate]];
    
    // 刷新数据
    [self.collectionViewC reloadData];
    [self.collectionViewL reloadData];
    [self.collectionViewR reloadData];
    
}


#pragma mark - UICollectionDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 42; // 7 * 6
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CSCustonCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CSCustonCalendarCell reuserIndentifier] forIndexPath:indexPath];
    
    cell.redPoint.hidden = YES;
    if (collectionView == self.collectionViewL) {
        
        CSCalendarMonth *monthInfo = self.monthArray[0];
        NSInteger firstWeekday = monthInfo.firstWeekday;
        NSInteger totalDays = monthInfo.totalDays;
        
        // 当前月
        if (indexPath.row >= firstWeekday && indexPath.row < firstWeekday + totalDays) {
            cell.dataLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row - firstWeekday + 1];
            cell.currentType = CSCustonCalendarTypeNormal;
            
            if (self.selectIndexPath && [self.selectIndexPath isEqual:indexPath]) {
                cell.currentType = CSCustonCalendarTypeSelect;
            }else{
                // 标识今天
                if ((monthInfo.month == [[NSDate date] dateMonth]) && (monthInfo.year == [[NSDate date] dateYear])) {
                    if (indexPath.row == [[NSDate date] dateDay] + firstWeekday - 1) {
                        cell.currentType = CSCustonCalendarTypeSelect;
                    }
                }
            }
            
            
        }
        // 补上前后月的日期，淡色显示
        else if (indexPath.row < firstWeekday) {
            cell.currentType = CSCustonCalendarTypeIgnore;
        } else if (indexPath.row >= firstWeekday + totalDays) {
            cell.currentType = CSCustonCalendarTypeIgnore;
        }
        
        cell.userInteractionEnabled = NO;
        
    }
    else if (collectionView == self.collectionViewC) {
        
        CSCalendarMonth *monthInfo = self.monthArray[1];
        NSInteger firstWeekday = monthInfo.firstWeekday;
        NSInteger totalDays = monthInfo.totalDays;
        
        // 当前月
        if (indexPath.row >= firstWeekday && indexPath.row < firstWeekday + totalDays) {
            
            cell.dataLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row - firstWeekday + 1];
            cell.currentType = CSCustonCalendarTypeNormal;
            cell.userInteractionEnabled = YES;
            
            NSString * date = [NSString stringWithFormat:@"%ld-%ld-%ld",monthInfo.year,monthInfo.month,(indexPath.row - firstWeekday + 1)];
            for (NSString * red in self.reds) {
                if ([red isEqualToString:date]) {
                    cell.redPoint.hidden = NO;
                    break;
                }
            }
            
            if (self.selectIndexPath) {
                if (self.selectIndexPath == indexPath) {
                    cell.currentType = CSCustonCalendarTypeSelect;
                }
            }else{
                // 标识今天
                if ((monthInfo.month == [[NSDate date] dateMonth]) && (monthInfo.year == [[NSDate date] dateYear])) {
                    if (indexPath.row == [[NSDate date] dateDay] + firstWeekday - 1) {
                        cell.currentType = CSCustonCalendarTypeSelect;
                    }
                }
            }
            
        }
        // 补上前后月的日期，淡色显示
        else if (indexPath.row < firstWeekday) {
            cell.currentType = CSCustonCalendarTypeIgnore;
            cell.userInteractionEnabled = NO;
        } else if (indexPath.row >= firstWeekday + totalDays) {
            cell.currentType = CSCustonCalendarTypeIgnore;
            cell.userInteractionEnabled = NO;
        }
        
    }
    else if (collectionView == self.collectionViewR) {
        
        CSCalendarMonth *monthInfo = self.monthArray[2];
        NSInteger firstWeekday = monthInfo.firstWeekday;
        NSInteger totalDays = monthInfo.totalDays;
        
        // 当前月
        if (indexPath.row >= firstWeekday && indexPath.row < firstWeekday + totalDays) {
            
            cell.dataLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row - firstWeekday + 1];
            cell.currentType = CSCustonCalendarTypeNormal;
            
            // 标识今天
            if ((monthInfo.month == [[NSDate date] dateMonth]) && (monthInfo.year == [[NSDate date] dateYear])) {
                if (indexPath.row == [[NSDate date] dateDay] + firstWeekday - 1) {
                    cell.currentType = CSCustonCalendarTypeSelect;
                }
            }
            
        }
        // 补上前后月的日期，淡色显示
        else if (indexPath.row < firstWeekday) {
            cell.currentType = CSCustonCalendarTypeIgnore;
        } else if (indexPath.row >= firstWeekday + totalDays) {
            cell.currentType = CSCustonCalendarTypeIgnore;
        }
        
        cell.userInteractionEnabled = NO;
        
    }
    
    return cell;
    
}


#pragma mark - UICollectionViewDeleagate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CSCalendarMonth *monthInfo = self.monthArray[1];
    NSInteger firstWeekday = monthInfo.firstWeekday;
    NSInteger totalDays = monthInfo.totalDays;
    
    // 当前月
    if (indexPath.row >= firstWeekday && indexPath.row < firstWeekday + totalDays) {
        
        self.selectIndexPath = indexPath;
        [self.collectionViewC reloadData];
        
        if (self.didSelectDayHandler) {
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:_currentMonthDate];
            NSDate *currentDate = [calendar dateFromComponents:components];

            NSInteger year = [currentDate dateYear];
            NSInteger month = [currentDate dateMonth];
            NSInteger day = [currentDate dateDay];
            
            self.didSelectDayHandler(year, month, day); // 执行回调
        }
    }
    
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView != self) {
        return;
    }
    
    // 向右滑动
    if (scrollView.contentOffset.x < self.bounds.size.width) {
        
        _currentMonthDate = [_currentMonthDate previousMonthDate];
        NSDate *previousDate = [_currentMonthDate previousMonthDate];
        
        // 数组中最左边的月份现在作为中间的月份，中间的作为右边的月份，新的左边的需要重新获取
        CSCalendarMonth *currentMothInfo = self.monthArray[0];
        CSCalendarMonth *nextMonthInfo = self.monthArray[1];
        
        
        CSCalendarMonth *olderNextMonthInfo = self.monthArray[2];
        
        // 复用 CSCalendarMonth 对象
        olderNextMonthInfo.totalDays = [previousDate totalDaysInMonth];
        olderNextMonthInfo.firstWeekday = [previousDate firstWeekDayInMonth];
        olderNextMonthInfo.year = [previousDate dateYear];
        olderNextMonthInfo.month = [previousDate dateMonth];
        CSCalendarMonth *previousMonthInfo = olderNextMonthInfo;
        
        NSNumber *prePreviousMonthDays = [self previousMonthDaysForPreviousDate:[_currentMonthDate previousMonthDate]];
        
        [self.monthArray removeAllObjects];
        [self.monthArray addObject:previousMonthInfo];
        [self.monthArray addObject:currentMothInfo];
        [self.monthArray addObject:nextMonthInfo];
        [self.monthArray addObject:prePreviousMonthDays];
        
    }
    // 向左滑动
    else if (scrollView.contentOffset.x > self.bounds.size.width) {
        
        _currentMonthDate = [_currentMonthDate nextMonthDate];
        NSDate *nextDate = [_currentMonthDate nextMonthDate];
        
        // 数组中最右边的月份现在作为中间的月份，中间的作为左边的月份，新的右边的需要重新获取
        CSCalendarMonth *previousMonthInfo = self.monthArray[1];
        CSCalendarMonth *currentMothInfo = self.monthArray[2];
        
        
        CSCalendarMonth *olderPreviousMonthInfo = self.monthArray[0];
        
        NSNumber *prePreviousMonthDays = [[NSNumber alloc] initWithInteger:olderPreviousMonthInfo.totalDays]; // 先保存 olderPreviousMonthInfo 的月天数
        
        // 复用 CSCalendarMonth 对象
        olderPreviousMonthInfo.totalDays = [nextDate totalDaysInMonth];
        olderPreviousMonthInfo.firstWeekday = [nextDate firstWeekDayInMonth];
        olderPreviousMonthInfo.year = [nextDate dateYear];
        olderPreviousMonthInfo.month = [nextDate dateMonth];
        CSCalendarMonth *nextMonthInfo = olderPreviousMonthInfo;

        
        [self.monthArray removeAllObjects];
        [self.monthArray addObject:previousMonthInfo];
        [self.monthArray addObject:currentMothInfo];
        [self.monthArray addObject:nextMonthInfo];
        [self.monthArray addObject:prePreviousMonthDays];
        
    }
    self.selectIndexPath = nil;
    [self.collectionViewC reloadData]; // 中间的 collectionView 先刷新数据
    [scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0.0) animated:NO]; // 然后变换位置
    [self.collectionViewL reloadData]; // 最后两边的 collectionView 也刷新数据
    [self.collectionViewR reloadData];
    
    // 发通知，更改当前月份标题
    [self notifyToChangeCalendarHeader];
    
}

@end
