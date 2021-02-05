//
//  CSNewHomeFindView.m
//  ColorStar
//
//  Created by apple on 2020/11/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewHomeFindView.h"
#import "CSHomeRecommendTopBannerCell.h"
#import "CSNewHomeFindSubjiectCell.h"
#import "CSNewHomeFindHotCell.h"
#import "CSNewHomeFindWeekNewCell.h"
#import "CSNewHomeFindHotStudyCell.h"
#import "CSNewHomeNetManager.h"
#import "CSNewHomeRecommendModel.h"
@interface CSNewHomeFindView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger  page;
}
@property (nonatomic, strong)UITableView            *mainTableView;
@property (nonatomic, strong)NSMutableArray         *topArray;
@property (nonatomic, strong)NSMutableArray         *subjectArray;
@property (nonatomic, strong)NSMutableArray         *weekNewArray;
@property (nonatomic, strong)NSMutableArray         *hotArray;
@property (nonatomic, strong)NSMutableArray         *studyArray;

@end
@implementation CSNewHomeFindView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        self.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
        [self makeUI];
        page = 1;
        self.topArray = [NSMutableArray array];
        self.subjectArray = [NSMutableArray array];
        self.weekNewArray = [NSMutableArray array];
        self.hotArray = [NSMutableArray array];
        self.studyArray = [NSMutableArray array];
        [self loadData];
        [self loadFirstData];
        
    }
    return self;
}
- (void)loadData{
    page = 1;
    [self loadListData];
    [self.mainTableView.mj_footer resetNoMoreData];
}

- (void)loadMoreData{
    page ++;
    [self loadListData];
}

- (void)loadListData{
    NSDictionary  *dict = @{@"token":[CSAPPConfigManager sharedConfig].sessionKey,
                            @"page":[NSString stringWithFormat:@"%ld",page],
                            @"limit":@"5"
    };
    
    [[CSTotalTool sharedInstance] showHudInView:[CSTotalTool getCurrentShowViewController].view hint:@""];
    [[CSNewHomeNetManager sharedManager] getFindLiveInfoListSuccessWithDict:dict Complete:^(CSNetResponseModel * _Nonnull response) {
        [self.mainTableView.mj_header endRefreshing];
        [[CSTotalTool sharedInstance] hidHudInView:[CSTotalTool getCurrentShowViewController].view];
        if (response.code == 200) {
           
            NSArray  *array = response.data;
            if (self->page==1) {
                [self.studyArray removeAllObjects];
                if (array.count > 0) {
                    for (NSDictionary  *dict in array) {
                        CSNewHomeFindstudyModel *model = [CSNewHomeFindstudyModel yy_modelWithDictionary:dict];
                        [self.studyArray addObject:model];
                    }
                }
            }else{
                if (array.count > 0) {
                    for (NSDictionary  *dict in array) {
                        CSNewHomeFindstudyModel *model = [CSNewHomeFindstudyModel yy_modelWithDictionary:dict];
                        [self.studyArray addObject:model];
                    }
                    [self.mainTableView.mj_footer endRefreshing];
                }else{
                    [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
        }else{
            [WHToast showMessage:response.msg duration:1.0 finishHandler:nil];
        }
        [self.mainTableView reloadData];
    } failureComplete:^(NSError * _Nonnull error) {
        [[CSTotalTool sharedInstance] hidHudInView:[CSTotalTool getCurrentShowViewController].view];
    }];
}

- (void)loadFirstData{
    [self.topArray removeAllObjects];
    [self.subjectArray removeAllObjects];
    [self.weekNewArray removeAllObjects];
    [self.hotArray removeAllObjects];
    [[CSTotalTool sharedInstance] showHudInView:[CSTotalTool getCurrentShowViewController].view hint:@""];
    [[CSNewHomeNetManager sharedManager] getHomeFindInfoSuccessComplete:^(CSNetResponseModel * _Nonnull response) {
        [[CSTotalTool sharedInstance] hidHudInView:[CSTotalTool getCurrentShowViewController].view];
        [self.mainTableView.mj_header endRefreshing];
        if (response.code == 200) {
            NSDictionary  *dict = response.data;
            NSMutableArray *bannerArray = dict[@"banner"];
            NSMutableArray *subjectArray = dict[@"specialList"];
            NSMutableArray *weekArray = dict[@"weekSpecial"];
            NSMutableArray *hotArray = dict[@"hotList"];
            // NSMutableArray *studyArray = dict[@"studyList"];
            for (NSDictionary  *dict1 in bannerArray) {
                CSNewHomeRecommendBannerModel *model = [CSNewHomeRecommendBannerModel yy_modelWithDictionary:dict1];
                [self.topArray addObject:model];
            }
            for (NSDictionary  *dict2 in subjectArray) {
                CSNewHomeRecommendModel *model = [CSNewHomeRecommendModel yy_modelWithDictionary:dict2];
                [self.subjectArray addObject:model];
            }
            for (NSDictionary  *dict3 in weekArray) {
                CSNewHomeFindWeekModel *model = [CSNewHomeFindWeekModel yy_modelWithDictionary:dict3];
                [self.weekNewArray addObject:model];
            }
            for (NSDictionary  *dict4 in hotArray) {
                CSNewHomeFindHotModel *model = [CSNewHomeFindHotModel yy_modelWithDictionary:dict4];
                [self.hotArray addObject:model];
            }
        }else{
            [WHToast showMessage:response.msg duration:1 finishHandler:nil];
        }
        
        [self.mainTableView reloadData];
        
    } failureComplete:^(NSError * _Nonnull error) {
        [[CSTotalTool sharedInstance] hidHudInView:[CSTotalTool getCurrentShowViewController].view];
    }];
}

- (void)makeUI{
    self.mainTableView = [[UITableView alloc] init];
    self.mainTableView.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.mainTableView registerClass:[CSNewHomeFindSubjiectCell class] forCellReuseIdentifier:@"CSNewHomeFindSubjiectCell"];
    [self.mainTableView registerClass:[CSHomeRecommendTopBannerCell class] forCellReuseIdentifier:@"CSHomeRecommendTopBannerCell"];
    [self.mainTableView registerClass:[CSNewHomeFindHotCell class] forCellReuseIdentifier:@"CSNewHomeFindHotCell"];
    [self.mainTableView registerClass:[CSNewHomeFindWeekNewCell class] forCellReuseIdentifier:@"CSNewHomeFindWeekNewCell"];
    [self.mainTableView registerClass:[CSNewHomeFindHotStudyCell class] forCellReuseIdentifier:@"CSNewHomeFindHotStudyCell"];
    [self addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger  rows;
    switch (section) {
        case 0:
        {
            rows=self.topArray.count > 0 ? 1:0;
        }
            break;
        case 1:
        {
            rows = self.subjectArray.count > 0 ? 1:0;
        }
            break;
        case 2:
        {
            rows = self.weekNewArray.count > 0 ? self.weekNewArray.count:0;
        }
            break;
        case 3:
        {
            rows = self.hotArray > 0 ? 1:0;
        }
            break;
        case 4:
        {
            rows = self.studyArray.count > 0 ? self.studyArray.count:0;
        }
            break;
            
        default:
            break;
    }
    return rows;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat  rowHeight;
    switch (indexPath.section) {
        case 0:
        {
            rowHeight=self.topArray.count > 0 ? 172*heightScale:0;
        }
            break;
        case 1:
        {
            rowHeight = self.subjectArray.count > 0 ? 175*heightScale:0;
        }
            break;
        case 2:
        {
            if (indexPath.row == 0) {
                rowHeight = self.weekNewArray.count > 0 ? 193*heightScale:0;
            }else{
                rowHeight = self.weekNewArray.count > 0 ? 153*heightScale:0;
            }
        }
            break;
        case 3:
        {
            rowHeight = self.hotArray.count > 0 ? 197*heightScale:0;
        }
            break;
        case 4:
        {
            rowHeight=self.studyArray.count > 0 ? 90*heightScale:0;
        }
            break;
            
        default:
            break;
    }
    return rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CSHomeRecommendTopBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSHomeRecommendTopBannerCell"];
        cell.bannerArry = self.topArray;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if(indexPath.section == 1){
        CSNewHomeFindSubjiectCell *cell = [[CSNewHomeFindSubjiectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CSNewHomeFindSubjiectCell" withArray:self.subjectArray];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 2){
        
        CSNewHomeFindWeekNewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSNewHomeFindWeekNewCell"];
        cell.model = self.weekNewArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row != 0) {
            cell.lefTitleLabel.hidden = YES;
            cell.leftImage.hidden = YES;
            cell.isFirst = NO;
        }else{
            cell.lefTitleLabel.hidden = NO;
            cell.leftImage.hidden = NO;
            cell.isFirst = YES;
        }
        return cell;
    }else if(indexPath.section == 3){
        
        CSNewHomeFindHotCell *cell = [[CSNewHomeFindHotCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CSNewHomeFindHotCell" withArray:self.hotArray];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        
        CSNewHomeFindHotStudyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSNewHomeFindHotStudyCell"];
        cell.model = self.studyArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    UIActivityViewControllerCompletionWithItemsHandler itemsBlock = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        NSLog(@"activityType == %@",activityType);
        if (completed == YES) {
            NSLog(@"completed");
        }else{
            NSLog(@"cancel");
        }
    };
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.section == 2) {
            CSTutorPlayViewController * playVC = [[CSTutorPlayViewController alloc]init];
            CSNewHomeFindWeekModel  *model = self.weekNewArray[indexPath.row];
            playVC.videoId = model.source_id;
            [[CSTotalTool getCurrentShowViewController].navigationController pushViewController:playVC animated:YES];
        }
        if (indexPath.section == 4) {
            CSNewHomeFindstudyModel *model = self.studyArray[indexPath.row];
            CSTutorPlayViewController *vc = [CSTutorPlayViewController new];
            //        vc.specialId = model;
            vc.videoId = model.study_id;
            [[CSTotalTool getCurrentShowViewController].navigationController pushViewController:vc animated:YES];
        }
   
}


@end
