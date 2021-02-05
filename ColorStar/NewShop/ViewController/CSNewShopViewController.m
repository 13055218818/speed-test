//
//  CSNewShopViewController.m
//  ColorStar
//
//  Created by apple on 2020/11/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewShopViewController.h"
#import "CSNewShopListCell.h"
#import "WMZBannerView.h"
#import "CSNewHomeLiveViewTopBannerCell.h"
#import "JHWaterfallCollectionLayout.h"
#import "CSNewShopAllListViewController.h"
#import "CSNewShopNetManage.h"
#import "CSNewShopModel.h"
#import "CSNewShopGoodSDetailViewController.h"

@interface CSNewShopViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,WaterFlowLayoutDelegate,UIScrollViewDelegate>
{
    NSInteger  page;
}
@property(nonatomic, strong)UIView          *navView;
@property(nonatomic, strong)UIView          *topView;
@property (nonatomic, strong)UIView         *tagsView;
@property (nonatomic, strong)UICollectionView  *collectionView;
//@property (nonatomic, strong)BHWaterFlowLayout *waterFlowLayout;
@property (nonatomic, strong) NSMutableArray* heightArr ;
@property (nonatomic, strong)WMZBannerParam *param;
@property (nonatomic, strong)WMZBannerView *bannerView;

@property (nonatomic, strong)NSMutableArray *bannerDataArray;
@property (nonatomic, strong)NSMutableArray *categoryDataArray;
@property (nonatomic, strong)NSMutableArray *productDataArray;

@property (nonatomic, strong)UIScrollView    *bgscrollerview;
@property (nonatomic, strong)UIView    *bgViewscrollerview;
@end

@implementation CSNewShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    self.bannerDataArray = [NSMutableArray array];
    self.categoryDataArray = [NSMutableArray array];
    self.productDataArray = [NSMutableArray array];
    [self makeNavUI];
    [self makeTopView];
    [self setupViews];
    [self loadBannerData];
    [self loadCategoryListData];
    [self loadData];
}
#pragma mark--data--
- (void)loadBannerData{
    [[CSNewShopNetManage sharedManager] getShopBannerInfoSuccessComplete:^(CSNetResponseModel * _Nonnull response) {
        NSArray  *array = response.data;
        if (array.count > 0) {
            [self.bannerDataArray removeAllObjects];
            for (NSDictionary  *dict in array) {
                CSNewShopBannerModel *model = [CSNewShopBannerModel yy_modelWithDictionary:dict];
                [self.bannerDataArray addObject:model];
                }
            self.param.wDataSet(self.bannerDataArray);
            [self.bannerView updateUI];
        }
        
    } failureComplete:^(NSError * _Nonnull error) {
            
    }];
}

- (void)loadCategoryListData{
    [[CSNewShopNetManage sharedManager] getShopCategopryListSuccessWithLimit:@"4" Complete:^(CSNetResponseModel * _Nonnull response) {
        NSArray  *array = response.data;
        if (array.count > 0) {
            [self.categoryDataArray removeAllObjects];
            for (NSDictionary  *dict in array) {
                CSNewShopCategoryModel *model = [CSNewShopCategoryModel yy_modelWithDictionary:dict];
                [self.categoryDataArray addObject:model];
                }
            [self makeTagsUI];
        }
    } failureComplete:^(NSError * _Nonnull error) {
        
    }];
}
- (void)loadData{
    page = 1;
    [self loadProductData];
    [self.collectionView.mj_footer resetNoMoreData];
}

- (void)loadMoreData{
    page = page +1;
    [self loadProductData];
}

- (void)loadProductData{
    [[CSTotalTool sharedInstance] showHudInView:[CSTotalTool getCurrentShowViewController].view hint:@""];
    [[CSNewShopNetManage sharedManager] getShopCategopryListSuccessWithCid:@"0" withKey:@"" withPage:[NSString stringWithFormat:@"%ld",page] withLimit:@"10" Complete:^(CSNetResponseModel * _Nonnull response) {
        NSArray  *array = response.data;
        [self.collectionView.mj_header endRefreshing];
        [[CSTotalTool sharedInstance] hidHudInView:[CSTotalTool getCurrentShowViewController].view];
            if (page == 1) {
                [self.productDataArray removeAllObjects];
                if (array.count > 0) {
                    for (NSDictionary  *dict in array) {
                        CSNewShopModel *model = [CSNewShopModel yy_modelWithDictionary:dict];
                        [self.productDataArray addObject:model];
                        }
                }
            }else{
                if (array.count > 0) {
                    for (NSDictionary  *dict in array) {
                        CSNewShopModel *model = [CSNewShopModel yy_modelWithDictionary:dict];
                        [self.productDataArray addObject:model];
                        }
                    [self.collectionView.mj_footer endRefreshing];
                }else{
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
            
            [self.collectionView reloadData];

    } failureComplete:^(NSError * _Nonnull error) {
        [[CSTotalTool sharedInstance] hidHudInView:[CSTotalTool getCurrentShowViewController].view];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
}

#pragma mark--UI--
-(void)makeNavUI{
    self.navView = [[UIView alloc] init];
    self.navView.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_offset(@(kStatusBarHeight + 44.0*heightScale));
    }];
    UIButton  *searchButton = [[UIButton alloc] init];
    [searchButton setTapActionWithBlock:^{
        CSNewShopAllListViewController *vc = [[CSNewShopAllListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    ViewRadius(searchButton, 17*heightScale);
    searchButton.titleLabel.font = kFont(12);
    [searchButton setTitle:csnation(@"搜索") forState:UIControlStateNormal];
    [searchButton setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:0.2]];
    [self.navView addSubview:searchButton];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(@(heightScale *34));
        make.right.mas_equalTo(self.navView.mas_right).offset(-heightScale*15);
        make.left.mas_equalTo(self.navView.mas_left).offset(heightScale*15);
        make.bottom.mas_equalTo(self.navView.mas_bottom).offset(-heightScale *8);
    }];
    
    self.bgscrollerview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight + 44.0*heightScale, ScreenW, ScreenH-kStatusBarHeight - 44.0*heightScale)];
    self.bgscrollerview.scrollEnabled=YES;
    self.bgscrollerview.pagingEnabled = NO;
    self.bgscrollerview.delegate = self;
    self.bgscrollerview.bounces = NO;
    //self.bgscrollerview.backgroundColor = [UIColor redColor];
    self.bgscrollerview.contentSize = CGSizeMake(ScreenW, ScreenH-kStatusBarHeight - 44.0*heightScale +195*heightScale);
    [self.view addSubview:self.bgscrollerview];
//    [self.bgscrollerview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.mas_equalTo(self.view);
//        make.top.mas_equalTo(self.navView.mas_bottom);
//    }];
//
    self.bgViewscrollerview = [[UIView alloc] init];
    //self.bgViewscrollerview.backgroundColor = [UIColor redColor];
    self.bgViewscrollerview.frame =CGRectMake(0, 0, ScreenW, ScreenH-kStatusBarHeight - 44.0*heightScale+195*heightScale);
    [self.bgscrollerview addSubview:self.bgViewscrollerview];
//    [self.bgViewscrollerview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.mas_equalTo(self.bgscrollerview);
//    }];
    
}

- (void)makeTopView{
    self.topView = [[UIView alloc] init];
    
    [self.bgViewscrollerview addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.bgViewscrollerview);
        make.height.mas_offset(@(300*heightScale));
        make.top.mas_equalTo(self.bgViewscrollerview.mas_top);
    }];
    self.tagsView = [[UIView alloc] init];
    ViewRadius(self.tagsView, 3);
    self.tagsView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF" alpha:0.06];
    [self.topView addSubview:self.tagsView];
    [self.tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topView.mas_left).offset(15*widthScale);
        make.right.mas_equalTo(self.topView.mas_right).offset(-15*widthScale);
        make.bottom.mas_equalTo(self.topView.mas_bottom).offset(-15*heightScale);
        make.height.mas_offset(@(90*heightScale));
    }];
    
    
    
    self.param =
    BannerParam()
    //自定义视图必传
    .wMyCellClassNameSet(@"CSNewHomeLiveViewTopBannerCell")
    .wMyCellSet(^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collectionView, CSNewShopBannerModel *model, UIImageView *bgImageView,NSArray*dataArr) {
        //自定义视图
        CSNewHomeLiveViewTopBannerCell *cell = (CSNewHomeLiveViewTopBannerCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CSNewHomeLiveViewTopBannerCell class]) forIndexPath:indexPath];
        cell.model = model;
        return cell;
    })
    .wFrameSet(CGRectMake(15*widthScale, 7*heightScale, ScreenW-15*widthScale*2, 180*heightScale))
    .wDataSet(self.bannerDataArray)
    //关闭pageControl
    .wHideBannerControlSet(YES)
    //开启缩放
    .wScaleSet(NO)
    .wEventClickSet(^(id anyID, NSInteger index) {
        CSNewShopBannerModel *model = self.bannerDataArray[index];
        [[CSWebManager sharedManager] enterWebVCWithURL:model.url title:model.title withSupVC:[CSTotalTool getCurrentShowViewController]];

    })
    //自定义item的大小
    .wItemSizeSet(CGSizeMake(ScreenW-15*widthScale*2, 180*heightScale))
    //固定移动的距离
    .wContentOffsetXSet(0.5)
    //循环
    .wRepeatSet(YES)
    //中间cell层级最上面
    .wZindexSet(YES)
    //整体左右间距  设置为size.width的一半 让最后一个可以居中
    .wSectionInsetSet(UIEdgeInsetsMake(0,0, 0, 0))
    //间距
    .wLineSpacingSet(12*heightScale)
    //开启背景毛玻璃
    .wEffectSet(NO)
    //点击左右居中
    .wClickCenterSet(YES)
    //自动滚动
    .wAutoScrollSet(YES)
    ;
    self.bannerView= [[WMZBannerView alloc]initConfigureWithModel:self.param];
    [self.topView addSubview:self.bannerView];

}

- (void)makeTagsUI{
    CSNewShopCategoryModel *moreMode = [[CSNewShopCategoryModel alloc] init];
    moreMode.categoryId = @"0";
    [self.categoryDataArray addObject:moreMode];
    for (NSInteger i = 0; i < self.categoryDataArray.count; i ++) {
        UIImageView  *imageButton = [[UIImageView alloc] init];
        imageButton.tag = i;
        [imageButton setTapActionWithBlock:^{
            CSNewShopAllListViewController *vc = [[CSNewShopAllListViewController alloc] init];
        //    ickImageViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        //    [self presentModalViewController:ickImageViewController animated:YES];
            CSNewShopCategoryModel *mode = self.categoryDataArray[i];
            vc.currentCategoryModel = mode;
            [self.navigationController pushViewController:vc animated:YES];
        }];
//        [imageButton addTarget:self action:@selector(imageCategoryButtonClicl:) forControlEvents:UIControlEventTouchUpInside];
        imageButton.frame = CGRectMake(14 *widthScale + i*(40*widthScale +30*widthScale), 20*heightScale, 40*heightScale, 40*heightScale);
        [self.tagsView addSubview:imageButton];
        UILabel  *titleLabel = [[UILabel alloc] init];
        titleLabel.font = kFont(12);
        titleLabel.textColor = [UIColor colorWithHexString:@"#808080"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.frame = CGRectMake(i * (ScreenW-28*widthScale)/5, 45*heightScale + 20*heightScale, (ScreenW-28*widthScale)/5, 12*heightScale);
        [self.tagsView addSubview:titleLabel];
        
        if (i == self.categoryDataArray.count-1) {
//            [imageButton setImage:[UIImage imageNamed:@"CSNewShopCategoryMore.png"] forState:UIControlStateNormal];
            imageButton.image = [UIImage imageNamed:@"CSNewShopCategoryMore.png"];
            titleLabel.text = csnation(@"更多");
        }else{
            CSNewShopCategoryModel *mode = self.categoryDataArray[i];
            //[imageButton sd_setImageWithURL:[NSURL URLWithString:mode.pic] forState:UIControlStateNormal];
            [imageButton sd_setImageWithURL:[NSURL URLWithString:mode.pic] placeholderImage:[UIImage imageNamed:@"CSNewShopCategoryMore.png"]];
            titleLabel.text = mode.cate_name;
        }
    }
}

- (void)imageCategoryButtonClicl:(UIButton  *)btn
{
    
    CSNewShopAllListViewController *vc = [[CSNewShopAllListViewController alloc] init];
//    ickImageViewController.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentModalViewController:ickImageViewController animated:YES];
    CSNewShopCategoryModel *mode = self.categoryDataArray[btn.tag];
    vc.currentCategoryModel = mode;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)setupViews{

    JHWaterfallCollectionLayout* layout = [[JHWaterfallCollectionLayout alloc]init];
    layout.delegate = self;
    //2.初始化collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.collectionView registerClass:[CSNewShopListCell class] forCellWithReuseIdentifier:@"CSNewShopListCell"];
    [self.bgViewscrollerview addSubview:self.collectionView];
    
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.mas_equalTo(self.bgViewscrollerview);
//        make.top.mas_equalTo(self.topView.mas_bottom);
//    }];
    self.collectionView.frame = CGRectMake(0, 300*heightScale, ScreenW,  ScreenH-kStatusBarHeight - 44.0*heightScale - 300*heightScale-kTabBarHeight);

}


#pragma mark - UICollectionView Method


- (CGFloat)waterFlowLayout:(JHWaterfallCollectionLayout *)waterFlowLayout heightForRowAtIndex:(NSInteger)index itemWidth:(CGFloat)width
{
    
    return [self.heightArr[index] floatValue];
    
    
}
-(NSArray *)heightArr{
    if(!_heightArr){
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i< 20; i++) {
            
            [arr addObject:@(arc4random()%30 +250*heightScale) ];
        }
        _heightArr = [arr copy];
    }
    return _heightArr;
}

- (NSInteger)cloumnCountInWaterFlowLayout:(JHWaterfallCollectionLayout *)waterFlowLayout
{
    return  2 ;
}
- (CGFloat)columMarginInWaterFlowLayout:(JHWaterfallCollectionLayout *)waterFlowLayout
{
    return  10*heightScale;
}
- (CGFloat)rowMarginInWaterFlowLayout:(JHWaterfallCollectionLayout *)waterFlowLayout
{
    return 10*heightScale;
}
- (UIEdgeInsets)edgeInsetInWaterFlowLayout:(JHWaterfallCollectionLayout *)waterFlowLayout
{
    return UIEdgeInsetsMake(0, 15*widthScale, 10*heightScale, 15*widthScale);
}

#pragma mark collectionView代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.productDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CSNewShopListCell *cell = (CSNewShopListCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CSNewShopListCell" forIndexPath:indexPath];
    if (self.productDataArray.count > 0) {
        cell.model = self.productDataArray[indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CSNewShopModel *model = self.productDataArray[indexPath.row];
    CSNewShopGoodSDetailViewController  *vc = [CSNewShopGoodSDetailViewController new];
    vc.productId = model.productId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.bgscrollerview) {
        if (scrollView.contentOffset.y > 180*heightScale) {
            self.collectionView.frame = CGRectMake(0, 300*heightScale, ScreenW,  ScreenH-kStatusBarHeight - 44.0*heightScale - 90*heightScale-kTabBarHeight);
            [self.collectionView reloadData];
        }
    }
}


@end
