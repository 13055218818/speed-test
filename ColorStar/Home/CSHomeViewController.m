//
//  CSHomeViewController.m
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeViewController.h"
#import "CSSearchViewController.h"
#import <Masonry.h>
#import "UIView+CS.h"
#import "UIColor+CS.h"
#import "CSColorStar.h"

#import "CSHomeSearchBarCell.h"
#import "CSHomeCycleCell.h"
#import "CSHomeActorIconCell.h"
#import "CSHomeCategoryCell.h"
#import "CSHomePressCell.h"
#import "CSHomeSmallCell.h"
#import "CSHomeSquareCell.h"
#import "CSHomeBigCell.h"
#import "CSHomeCheckCell.h"
#import "CSHomeTopicHeaderReusableView.h"
#import "CSHomeLiveModel.h"
#import "CSHomeLiveCell.h"

#import "CSNetworkManager.h"
#import "CSHomeCycleModel.h"
#import "CSHomeCategoryModel.h"
#import "CSHomePressModel.h"
#import "CSHomeTopicSectionModel.h"
#import <YYModel.h>
#import "CSEmptyRefreshView.h"
#import <MBProgressHUD.h>
#import "CSSearchViewController.h"
#import "CSRouterManger.h"
#import "CSLoginManager.h"
#import "CSArtorDetailViewController.h"
#import "CSWebViewController.h"
#import "CSHomeMoreViewController.h"
#import "CSLiveListViewController.h"
#import <MJRefresh/UIScrollView+MJRefresh.h>

//视频播放
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import <ZFPlayer/UIView+ZFFrame.h>
#import <ZFPlayer/ZFPlayerConst.h>
#import "AppDelegate.h"
#import <MJRefresh/MJRefresh.h>

typedef NS_ENUM(NSUInteger, CSHomeCollectionSectionType) {
    CSHomeCollectionSectionTypeSearch = 0,//搜索
    CSHomeCollectionSectionTypeCycle = 1,//轮播图
    CSHomeCollectionSectionTypeCategory = 2,//分类
    CSHomeCollectionSectionTypePress = 3,//新闻
    CSHomeCollectionSectionTypeLive = 4,//直播
    CSHomeCollectionSectionTypeTopic = 5//话题
};

NSString * const CSHomeSearchBarCellReuseIdentifier = @"CSHomeSearchBarCellReuseIdentifier";
NSString * const CSHomeCycleCellReuseIdentifier     = @"CSHomeCycleCellReuseIdentifier";
NSString * const CSHomeActorIconCellReuseIdentifier = @"CSHomeActorIconCellReuseIdentifier";
NSString * const CSHomeCategoryCellReuseIdentifier  = @"CSHomeCategoryCellReuseIdentifier";
NSString * const CSHomePressCellReuseIdentifier     = @"CSHomePressCellReuseIdentifier";
NSString * const CSHomeLiveCellReuseIdentifier      = @"CSHomeLiveCellReuseIdentifier";
NSString * const CSHomeSmallCellReuseIdentifier     = @"CSHomeSmallCellReuseIdentifier";
NSString * const CSHomeSquareCellReuseIdentifier    = @"CSHomeSquareCellReuseIdentifier";
NSString * const CSHomeBigCellReuseIdentifier       = @"CSHomeBigCellReuseIdentifier";
NSString * const CSHomeCheckCellReuseIdentifier     = @"CSHomeCheckCellReuseIdentifier";
NSString * const CSHomeTopicHeaderReusableViewReuseIdentifier = @"CSHomeTopicHeaderReusableViewReuseIdentifier";

@interface CSHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)CSEmptyRefreshView  * refreshView;

@property (nonatomic, strong)UICollectionView    * collectionView;

@property (nonatomic, strong)NSMutableArray      * banners;//轮播图

@property (nonatomic, strong)NSMutableArray      * categories;//分类

@property (nonatomic, strong)NSMutableArray      * presses;//新闻

@property (nonatomic, strong)NSMutableArray      * lives;//直播

@property (nonatomic, assign)NSInteger             sectionCount;

@property (nonatomic, strong)NSMutableArray<CSHomeTopicSectionModel*>      * topicList;//专题

@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) ZFPlayerControlView *controlView;

@end

@implementation CSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = nil;
    self.title = NSLocalizedString(@"彩色世界", nil);
    self.view.backgroundColor = [UIColor colorWithHexString:@"#121212"];
    
    self.firstLoad = YES;
    self.sectionCount = 5;

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.firstLoad) {
        [self loadDataWithFresh:YES];
        
        self.refreshView = [[CSEmptyRefreshView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:self.refreshView];
        self.refreshView.frame = self.view.bounds;
        CS_Weakify(self, weakSelf);
        self.refreshView.refreshBlock = ^{
            [weakSelf loadDataWithFresh:YES];
        };
        self.refreshView.hidden = YES;
        [self initPlayer];
    }
    self.firstLoad = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.player stop];
}

- (void)loadDataWithFresh:(BOOL)refresh{
    
    if (refresh) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.refreshView.hidden = YES;
    }
    [[CSNetworkManager sharedManager] getHomeInfoSuccessComplete:^(CSNetResponseModel * response) {
        if (refresh) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }else{
            [self.collectionView.mj_header endRefreshing];
        }
        [self reloadResponse:response withreFresh:refresh];
        
    } failureComplete:^(NSError *error) {
        if (refresh) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.refreshView.hidden = NO;
        }
        
    }];
}

- (void)reloadResponse:(CSNetResponseModel*)response withreFresh:(BOOL)refresh{
    
    NSDictionary * dict = (NSDictionary*)response.data;
    
    //轮播图
    NSArray * banners = [dict valueForKey:@"banner"];
    [self.banners removeAllObjects];
    if (banners.count > 0) {
        for (NSDictionary * dict in banners) {
            CSHomeCycleModel * cycleModel = [CSHomeCycleModel yy_modelWithDictionary:dict];
            [self.banners addObject:cycleModel];
        }
    }
    
    //分类模块
    NSArray * categories = [dict valueForKey:@"recommend"];
    [self.categories removeAllObjects];
    if (categories.count > 0) {
        for (NSDictionary * dict in categories) {
            CSHomeCategoryModel * model = [CSHomeCategoryModel yy_modelWithDictionary:dict];
            [self.categories addObject:model];
        }
    }
    
    //直播模块
    NSArray * lives = [dict valueForKey:@"liveList"];
    [self.lives removeAllObjects];
    if (lives.count > 0) {
        for (NSDictionary * dict in lives) {
            CSHomeLiveModel * model = [CSHomeLiveModel yy_modelWithDictionary:dict];
            [self.lives addObject:model];
        }
    }
    
    
    
    //新闻
    NSArray * articles = [dict valueForKey:@"articles"];
    [self.presses removeAllObjects];
    if (articles.count > 0) {
        for (NSDictionary * dict in articles) {
            CSHomePressModel * pressModel = [CSHomePressModel yy_modelWithDictionary:dict];
            [self.presses addObject:pressModel];
        }
    }
    
    //专题分类
    NSDictionary * content = [dict valueForKey:@"content_recommend"];
    NSArray * recommend = [content valueForKey:@"recommend"];
    [self.topicList removeAllObjects];
    if (recommend.count > 0) {
        for (NSDictionary * dict in recommend) {
            CSHomeTopicSectionModel * sectionModel = [CSHomeTopicSectionModel yy_modelWithDictionary:dict];
            if (sectionModel.list.count > 0) {
                for (CSHomeTopicBaseModel * baseModel in sectionModel.list) {
                    if (baseModel.topicType == CSHomeTopicBaseModelTypeLive) {
                        sectionModel.liveSection = YES;
                        break;
                    }
                }
                if (!sectionModel.liveSection) {
                    [self.topicList addObject:sectionModel];
                }
            }
        }
    }
    if (refresh) {
        [self setupViews];
    }
    [self.collectionView reloadData];
    
}

- (void)setupViews{
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[CSHomeSearchBarCell class] forCellWithReuseIdentifier:CSHomeSearchBarCellReuseIdentifier];
    [self.collectionView registerClass:[CSHomeCycleCell class] forCellWithReuseIdentifier:CSHomeCycleCellReuseIdentifier];
    [self.collectionView registerClass:[CSHomeActorIconCell class] forCellWithReuseIdentifier:CSHomeActorIconCellReuseIdentifier];
    [self.collectionView registerClass:[CSHomeCategoryCell class] forCellWithReuseIdentifier:CSHomeCategoryCellReuseIdentifier];
    [self.collectionView registerClass:[CSHomePressCell class] forCellWithReuseIdentifier:CSHomePressCellReuseIdentifier];
    [self.collectionView registerClass:[CSHomeLiveCell class] forCellWithReuseIdentifier:CSHomeLiveCellReuseIdentifier];
    [self.collectionView registerClass:[CSHomeSmallCell class] forCellWithReuseIdentifier:CSHomeSmallCellReuseIdentifier];
    [self.collectionView registerClass:[CSHomeSquareCell class] forCellWithReuseIdentifier:CSHomeSquareCellReuseIdentifier];
    [self.collectionView registerClass:[CSHomeBigCell class] forCellWithReuseIdentifier:CSHomeBigCellReuseIdentifier];
    [self.collectionView registerClass:[CSHomeCheckCell class] forCellWithReuseIdentifier:CSHomeCheckCellReuseIdentifier];
    
    [self.collectionView registerClass:[CSHomeTopicHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CSHomeTopicHeaderReusableViewReuseIdentifier];
    
    CS_Weakify(self, weakSelf);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadDataWithFresh:NO];
    }];
    
}

#pragma mark init Player

- (void)initPlayer{
    
     /// playerManager
        ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    //    ZFIJKPlayerManager *playerManager = [[ZFIJKPlayerManager alloc] init];
        
        /// player的tag值必须在cell里设置
        self.player = [ZFPlayerController playerWithScrollView:self.collectionView playerManager:playerManager containerViewTag:100];
        self.player.controlView = self.controlView;
        self.player.shouldAutoPlay = YES;
        
//        @zf_weakify(self)
        self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
//            kAPPDelegate.allowOrentitaionRotation = isFullScreen;
            ((AppDelegate*)[UIApplication sharedApplication].delegate).allowOrentitaionRotation = isFullScreen;
        };
        
        self.player.playerDidToEnd = ^(id  _Nonnull asset) {
//            @zf_strongify(self)
//            if (self.player.playingIndexPath.row < self.dataSource.count - 1) {
//                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.player.playingIndexPath.row+1 inSection:0];
//                [self playTheVideoAtIndexPath:indexPath scrollAnimated:YES];
//            } else {
//                [self.player.currentPlayerManager replay];
//            }
        };
        
        /// 停止的时候找出最合适的播放
    CS_Weakify(self, weakSelf);
        self.player.zf_scrollViewDidEndScrollingCallback = ^(NSIndexPath * _Nonnull indexPath) {
//            @zf_strongify(self)
            [weakSelf playTheVideoAtIndexPath:indexPath scrollAnimated:NO];
        };
        
        /*
         
        /// 滑动中找到适合的就自动播放
        /// 如果是停止后再寻找播放可以忽略这个回调
        /// 如果在滑动中就要寻找到播放的indexPath，并且开始播放，那就要这样写
        self.player.zf_playerShouldPlayInScrollView = ^(NSIndexPath * _Nonnull indexPath) {
            @zf_strongify(self)
            if ([indexPath compare:self.player.playingIndexPath] != NSOrderedSame) {
                [self playTheVideoAtIndexPath:indexPath scrollAnimated:NO];
            }
        };
         
        */
    
}

/// play the video
- (void)playTheVideoAtIndexPath:(NSIndexPath *)indexPath scrollAnimated:(BOOL)animated {
    
    if (indexPath.section > (self.sectionCount - 1)) {
        CSHomeTopicSectionModel * model = self.topicList[indexPath.section - self.sectionCount];
        if (model.sectionType == CSHomeTopicSectionTypeBig) {
            CSHomeTopicBaseModel * topicModel = model.list[indexPath.row];
            if (topicModel.showVideo) {
                if (animated) {
                    [self.player playTheIndexPath:indexPath assetURL:[NSURL URLWithString:topicModel.video] scrollPosition:ZFPlayerScrollViewScrollPositionCenteredVertically animated:YES];
                } else {
                    [self.player playTheIndexPath:indexPath assetURL:[NSURL URLWithString:topicModel.video]];
                }
                [self.controlView showTitle:topicModel.title
                             coverURLString:topicModel.image
                             fullScreenMode:ZFFullScreenModeLandscape];
                
            }
            
        }
    }
}


#pragma mark - 转屏和状态栏

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}


#pragma mark - UIScrollViewDelegate  列表播放必须实现

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidEndDecelerating];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [scrollView zf_scrollViewDidEndDraggingWillDecelerate:decelerate];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidScrollToTop];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidScroll];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewWillBeginDragging];
}

#pragma mark - UICollectionView Method

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.sectionCount + self.topicList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == CSHomeCollectionSectionTypeSearch || section == CSHomeCollectionSectionTypeCycle || section == CSHomeCollectionSectionTypePress) {
        return 1;
    }else if (section == CSHomeCollectionSectionTypeCategory){
        return self.categories.count;
    }else if (section == CSHomeCollectionSectionTypeLive){
        return self.lives.count;
    }else{
        CSHomeTopicSectionModel * model = self.topicList[section - CSHomeCollectionSectionTypeTopic];
        if (model.sectionType == CSHomeTopicSectionTypeCheck) {
            return 1;
        }else{
            return model.list.count;
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == CSHomeCollectionSectionTypeSearch) {//头部搜索框
        CSHomeSearchBarCell * searchBarCell = (CSHomeSearchBarCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CSHomeSearchBarCellReuseIdentifier forIndexPath:indexPath];
        return searchBarCell;
    }else if (indexPath.section == CSHomeCollectionSectionTypeCycle){//轮播图
//        CSHomeCycleCell * cycleCell = (CSHomeCycleCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CSHomeCycleCellReuseIdentifier forIndexPath:indexPath];
//        [cycleCell configModels:self.banners];
//        cycleCell.cycleClick = ^(CSHomeCycleModel *model) {
//            [self clickCycleModel:model];
//        };
//        return cycleCell;
        CS_Weakify(self, weakSelf);
        CSHomeActorIconCell * cell = (CSHomeActorIconCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CSHomeActorIconCellReuseIdentifier forIndexPath:indexPath];
        cell.itemClick = ^(CSHomeActorIconModel *model) {
            if (model.isSpecial) {
                CSArtorDetailViewController * artorVC = [[CSArtorDetailViewController alloc]init];
                artorVC.artorId = model.specialId;
                artorVC.artorName = model.title;
                [weakSelf.navigationController pushViewController:artorVC animated:YES];
            }else{
                [weakSelf clickCycleModel:model];
            }
        };
        [cell configModels:self.banners];
        return cell;
    }else if (indexPath.section == CSHomeCollectionSectionTypeCategory){//分类
        CSHomeCategoryCell * categoryCell = (CSHomeCategoryCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CSHomeCategoryCellReuseIdentifier forIndexPath:indexPath];
        [categoryCell configModel:self.categories[indexPath.row]];
        return categoryCell;
    }else if (indexPath.section == CSHomeCollectionSectionTypePress){//新闻
        CSHomePressCell * pressCell = (CSHomePressCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CSHomePressCellReuseIdentifier forIndexPath:indexPath];
        [pressCell configPresses:self.presses];
        CS_Weakify(self, weakSelf);
        pressCell.pressClick = ^(CSHomePressModel *pressModel) {
            [weakSelf clickPressModel:pressModel];
        };
        return pressCell;
    }else if (indexPath.section == CSHomeCollectionSectionTypeLive){//直播
        CSHomeLiveCell * liveCell = (CSHomeLiveCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CSHomeLiveCellReuseIdentifier forIndexPath:indexPath];
        CS_Weakify(self, weakSelf);
        [liveCell configModel:self.lives[indexPath.row]];
        return liveCell;
    }else{
        CSHomeTopicSectionModel * model = self.topicList[indexPath.section - CSHomeCollectionSectionTypeTopic];
        CSHomeTopicBaseModel * topicModel = model.list[indexPath.row];
        if (model.sectionType == CSHomeTopicSectionTypeBig) {//大图
            CSHomeBigCell * bigCell = (CSHomeBigCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CSHomeBigCellReuseIdentifier forIndexPath:indexPath];
            [bigCell configurModel:topicModel];
            CS_Weakify(self, weakSelf);
            bigCell.playBlock = ^(UIButton *sender) {
                [weakSelf playTheVideoAtIndexPath:indexPath scrollAnimated:NO];
            };
            return bigCell;
        }else if (model.sectionType == CSHomeTopicSectionTypeSmall){//小图
            CSHomeSmallCell * smallCell = (CSHomeSmallCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CSHomeSmallCellReuseIdentifier forIndexPath:indexPath];
            [smallCell configurModel:topicModel];
            return smallCell;
        }else if (model.sectionType == CSHomeTopicSectionTypeSquare){//宫图
            CSHomeSquareCell * squareCell = (CSHomeSquareCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CSHomeSquareCellReuseIdentifier forIndexPath:indexPath];
            [squareCell configurModel:topicModel];
            return squareCell;
        }else if (model.sectionType == CSHomeTopicSectionTypeCheck){//左右切换
            CSHomeCheckCell  * checkCell = (CSHomeCheckCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CSHomeCheckCellReuseIdentifier forIndexPath:indexPath];
            [checkCell configModel:model];
            return checkCell;
        }
        return nil;
    }
    
    return nil;
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section >= CSHomeCollectionSectionTypeTopic && [kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CSHomeTopicSectionModel * model = self.topicList[indexPath.section - CSHomeCollectionSectionTypeTopic];
    
        if (model.showHead) {
            CSHomeTopicHeaderReusableView * reuseView = (CSHomeTopicHeaderReusableView*)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CSHomeTopicHeaderReusableViewReuseIdentifier forIndexPath:indexPath];
            reuseView.sectionModel = model;
            CS_Weakify(self, weakSelf);
            reuseView.checkMore = ^(CSHomeTopicSectionModel *sectionModel) {
                CSHomeMoreViewController * moreVC = [[CSHomeMoreViewController alloc]init];
                moreVC.sectionModel = sectionModel;
                [weakSelf.navigationController pushViewController:moreVC animated:YES];
            };
            return reuseView;
        }else{
            return nil;
        }
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat margin = 10;
    if (indexPath.section == CSHomeCollectionSectionTypeSearch) {//搜索框
        return CGSizeMake(self.view.width, 0.1);
        return CGSizeMake(self.view.width, 30 + margin*2);
    }else if (indexPath.section == CSHomeCollectionSectionTypeCycle){//轮播图
        CGFloat width = self.view.width - 28;
        CGFloat height = width*(160.0/347.0);
        return CGSizeMake(self.view.width, 250);
    }else if (indexPath.section == CSHomeCollectionSectionTypeCategory){//分类
        CGFloat sideMargin = 10;
        CGFloat itemWidth = (self.view.width - sideMargin*2)/5;
        return CGSizeMake(itemWidth, 35 + 30);
        
    }else if (indexPath.section == CSHomeCollectionSectionTypePress){//新闻
        return CGSizeMake(self.view.width, 20 + 15*2);
    }else if (indexPath.section == CSHomeCollectionSectionTypeLive){//直播
        return CGSizeMake(self.view.width, 135);
    }else{
        CSHomeTopicSectionModel * model = self.topicList[indexPath.section - CSHomeCollectionSectionTypeTopic];
        if (model.sectionType == CSHomeTopicSectionTypeBig) {
            CGFloat width = self.view.width - 28;//386
            CGFloat height = width*(215.0/347.0);//289
            
            return CGSizeMake(self.view.width, height + 55 + 20);
        }else if (model.sectionType == CSHomeTopicSectionTypeSmall){
            return CGSizeMake(self.view.width, 106);
        }else if (model.sectionType == CSHomeTopicSectionTypeSquare){
            CGFloat width = self.view.width/2 - 14 - 8;
            CGFloat height = width*(124.0/165.0);
            return CGSizeMake(width, height + 85);
        }else if (model.sectionType == CSHomeTopicSectionTypeCheck){
            CGFloat width = self.view.width/2 - 14 - 8;
            CGFloat height = width*(124.0/165.0);
            return CGSizeMake(self.view.width, height + 65);
        }
        return CGSizeZero;
    }
    
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section >= CSHomeCollectionSectionTypeTopic) {
         CSHomeTopicSectionModel * model = self.topicList[section - CSHomeCollectionSectionTypeTopic];
        if (model.showHead) {
            return CGSizeMake(self.view.width, 55);
        }else{
            return CGSizeZero;
        }
    }
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if (section == CSHomeCollectionSectionTypeCategory) {
        return UIEdgeInsetsMake(18, 10, 10, 10);
    }
    if (section == CSHomeCollectionSectionTypeLive) {
        return UIEdgeInsetsMake(0, 0, 10, 0);
    }
    if (section >= CSHomeCollectionSectionTypeTopic) {
        CSHomeTopicSectionModel * model = self.topicList[section - CSHomeCollectionSectionTypeTopic];
        if (model.sectionType == CSHomeTopicSectionTypeSquare) {
            return UIEdgeInsetsMake(0, 14, 0, 14);
        }
        return UIEdgeInsetsMake(0, 14, 0, 14);
    }
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section >= CSHomeCollectionSectionTypeTopic) {
        CSHomeTopicSectionModel * model = self.topicList[section - CSHomeCollectionSectionTypeTopic];
        if (model.sectionType == CSHomeTopicSectionTypeBig) {
            return 10;
        }
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section >= CSHomeCollectionSectionTypeTopic) {
        CSHomeTopicSectionModel * model = self.topicList[section - CSHomeCollectionSectionTypeTopic];
        if (model.sectionType == CSHomeTopicSectionTypeSquare) {
            return 16;
        }
    }
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == CSHomeCollectionSectionTypeSearch) {
        if (indexPath.row == 0) {//进入搜索界面
            [self enterSearchVC];
        }
    }else if (indexPath.section == CSHomeCollectionSectionTypeCategory){//分类Section
        CSHomeCategoryModel * categoryModel = self.categories[indexPath.row];
        [[CSRouterManger sharedManger] selecteCartegoryId:categoryModel.grade_id];
    }else if (indexPath.section == CSHomeCollectionSectionTypeLive){
        CSHomeLiveModel * liveModel = [self.lives objectAtIndex:indexPath.row];
        CSArtorDetailViewController * artorVC = [[CSArtorDetailViewController alloc]init];
        artorVC.artorId = liveModel.liveId;
        artorVC.artorName = liveModel.title;
        [self.navigationController pushViewController:artorVC animated:YES];
        
    }else if (indexPath.section >= CSHomeCollectionSectionTypeTopic){
        CSHomeTopicSectionModel * sectionModel = self.topicList[indexPath.section - CSHomeCollectionSectionTypeTopic];
        CSHomeTopicBaseModel * model = sectionModel.list[indexPath.row];
        CSArtorDetailViewController * artorVC = [[CSArtorDetailViewController alloc]init];
        artorVC.artorId = model.topicId;
        artorVC.artorName = model.title;
        [self.navigationController pushViewController:artorVC animated:YES];
    }
}


#pragma mark - Private Method
///进入搜索界面
- (void)enterSearchVC{
    
    
    CSSearchViewController * searchVC = [[CSSearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

///轮播图点击
- (void)clickCycleModel:(CSHomeCycleModel*)model{
    
    CSWebViewController * webVC = [[CSWebViewController alloc]init];
    webVC.url = model.url;
    webVC.title = model.title;
    [self.navigationController pushViewController:webVC animated:YES];
    
}

- (void)clickPressModel:(CSHomePressModel*)pressModel{
    
    CSWebViewController * webVC = [[CSWebViewController alloc]init];
    webVC.url = pressModel.url;
    webVC.title = pressModel.title;
    [self.navigationController pushViewController:webVC animated:YES];

}

- (void)liveClick{
    CSLiveListViewController * liveVC = [[CSLiveListViewController alloc]init];
    [self.navigationController pushViewController:liveVC animated:YES];
}

#pragma mark - Properties Method

- (UICollectionView*)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}

- (NSMutableArray*)banners{
    if (!_banners) {
        _banners = [NSMutableArray arrayWithCapacity:0];
    }
    return _banners;
}

- (NSMutableArray*)categories{
    if (!_categories) {
        _categories = [NSMutableArray arrayWithCapacity:0];
    }
    return _categories;
}

- (NSMutableArray*)presses{
    if (!_presses) {
        _presses = [NSMutableArray arrayWithCapacity:0];
    }
    return _presses;
}

- (NSMutableArray*)lives{
    if (!_lives) {
        _lives = [NSMutableArray arrayWithCapacity:0];
    }
    return _lives;
}

- (NSMutableArray<CSHomeTopicSectionModel *>*)topicList{
    if (!_topicList) {
        _topicList = [NSMutableArray arrayWithCapacity:0];
    }
    return _topicList;
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
    }
    return _controlView;
}



@end
