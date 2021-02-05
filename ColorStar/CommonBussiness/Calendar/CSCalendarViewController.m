//
//  CSCalendarViewController.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/24.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSCalendarViewController.h"
#import "CSCalendarNewsModel.h"
#import "CSCalendarDayRecommandCell.h"
#import "CSCalendarMonthRecommandCell.h"
#import "CSCalendarDayHeaderView.h"
#import "CSCalendarMonthHeaderView.h"
#import "CSCalendarFooterView.h"
#import "CSTopCalendarView.h"
#import "NSDate+CSCalendar.h"
#import "CSCalendarManager.h"
#import "CSCalendarRedPointInfo.h"
#import "CSCalendarTitleCell.h"
#import "CSCalendarFooterCell.h"
#import "CSTutorPlayViewController.h"
#import "CSCalendarNewsInfoModel.h"
#import "CSWebViewController.h"

@interface CSCalendarViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UIView          * navView;

@property (nonatomic, strong)UILabel         * titleLabel;

@property (nonatomic, strong)UITableView     * tableView;

@property (nonatomic, strong)CSTopCalendarView  * calendarView;

@property (nonatomic, strong)NSMutableArray     * dayNews;

@property (nonatomic, strong)NSMutableArray     * monthNews;

@end

@implementation CSCalendarViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = LoadColor(@"#181F30");
    
    [self addNotificationObserver];
    [self setupViews];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    NSDate *currentDate = [calendar dateFromComponents:components];

    NSString *  year = [@([currentDate dateYear]) stringValue];
    NSString *  month = [@([currentDate dateMonth]) stringValue];
    NSString *  day = [@([currentDate dateDay]) stringValue];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@ %@",[NSString cs_getMonthEngish:month],year];

    [self fetchDayNews:year month:month day:day];
    [self fetchRedPointInfo:year month:month];
}

- (void)setupViews{
    
    self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, self.view.width, 44)];
    [self.view addSubview:self.navView];
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:LoadImage(@"cs_nav_back") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(self.navView);
        make.width.height.mas_equalTo(26);
    }];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.navView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.navView);
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navView.bottom, self.view.width, self.view.height - self.navView.bottom) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = LoadColor(@"#181F30");
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarStatusHeight, 0);
    [self.tableView registerClass:[CSCalendarDayRecommandCell class] forCellReuseIdentifier:[CSCalendarDayRecommandCell reuserIndentifier]];
    [self.tableView registerClass:[CSCalendarMonthRecommandCell class] forCellReuseIdentifier:[CSCalendarMonthRecommandCell reuserIndentifier]];
    [self.tableView registerClass:[CSCalendarTitleCell class] forCellReuseIdentifier:[CSCalendarTitleCell reuserIndentifier]];
    [self.tableView registerClass:[CSCalendarFooterCell class] forCellReuseIdentifier:[CSCalendarFooterCell reuserIndentifier]];
    
    [self.tableView registerClass:[CSCalendarDayHeaderView class] forHeaderFooterViewReuseIdentifier:@"CSCalendarDayHeaderViewReuseIdentifier"];
    [self.tableView registerClass:[CSCalendarMonthHeaderView class] forHeaderFooterViewReuseIdentifier:@"CSCalendarMonthHeaderViewReuseIdentifier"];
    [self.tableView registerClass:[CSCalendarFooterView class] forHeaderFooterViewReuseIdentifier:@"CSCalendarFooterViewReuseIdentifier"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    
    self.calendarView = [[CSTopCalendarView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 312)];
    self.tableView.tableHeaderView = self.calendarView;
    CS_Weakify(self, weakSelf);
    self.calendarView.calendarBlock = ^(NSInteger year, NSInteger month, NSInteger day) {
        [weakSelf fetchDayNews:[@(year) stringValue] month:[@(month) stringValue] day:[@(day) stringValue]];
    };
    
}

- (void)addNotificationObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCalendarHeaderAction:) name:@"ChangeCalendarHeaderNotification" object:nil];
}

- (void)fetchDayNews:(NSString*)year month:(NSString*)month day:(NSString*)day{
    
    [self showProgressHUD];
    CS_Weakify(self, weakSelf);
    NSString * date = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
    [[CSCalendarManager shared] fetchCalendarDaysNewsInfo:date complete:^(CSNetResponseModel *response, NSError *error) {
        [weakSelf hideProgressHUD];
        if ([response.data isKindOfClass:[NSDictionary class]]) {
            [weakSelf.monthNews removeAllObjects];
            [weakSelf.dayNews removeAllObjects];
            
            NSDictionary * data = response.data;
            NSArray * monthList = [data valueForKey:@"month_list"];
            NSArray * dayList = [data valueForKey:@"day_list"];
            
            for (NSDictionary * dict in monthList) {
                CSCalendarNewsInfoModel * model = [CSCalendarNewsInfoModel yy_modelWithDictionary:dict];
                [weakSelf.monthNews addObject:model];
            }
            for (NSDictionary * dict in dayList) {
                CSCalendarNewsInfoModel * model = [CSCalendarNewsInfoModel yy_modelWithDictionary:dict];
                [weakSelf.dayNews addObject:model];
            }
            [weakSelf.tableView reloadData];
        }
    }];
    
}

- (void)fetchMonthNews:(NSString*)year month:(NSString*)month {
    
    
}

- (void)fetchRedPointInfo:(NSString*)year month:(NSString*)month{
    
    [[CSCalendarManager shared] fetchCalendarRedPointInfo:year month:month complete:^(CSNetResponseModel *response, NSError *error) {
        
        if (response) {
            if ([response.data isKindOfClass:[NSArray class]]) {
                NSMutableArray * reds = [NSMutableArray arrayWithCapacity:0];
                NSArray * sourseList = (NSArray*)response.data;
                for (NSDictionary * dict in sourseList) {
                    CSCalendarRedPointInfoModel * model = [CSCalendarRedPointInfoModel yy_modelWithDictionary:dict];
                    if (model.is_show) {
                        [reds addObject:model.date];
                    }
                }
                [self.calendarView reloadRedInfo:reds];
            }
        }
        
    }];
    
    
}

- (void)changeCalendarHeaderAction:(NSNotification *)sender {
    
    NSDictionary *dic = sender.userInfo;
    
    NSString *year = [dic[@"year"] stringValue];
    NSString *month = [dic[@"month"] stringValue];
    
    NSString *title = [NSString stringWithFormat:@"%@ %@",[NSString cs_getMonthEngish:month],year];
    self.titleLabel.text = title;
    [self fetchRedPointInfo:year month:month];
    [self fetchMonthNews:year month:month];
    
}


#pragma mark - Action Method

- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView DataSourse Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (self.dayNews.count > 0) {
            return self.dayNews.count + 1;
        }
        return 0;
    }else{
        if (self.monthNews.count > 0) {
            return self.monthNews.count + 1;
        }
        return 0;;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CSCalendarTitleCell * titleCell = [tableView dequeueReusableCellWithIdentifier:[CSCalendarTitleCell reuserIndentifier]];
            titleCell.iconImageView.hidden = NO;
            titleCell.titleLabel.text = csnation(@"今日推送");
            
            return titleCell;
            
        }
        CSCalendarDayRecommandCell * dayCell = [tableView dequeueReusableCellWithIdentifier:[CSCalendarDayRecommandCell reuserIndentifier] forIndexPath:indexPath];
        CSCalendarNewsInfoModel * model = self.dayNews[indexPath.row - 1];
        [dayCell mockData];
        [dayCell configModel:model];
        return dayCell;
    }else{
        if (indexPath.row == 0) {
            CSCalendarTitleCell * titleCell = [tableView dequeueReusableCellWithIdentifier:[CSCalendarTitleCell reuserIndentifier]];
            titleCell.iconImageView.hidden = YES;
            titleCell.titleLabel.text = csnation(@"每月推送");
            return titleCell;
        }
        
        if (indexPath.row == 9) {
            CSCalendarFooterCell * footCell = [tableView dequeueReusableCellWithIdentifier:[CSCalendarFooterCell reuserIndentifier]];
            
            return footCell;
        }
        CSCalendarMonthRecommandCell * monthCell = [tableView dequeueReusableCellWithIdentifier:[CSCalendarMonthRecommandCell reuserIndentifier] forIndexPath:indexPath];
        CSCalendarNewsInfoModel * model = self.monthNews[indexPath.row - 1];
        [monthCell mockData];
        [monthCell configModel:model];
        return monthCell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 50;
        }
        return 215;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            return 50;
        }
        if (indexPath.row == 9) {
            return 26;
        }
        return 274;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * url = @"";
    NSString * title = @"";
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return;
        }
        CSCalendarNewsInfoModel * model = self.dayNews[indexPath.row - 1];
        url = model.web_url;
        title = model.title;
    }else{
        if (indexPath.row == 0) {
            return;
        }
        CSCalendarNewsInfoModel * model = self.monthNews[indexPath.row - 1];
        url = model.web_url;
        title = model.title;
    }

    if (![url hasPrefix:@"http"]) {
        url = [NSString stringWithFormat:@"%@%@",[CSAPPConfigManager sharedConfig].baseURL,url];
    }
    
    [[CSWebManager sharedManager] enterWebVCWithURL:url title:title withSupVC:[CSTotalTool getCurrentShowViewController]];
    
    
}

#pragma mark - Properties Method

- (NSMutableArray*)monthNews{
    if (!_monthNews) {
        _monthNews = [NSMutableArray arrayWithCapacity:0];
    }
    return _monthNews;
}

- (NSMutableArray*)dayNews{
    if (!_dayNews) {
        _dayNews = [NSMutableArray arrayWithCapacity:0];
    }
    return _dayNews;
}

@end
