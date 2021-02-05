//
//  CSNewHomeRecommendView.m
//  ColorStar
//
//  Created by apple on 2020/11/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewHomeRecommendView.h"
#import "CSHomeRecommendArtistCell.h"
#import "CSHomeRecommendTopBannerCell.h"
#import "CSHomeRecommendEveryDayCell.h"
#import "CSHomeRecommendInterestingCell.h"
#import "CSHomeRecommendGuitarCell.h"
#import "CSNewHomeNetManager.h"
#import "CSNewHomeRecommendModel.h"
@interface CSNewHomeRecommendView ()<UITableViewDelegate,UITableViewDataSource,CSHomeRecommendArtistCellDelegate,CSHomeRecommendGuitarCellDelegate>
{
    NSInteger   page;
}
@property (nonatomic, strong)UITableView            *mainTableView;
@property (nonatomic, strong)NSMutableArray         *topArray;
@property (nonatomic, strong)NSMutableArray         *artistArray;
@property (nonatomic, strong)NSMutableArray         *everyDayArray;
@property (nonatomic, strong)NSMutableArray         *everyDayBottomArray;
@property (nonatomic, strong)NSMutableArray         *interestingArray;
@property (nonatomic, strong)NSMutableArray         *guitarArray;
@property (nonatomic, strong)NSMutableArray         *listArray;
@property (nonatomic, strong)CSNewHomeRecommendGuitarModel  *currentGuitarModel;

@end
@implementation CSNewHomeRecommendView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
        self.currentGuitarModel = [[CSNewHomeRecommendGuitarModel alloc] init];
        self.topArray = [NSMutableArray array];
        self.artistArray = [NSMutableArray array];
        self.everyDayArray = [NSMutableArray array];
        self.everyDayBottomArray = [NSMutableArray array];
        self.interestingArray = [NSMutableArray array];
        self.guitarArray = [NSMutableArray array];
        self.listArray = [NSMutableArray array];
        page = 1;
        [self makeUI];
        [self loadData];
        [self loadFirstData];
        
    }
    return self;
}
- (void)loadBestData{
    [[CSNewHomeNetManager sharedManager] getHomeRecommendBestListSuccessComplete:^(CSNetResponseModel * _Nonnull response) {
        if (response.code == 200) {
            [self.guitarArray removeAllObjects];
            NSDictionary *getGuitarDict = response.data;
            CSNewHomeRecommendGuitarModel *model = [CSNewHomeRecommendGuitarModel yy_modelWithDictionary:getGuitarDict];
            self.currentGuitarModel = model;
            for (NSDictionary  *dict6 in model.list) {
                CSNewHomeRecommendGuitarListModel *modellist = [CSNewHomeRecommendGuitarListModel yy_modelWithDictionary:dict6];
                [self.guitarArray addObject:modellist];
            }
        }else{
            [WHToast showMessage:response.msg duration:1.0 finishHandler:nil];
        }
        [self.mainTableView reloadData];
    } failureComplete:^(NSError * _Nonnull error) {
        
    }];
}

-(void)loadFirstData{
    [[CSTotalTool sharedInstance] showHudInView:[CSTotalTool getCurrentShowViewController].view hint:@""];
    // [self.mainTableView.mj_header beginRefreshing];
    [[CSNewHomeNetManager sharedManager] getHomeRecommendInfoSuccessComplete:^(CSNetResponseModel * _Nonnull response) {
        [self.mainTableView.mj_header endRefreshing];
        [[CSTotalTool sharedInstance] hidHudInView:[CSTotalTool getCurrentShowViewController].view];
        [self.topArray removeAllObjects];
        [self.everyDayArray removeAllObjects];
        [self.interestingArray removeAllObjects];
        [self.guitarArray removeAllObjects];
        if (response.code == 200) {
            NSDictionary  *dict = response.data;
            NSMutableArray *bannerArray = dict[@"banner"];
            NSMutableArray *dayChoiceArray = dict[@"dayChoice"];
            NSMutableArray *interestListArray = dict[@"interestList"];
            NSDictionary *getGuitarDict = dict[@"getGuitarList"];
            for (NSDictionary  *dict1 in bannerArray) {
                CSNewHomeRecommendBannerModel *model = [CSNewHomeRecommendBannerModel yy_modelWithDictionary:dict1];
                [self.topArray addObject:model];
            }
            
            for (NSDictionary  *dict3 in dayChoiceArray) {
                CSNewHomeRecommendDayModel *model = [CSNewHomeRecommendDayModel yy_modelWithDictionary:dict3];
                [self.everyDayArray addObject:model];
            }
            for (NSDictionary  *dict4 in interestListArray) {
                CSNewHomeRecommendInterstingModel *model = [CSNewHomeRecommendInterstingModel yy_modelWithDictionary:dict4];
                [self.interestingArray addObject:model];
            }
            
            CSNewHomeRecommendGuitarModel *model = [CSNewHomeRecommendGuitarModel yy_modelWithDictionary:getGuitarDict];
            self.currentGuitarModel = model;
            for (NSDictionary  *dict6 in model.list) {
                CSNewHomeRecommendGuitarListModel *modellist = [CSNewHomeRecommendGuitarListModel yy_modelWithDictionary:dict6];
                [self.guitarArray addObject:modellist];
            }
            
        }else{
            [WHToast showMessage:response.msg duration:1 finishHandler:nil];
        }
        [self.mainTableView reloadData];
        
    } failureComplete:^(NSError * _Nonnull error) {
        [[CSTotalTool sharedInstance] hidHudInView:[CSTotalTool getCurrentShowViewController].view];
        [self.mainTableView.mj_header endRefreshing];
    }];
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
                            @"limit":@"6"
                            
    };
    [[CSTotalTool sharedInstance] showHudInView:[CSTotalTool getCurrentShowViewController].view hint:@""];
    [[CSNewHomeNetManager sharedManager] getHomeRecommendListSuccessWithDict:dict Complete:^(CSNetResponseModel * _Nonnull response) {
        [self.mainTableView.mj_header endRefreshing];
        [[CSTotalTool sharedInstance] hidHudInView:[CSTotalTool getCurrentShowViewController].view];
        if (response.code == 200) {
            NSArray  *specialListArray = response.data;
            if (self->page == 1) {
                [self.artistArray removeAllObjects];
                [self.everyDayBottomArray removeAllObjects];
                [self.listArray removeAllObjects];
                if (specialListArray.count > 0) {
                    for (NSInteger i = 0; i < specialListArray.count; i ++) {
                        NSDictionary *dict = specialListArray[i];
                        CSNewHomeRecommendModel *model = [CSNewHomeRecommendModel yy_modelWithDictionary:dict];
                        if (i<3) {
                            [self.artistArray addObject:model];
                        }else{
                            [self.everyDayBottomArray addObject:model];
                        }
                    }
                }
                
            }else{
                if (specialListArray.count > 0) {
                    for (NSInteger i = 0; i < specialListArray.count; i ++) {
                        NSDictionary *dict = specialListArray[i];
                        CSNewHomeRecommendModel *model = [CSNewHomeRecommendModel yy_modelWithDictionary:dict];
                        [self.listArray addObject:model];
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
        [self.mainTableView.mj_header endRefreshing];
    }];
}


- (void)makeUI{
    self.mainTableView = [[UITableView alloc] init];
    self.mainTableView.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    //下拉刷新
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //self.mainTableView.mj_header.automaticallyChangeAlpha = YES;
    
    [self.mainTableView registerClass:[CSHomeRecommendArtistCell class] forCellReuseIdentifier:@"CSHomeRecommendArtistCell"];
    [self.mainTableView registerClass:[CSHomeRecommendTopBannerCell class] forCellReuseIdentifier:@"CSHomeRecommendTopBannerCell"];
    [self.mainTableView registerClass:[CSHomeRecommendEveryDayCell class] forCellReuseIdentifier:@"CSHomeRecommendEveryDayCell"];
    [self.mainTableView registerClass:[CSHomeRecommendInterestingCell class] forCellReuseIdentifier:@"CSHomeRecommendInterestingCell"];
    [self.mainTableView registerClass:[CSHomeRecommendGuitarCell class] forCellReuseIdentifier:@"CSHomeRecommendGuitarCell"];
    [self addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger  rows = 0;
    switch (section) {
        case 0:
        {
            rows= self.topArray.count > 0 ? 1:0;
        }
            break;
        case 1:
        {
            rows = self.artistArray.count > 0 ? self.artistArray.count:0;
        }
            break;
        case 2:
        {
            rows = self.everyDayArray.count > 0 ? 1:0;
        }
            break;
        case 3:
        {
            rows = self.everyDayBottomArray.count > 0 ? self.everyDayBottomArray.count:0;
        }
            break;
        case 4:
        {
            rows = self.interestingArray.count > 0 ? 1:0;
        }
            break;
        case 5:
        {
            rows = self.guitarArray.count > 0 ? 1:0;
            
            
        }
            break;
        case 6:
        {
            rows = self.listArray.count > 0 ? self.listArray.count:0;
            
            
        }
            break;
        default:
            break;
    }
    return rows;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat  rowHeight = 0.0;
    switch (indexPath.section) {
        case 0:
        {
            rowHeight=self.topArray.count > 0 ? 172*heightScale:0;
        }
            break;
        case 1:
        {
            rowHeight = self.artistArray.count > 0 ? 267*heightScale:0;
        }
            break;
        case 2:
        {
            rowHeight = self.everyDayArray.count > 0 ? 196*heightScale:0;
        }
            break;
        case 3:
        {
            rowHeight = self.everyDayBottomArray.count > 0 ? 267*heightScale:0;
        }
            break;
        case 4:
        {
            rowHeight = self.interestingArray.count > 0 ? 230*heightScale:0;
        }
            break;
        case 5:
        {
            if (self.guitarArray.count%2 == 0) {
                rowHeight = 157*heightScale *self.guitarArray.count/2 + 52*heightScale;
            }else{
                rowHeight = 157*heightScale *(self.guitarArray.count/2+1) + 52*heightScale;
            }
        }
            break;
        case 6:
        {
            rowHeight = self.listArray.count > 0 ? 267*heightScale:0;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.bannerArry = self.topArray;
        return cell;
        
    } else if(indexPath.section == 1){
        CSHomeRecommendArtistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSHomeRecommendArtistCell"];
        cell.userInteractionEnabled = YES;
        CSNewHomeRecommendModel *model = self.artistArray[indexPath.row];
        cell.delegate = self;
        cell.model= model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 2){
        
        CSHomeRecommendEveryDayCell *cell = [[CSHomeRecommendEveryDayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CSHomeRecommendEveryDayCell" with:self.everyDayArray];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 3){
        
        CSHomeRecommendArtistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSHomeRecommendArtistCell"];
        CSNewHomeRecommendModel *model = self.everyDayBottomArray[indexPath.row];
        cell.model= model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 4){
        
        CSHomeRecommendInterestingCell *cell = [[CSHomeRecommendInterestingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CSHomeRecommendInterestingCell" with:self.interestingArray];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 5){
        CSHomeRecommendGuitarCell *cell = [[CSHomeRecommendGuitarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CSHomeRecommendGuitarCell" withArray:self.guitarArray];
        cell.delegate = self;
        cell.model = self.currentGuitarModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        CSHomeRecommendArtistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSHomeRecommendArtistCell"];
        cell.userInteractionEnabled = YES;
        CSNewHomeRecommendModel *model = self.listArray[indexPath.row];
        cell.delegate = self;
        cell.model= model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            CSNewHomeRecommendModel *model = self.artistArray[indexPath.row];
            CSTutorDetailViewController *vc = [CSTutorDetailViewController new];
            vc.tutorId = model.specialId;
            [[CSTotalTool getCurrentShowViewController].navigationController pushViewController:vc animated:YES ];
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            CSNewHomeRecommendModel *model = self.everyDayBottomArray[indexPath.row];
            CSTutorDetailViewController *vc = [CSTutorDetailViewController new];
            vc.tutorId = model.specialId;
            [[CSTotalTool getCurrentShowViewController].navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 4:
        {
            
        }
            break;
        case 5:
        {
            
        }
            break;
        case 6:
        {
            CSNewHomeRecommendModel *model = self.listArray[indexPath.row];
            CSTutorDetailViewController *vc = [CSTutorDetailViewController new];
            vc.tutorId = model.specialId;
            [[CSTotalTool getCurrentShowViewController].navigationController pushViewController:vc animated:YES ];
        }
            break;
        default:
            break;
    }
}

#pragma mark--CellDelegate--
- (void)CSHomeRecommendArtistCellPlayButton:(CSNewHomeRecommendModel *)model{
    CSTutorDetailViewController *vc = [CSTutorDetailViewController new];
    vc.tutorId = model.specialId;
    [[CSTotalTool getCurrentShowViewController].navigationController pushViewController:vc animated:YES];
    
}

- (void)CSHomeRecommendGuitarCellPlayButton:(CSNewHomeRecommendGuitarListModel *)model{
        CSTutorPlayViewController *vc = [CSTutorPlayViewController new];
        vc.videoId = model.guitarId;
        [[CSTotalTool getCurrentShowViewController].navigationController pushViewController:vc animated:YES];


}

- (void)CSHomeRecommendGuitarCellChangeButton{
    [self loadBestData];
}
@end
