//
//  CSNewCourseViewController.m
//  ColorStar
//
//  Created by apple on 2020/11/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewCourseViewController.h"
#import "CSNewCourseViewListCell.h"
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"
#import "WMZBannerView.h"
#import "CSNewCourseViewPageController.h"
#import "CSNewCourseViewTopBannerCell.h"
#import "CSNewCourseCategoryView.h"
#import "CSNewCourseNetManage.h"
#import "CSNewCourseModel.h"
#import "CSCalendarViewController.h"
#import "CSSearchViewController.h"

@interface CSNewCourseViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>

//@property (nonatomic, strong)UICollectionView  * collectionView;
@property(nonatomic, strong)UIView                      *navView;
@property(nonatomic, strong)UIView                      *topView;
@property(nonatomic, strong)WMZBannerParam              *param;
@property(nonatomic, strong)WMZBannerView               *bannerView;

@property (nonatomic, strong)JXCategoryTitleView        *categoryView;
@property (nonatomic, strong)JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong)NSArray <NSString *>       *titles;
@property (nonatomic, strong) NSMutableArray <CSNewCourseViewPageController *> *listVCArray;

@property (nonatomic, strong)UIView         *categoryButtonView;
@property (nonatomic, strong)CSNewCourseCategoryView    *courseCategorySelectView;



@property (nonatomic, strong)NSMutableArray             *bannerArray;
@property (nonatomic, strong)NSMutableArray             *categoryArray;
//@property (nonatomic, strong) HGSegmentedPageViewController *segmentedPageViewController;

@property (nonatomic, strong)CSNewCourseCategoryModel  *curentCategorySelectModel;


@end

@implementation CSNewCourseViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *str= [[NSUserDefaults standardUserDefaults] objectForKey:@"hotSelctId"];
    if (str.length > 0) {
        self.curentCategorySelectModel.categoryId = str;
        for (CSNewCourseViewPageController *listVC in self.listVCArray) {
            if ([listVC.titleStr isEqualToString:self.titles[self.categoryView.selectedIndex]]) {
                for (CSNewCourseCategoryModel *mode in self.categoryArray) {
                    if ([mode.categoryId isEqualToString:str]) {
                        mode.isSelect = YES;
                        self.curentCategorySelectModel = mode;
                        
                    }else{
                        mode.isSelect = NO;
                    }
                }
                listVC.categoryModel = self.curentCategorySelectModel;
                [listVC loadData];
                [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"hotSelctId"];
            }
        }
    }
   
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    //    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.view.userInteractionEnabled = YES;
    self.topView.userInteractionEnabled = YES;
    self.bannerArray = [NSMutableArray array];
    self.categoryArray = [NSMutableArray array];
    self.listVCArray = [NSMutableArray array];
    self.curentCategorySelectModel = [[CSNewCourseCategoryModel alloc] init];
    NSString *str= [[NSUserDefaults standardUserDefaults] objectForKey:@"hotSelctId"];
    if (str.length > 0) {
        CSNewCourseCategoryModel *allModel = [[CSNewCourseCategoryModel alloc] init];
        allModel.isSelect = YES;
        allModel.name = csnation(@"全部");
        allModel.categoryId = str;
        self.curentCategorySelectModel = allModel;
    }else{
        CSNewCourseCategoryModel *allModel = [[CSNewCourseCategoryModel alloc] init];
        allModel.isSelect = YES;
        allModel.name = csnation(@"全部");
        allModel.categoryId = @"0";
        self.curentCategorySelectModel = allModel;
    }
    
    [self makeNavUI];
    [self makeTopView];
    [self makeTagView];
    [self loadBannerData];
    [self loadCategoryData];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.topView.mas_bottom).offset(20*heightScale);
        make.width.mas_offset(@(ScreenW/2));
        make.height.mas_offset(26*heightScale);
    }];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.categoryView.mas_bottom).offset(10*heightScale);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}

#pragma mark--Data--
- (void)loadBannerData{
    [[CSNewCourseNetManage sharedManager] getCourseBannerInfoSuccessComplete:^(CSNetResponseModel * _Nonnull response) {
        NSArray  *array = response.data;
        for (NSDictionary *dict in array) {
            CSNewCourseBannerModel  *model = [CSNewCourseBannerModel yy_modelWithDictionary:dict];
            [self.bannerArray addObject:model];
            self.param.wDataSet(self.bannerArray);
            [self.bannerView updateUI];
        }
    } failureComplete:^(NSError * _Nonnull error) {
        
    }];
}

- (void)loadCategoryData{
    [[CSNewCourseNetManage sharedManager] getCourseCategoryListInfoSuccessComplete:^(CSNetResponseModel * _Nonnull response) {
        NSArray  *array = response.data;
        NSString *str= [[NSUserDefaults standardUserDefaults] objectForKey:@"hotSelctId"];
        if (str.length > 0) {
            CSNewCourseCategoryModel *allModel = [[CSNewCourseCategoryModel alloc] init];
            allModel.isSelect = NO;
            allModel.name = csnation(@"全部");
            allModel.categoryId = @"0";
            [self.categoryArray addObject:allModel];
            for (NSDictionary *dict in array) {
                CSNewCourseCategoryModel  *model = [CSNewCourseCategoryModel yy_modelWithDictionary:dict];
                if ([model.categoryId isEqualToString:str]) {
                    model.isSelect = YES;
                    self.curentCategorySelectModel = model;
                }
                [self.categoryArray addObject:model];
                [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"hotSelctId"];
            }
        }else{
            CSNewCourseCategoryModel *allModel = [[CSNewCourseCategoryModel alloc] init];
            allModel.isSelect = YES;
            allModel.name = csnation(@"全部");
            allModel.categoryId = @"0";
            [self.categoryArray addObject:allModel];
            self.curentCategorySelectModel = allModel;
            for (NSDictionary *dict in array) {
                CSNewCourseCategoryModel  *model = [CSNewCourseCategoryModel yy_modelWithDictionary:dict];
                [self.categoryArray addObject:model];
            }
        }

        
    } failureComplete:^(NSError * _Nonnull error) {
        
    }];
}

/**
 重载数据源：比如从服务器获取新的数据、否则用户对分类进行了排序等
 */
- (void)reloadData {
    self.titles = @[csnation(@"全部"),csnation(@"最新"),csnation(@"最热门")];
    
    //重载之后默认回到0，你也可以指定一个index
    self.categoryView.defaultSelectedIndex = 0;
    self.categoryView.titles = self.titles;
    [self.categoryView reloadData];
}

#pragma mark - JXCategoryListContainerViewDataSource

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    CSNewCourseViewPageController *listVC = [[CSNewCourseViewPageController alloc] init];
    listVC.categoryModel = self.curentCategorySelectModel;
    switch (index) {
        case 0:
        {
            listVC.order= @"1";
        }
            break;
        case 1:
        {
            listVC.order= @"2";
        }
            break;
        case 2:
        {
            listVC.order= @"3";
        }
            break;
            
        default:
            break;
    }
    listVC.titleStr = self.titles[index];
    listVC.categoryModel = self.curentCategorySelectModel;
    [self.listVCArray addObject:listVC];
    return listVC;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    
    return self.titles.count;
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    for (CSNewCourseViewPageController *listVC in self.listVCArray) {
        if ([listVC.titleStr isEqualToString:self.titles[index]]) {
            if (![listVC.categoryModel.categoryId isEqualToString:self.curentCategorySelectModel.categoryId]) {
                listVC.categoryModel = self.curentCategorySelectModel;
                [listVC loadData];
            }
            
        }
    }
    
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
    
    UIButton  *calecdarButton = [[UIButton alloc] init];
    [calecdarButton setImage:[UIImage imageNamed:@"CS_home_topCalendar.png"] forState:UIControlStateNormal];
    [calecdarButton addTarget:self action:@selector(calecdarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:calecdarButton];
    [calecdarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(@(heightScale *26));
        make.left.mas_equalTo(self.navView.mas_left).offset(heightScale*12);
        make.bottom.mas_equalTo(self.navView.mas_bottom).offset(-heightScale *8);
    }];
    
    
    UIButton  *searchButton = [[UIButton alloc] init];
    [searchButton setImage:[UIImage imageNamed:@"CS_home_topSearch.png"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:searchButton];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(@(heightScale *26));
        make.right.mas_equalTo(self.navView.mas_right).offset(-heightScale*12);
        make.bottom.mas_equalTo(self.navView.mas_bottom).offset(-heightScale *8);
    }];
    
    UILabel  *titleLabel = [[UILabel alloc] init];
    titleLabel.text = NSLocalizedString(@"课程",nil);
    titleLabel.font = kFont(18);
    titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.navView.mas_centerX);
        make.centerY.mas_equalTo(calecdarButton.mas_centerY);
    }];
    
    UIButton  *flButton = [[UIButton alloc] init];
    
    [self.view addSubview:flButton];
}

#pragma mark--ButtonAction--
-(void)calecdarButtonClick:(UIButton *)btn{
    CSCalendarViewController * calendarVC = [[CSCalendarViewController alloc]init];
    [self.navigationController pushViewController:calendarVC animated:YES];
}

-(void)searchButtonClick:(UIButton *)btn{
    CSSearchViewController * searchVC = [[CSSearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)makeTopView{
    self.topView = [[UIView alloc] init];
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.navView.mas_bottom);
        make.height.mas_offset(@(175*heightScale));
        //make.height.mas_offset(@(200));
    }];
    
    
    
    self.param =
    BannerParam()
    //自定义视图必传
    .wMyCellClassNameSet(@"CSNewCourseViewTopBannerCell")
    .wMyCellSet(^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collectionView, CSNewCourseBannerModel *model, UIImageView *bgImageView,NSArray*dataArr) {
        //自定义视图
        CSNewCourseViewTopBannerCell *cell = (CSNewCourseViewTopBannerCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CSNewCourseViewTopBannerCell class]) forIndexPath:indexPath];
        // cell.leftText.text = model[@"name"];
        cell.userInteractionEnabled = YES;
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"cs_home_course.png"]];
        return cell;
    })
    
    .wFrameSet(CGRectMake(0, 0, ScreenW, 175*heightScale))
    .wDataSet(self.bannerArray)
    .wEventClickSet(^(id anyID, NSInteger index) {
        CSNewCourseBannerModel *model = self.bannerArray[index];
        [[CSWebManager sharedManager] enterWebVCWithURL:model.url title:model.title withSupVC:[CSTotalTool getCurrentShowViewController]];

    })
    //关闭pageControl
    .wHideBannerControlSet(NO)
    //开启缩放
    .wScaleSet(NO)
    //分页按钮的选中的颜色
    .wBannerControlSelectColorSet([UIColor colorWithHexString:@"#FFC549"])
    //分页按钮的未选中的颜色
    .wBannerControlColorSet([UIColor whiteColor])
    //    //分页按钮的未选中的图片
    .wBannerControlImageSet(@"CSNewHomeLiveViewTopBannePageUnSelect")
    //分页按钮的选中的图片
    .wBannerControlSelectImageSet(@"CSNewHomeLiveViewTopBannePageSelect")
    //分页按钮的未选中图片的size
    .wBannerControlImageSizeSet(CGSizeMake(6, 6))
    //分页按钮选中的图片的size
    .wBannerControlSelectImageSizeSet(CGSizeMake(15, 6))
    //    //分页按钮的圆角
    .wBannerControlImageRadiusSet(3)
    //自定义圆点间距
    //自定义item的大小
    .wItemSizeSet(CGSizeMake(ScreenW -50*widthScale, 175*heightScale))
    //固定移动的距离
    .wContentOffsetXSet(0.5)
    //循环
    .wRepeatSet(YES)
    //中间cell层级最上面
    .wZindexSet(YES)
    //整体左右间距  设置为size.width的一半 让最后一个可以居中
    .wSectionInsetSet(UIEdgeInsetsMake(0,18*widthScale, 0, -18*widthScale))
    //间距
    .wLineSpacingSet(7*widthScale)
    //开启背景毛玻璃
    .wEffectSet(NO)
    //点击左右居中
    .wClickCenterSet(YES)
    //自动滚动
    .wAutoScrollSet(YES)
    .wScaleSet(YES)
    .wScaleFactorSet(0.1)
    ;
    self.bannerView = [[WMZBannerView alloc]initConfigureWithModel:self.param];
    self.bannerView.userInteractionEnabled= YES;
    [self.topView addSubview:self.bannerView];
    
}


- (void)makeTagView{
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_CollectionView delegate:self];
    [self.view addSubview:self.listContainerView];
    
    self.titles = @[csnation(@"全部"),csnation(@"最新"),csnation(@"最热门")];//[self getRandomTitles];
    self.categoryView = [[JXCategoryTitleView alloc] init];
    //优化关联listContainer，以后后续比如defaultSelectedIndex等属性，才能同步给listContainer
    self.categoryView.contentEdgeInsetLeft = 12;
    self.categoryView.cellSpacing = 30;
    self.categoryView.listContainer = self.listContainerView;
    self.categoryView.titles = self.titles;
    self.categoryView.titleColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.5];
    self.categoryView.titleSelectedColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.categoryView.delegate = self;
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorWidth = 20;
    lineView.indicatorColor = [UIColor whiteColor];
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
    
    
    self.categoryButtonView = [[UIView alloc] init];
    CS_Weakify(self, weakSelf);
    [self.categoryButtonView setTapActionWithBlock:^{
        weakSelf.courseCategorySelectView= [[CSNewCourseCategoryView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        weakSelf.courseCategorySelectView.clickBlock = ^(CSNewCourseCategoryModel * _Nonnull model) {
            weakSelf.curentCategorySelectModel = model;
            for (CSNewCourseViewPageController *listVC in weakSelf.listVCArray) {
                if ([listVC.titleStr isEqualToString:weakSelf.titles[weakSelf.categoryView.selectedIndex]]) {
                    listVC.categoryModel = weakSelf.curentCategorySelectModel;
                    [listVC loadData];
                }
            }
        };
        [weakSelf.courseCategorySelectView refreshUIWith:weakSelf.categoryArray];
        [weakSelf.courseCategorySelectView showView];
    }];
    ViewRadius(self.categoryButtonView, 13*heightScale);
    self.categoryButtonView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.06];
    [self.view addSubview:self.categoryButtonView];
    
    UIImageView  *categoryImage = [[UIImageView alloc] init];
    categoryImage.image = [UIImage imageNamed:@"CSNewShopTopCellCategoryBottom.png"];
    [self.view addSubview:categoryImage];
    [categoryImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.categoryView.mas_centerY);
        make.right.mas_equalTo(self.view.mas_right).offset(-widthScale*25);
        make.width.height.mas_offset(13*widthScale);
    }];
    
    UILabel *categoryTitleLabel = [[UILabel alloc] init];
    categoryTitleLabel.text = csnation(@"分类");
    categoryTitleLabel.font = kFont(12);
    categoryTitleLabel.textColor = [UIColor colorWithHexString:@"#FEFEFE"];
    categoryTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:categoryTitleLabel];
    [categoryTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(categoryImage.mas_centerY);
        make.right.mas_equalTo(categoryImage.mas_left).offset(-widthScale *6);
    }];
    
    [self.categoryButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(categoryImage.mas_centerY);
        make.height.mas_offset(@(26*heightScale));
        make.right.mas_equalTo(categoryImage.mas_right).offset(12*widthScale);
        make.left.mas_equalTo(categoryTitleLabel.mas_left).offset(-12*widthScale);
    }];
    
}





@end
