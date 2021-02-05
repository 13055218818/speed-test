//
//  CSNewCourseViewPageController.m
//  ColorStar
//
//  Created by apple on 2020/11/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewCourseViewPageController.h"
#import "CSNewCourseViewListCell.h"
#import <MJRefresh.h>
#import "HWPopTool.h"
#import "WMZBannerView.h"
#import "CSNewCourseViewPageCell.h"
#import "CSNewCourseNetManage.h"

@interface CSNewCourseViewPageController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSInteger  page;
    NSInteger  selectIndex;
}
@property (nonatomic, strong)UICollectionView  * collectionView;
@property (nonatomic, strong)UIView                     *tagsView;
@property (nonatomic, strong)WMZBannerParam     *param;
@property (nonatomic, strong)WMZBannerView      *bannerView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) BOOL isDataLoaded;
@end

@implementation CSNewCourseViewPageController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
   // page = 1;
    [self.collectionView.mj_footer resetNoMoreData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    //self.view.backgroundColor = [UIColor redColor];
    self.dataSource = [NSMutableArray array];
    selectIndex = 0;
    
    [self setupViews];
    [self loadDataForFirst];
}

- (void)loadDataForFirst {
    //第一次才加载，后续触发的不处理
    if (!self.isDataLoaded) {
        self.isDataLoaded = YES;
        [self loadData];
    }
}
- (void)loadData{
    page = 1;
        [self loadDataWith:self.categoryModel.categoryId WithOrder:self.order];
    [self.collectionView.mj_footer resetNoMoreData];
}

- (void)loadMoreData{
    page = page + 1;
    [self loadDataWith:self.categoryModel.categoryId WithOrder:self.order];
   
}

- (void)loadDataWith:(NSString *)categoryId WithOrder:(NSString *)order
{
    [[CSTotalTool sharedInstance] showHudInView:self.view hint:@""];
    [[CSNewCourseNetManage sharedManager] getCourseListInfoSuccessWith:categoryId withOrder:order withPage:[NSString stringWithFormat:@"%ld",page] withLimit:@"12" Complete:^(CSNetResponseModel * _Nonnull response) {
        [self.collectionView.mj_header endRefreshing];
        [[CSTotalTool sharedInstance] hidHudInView:self.view];
        if (response.code == 200) {
            NSArray  *array = response.data;
            if (page == 1) {
                [self.dataSource removeAllObjects];
                if (array.count > 0) {
                    for (NSDictionary *dict in array) {
                        CSNewCourseModel  *model =[CSNewCourseModel yy_modelWithDictionary:dict];
                        [self.dataSource addObject:model];
                    }
            }
            }else{
                if (array.count > 0) {
                    for (NSDictionary *dict in array) {
                        CSNewCourseModel  *model =[CSNewCourseModel yy_modelWithDictionary:dict];
                        [self.dataSource addObject:model];
                    }
                    [self.collectionView.mj_footer endRefreshing];
                }else{
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }
            }
        }
        [self.collectionView reloadData];
    } failureComplete:^(NSError * _Nonnull error) {
        [[CSTotalTool sharedInstance] hidHudInView:self.view];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
}

- (void)setupViews{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //layout.estimatedItemSize = CGSizeMake(ScreenW, 10);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    //下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];//[MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    [self.collectionView registerClass:[CSNewCourseViewListCell class] forCellWithReuseIdentifier:@"CSNewCourseViewListCell"];
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    self.tagsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  ScreenW, 530*heightScale)];
    self.tagsView .backgroundColor = [UIColor clearColor];
    [self makeBanner];
}
- (void)makeBanner{
    self.param =
    BannerParam()
    //自定义视图必传
    .wMyCellClassNameSet(@"CSNewCourseViewPageCell")
    .wMyCellSet(^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collectionView, CSNewCourseModel *model, UIImageView *bgImageView,NSArray*dataArr) {
        //自定义视图
        CSNewCourseViewPageCell *cell = (CSNewCourseViewPageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CSNewCourseViewPageCell class]) forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.statuImageView.image = [UIImage imageNamed:@"CSNewCourseViewListTOP1.png"];
        }else if(indexPath.row ==1){
            cell.statuImageView.image = [UIImage imageNamed:@"CSNewCourseViewListTOP2.png"];
        }else if(indexPath.row ==2){
            cell.statuImageView.image = [UIImage imageNamed:@"CSNewCourseViewListTOP3.png"];
        }else{
            cell.statuImageView.image = nil;
        }
        cell.model = model;
        [cell.headImageView setTapActionWithBlock:^{
            [[HWPopTool sharedInstance] closeWithBlcok:^{
                //[self.navigationController popViewControllerAnimated:YES];
                CSTutorDetailViewController *vc = [CSTutorDetailViewController new];
                vc.tutorId = model.courseId;
                [self.navigationController pushViewController:vc animated:YES];
            }];
        }];
        [cell.moreLabel setTapActionWithBlock:^{
            [[HWPopTool sharedInstance] closeWithBlcok:^{
                //[self.navigationController popViewControllerAnimated:YES];
                CSTutorDetailViewController *vc = [CSTutorDetailViewController new];
                vc.tutorId = model.courseId;
                [self.navigationController pushViewController:vc animated:YES];
            }];
            
        }];
        cell.clickBlock = ^(CSNewCourseListInfoTaskListModel * _Nonnull model) {
            [[HWPopTool sharedInstance] closeWithBlcok:^{
                    CSTutorPlayViewController *vc = [CSTutorPlayViewController new];
                    //vc.specialId = self.currentGuitarModel.subject_id;
                    vc.videoId = model.taskList_id;
                    [self.navigationController pushViewController:vc animated:YES];
             
            }];
        };
        return cell;
    })
    .wFrameSet(CGRectMake(0, 0, ScreenW, 530*heightScale))
    .wSelectIndexSet(0)
    //.wDataSet(self.dataSource)
    //关闭pageControl
    .wHideBannerControlSet(YES)
    //开启缩放
    .wScaleSet(NO)
    //自定义item的大小
    .wItemSizeSet(CGSizeMake(ScreenW - 80*widthScale, 530*heightScale))
    //固定移动的距离
    .wContentOffsetXSet(0.5)
    //循环
    .wRepeatSet(NO)
    //中间cell层级最上面
    .wZindexSet(YES)
    //整体左右间距  设置为size.width的一半 让最后一个可以居中
    .wSectionInsetSet(UIEdgeInsetsMake(0,25*widthScale, 0, 10))
    //间距
    .wLineSpacingSet(15*heightScale)
    //开启背景毛玻璃
    .wEffectSet(NO)
    //点击左右居中
    .wClickCenterSet(YES)
    //自动滚动
    .wAutoScrollSet(NO)
    ;
    self.bannerView = [[WMZBannerView alloc]initConfigureWithModel:self.param];
    [self.tagsView addSubview:self.bannerView];
}


#pragma mark - UICollectionView Method
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CSNewCourseViewListCell * innerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CSNewCourseViewListCell" forIndexPath:indexPath];
    if (self.dataSource.count > 0) {

        if (indexPath.row == 0) {
            innerCell.statuImageView.image = [UIImage imageNamed:@"CSNewCourseViewListTOP1.png"];
        }else if(indexPath.row ==1){
            innerCell.statuImageView.image = [UIImage imageNamed:@"CSNewCourseViewListTOP2.png"];
        }else if(indexPath.row ==2){
            innerCell.statuImageView.image = [UIImage imageNamed:@"CSNewCourseViewListTOP3.png"];
        }else{
            innerCell.statuImageView.image = nil;
        }
        innerCell.model = self.dataSource[indexPath.row];
    }
    
    return innerCell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((ScreenW-40*widthScale)/3, (ScreenW-40*widthScale)/3);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 10*widthScale, 0, 10*widthScale);
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    selectIndex=indexPath.row;
    [self popViewShow];
}

- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}


- (void)popViewShow {
    self.param.wSelectIndexSet(selectIndex);
    self.param.wDataSet(self.dataSource);
    [self.bannerView updateUI];
    [HWPopTool sharedInstance].shadeBackgroundType = ShadeBackgroundTypeSolid;
    [HWPopTool sharedInstance].closeButtonType = ButtonPositionTypeNone;
    [[HWPopTool sharedInstance] showWithPresentView:self.tagsView animated:YES];
    
}

- (void)closeAndBack {
    [[HWPopTool sharedInstance] closeWithBlcok:^{
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
}

#pragma mark - JXCategoryListCollectionContentViewDelegate

- (UIView *)listView {
    
    return self.view;
}

- (void)listDidAppear {
    //    NSLog(@"%@", NSStringFromSelector(_cmd));
    //因为`JXCategoryListContainerView`内部通过`UICollectionView`的cell加载列表。当切换tab的时候，之前的列表所在的cell就被回收到缓存池，就会从视图层级树里面被剔除掉，即没有显示出来且不在视图层级里面。这个时候MJRefreshHeader所持有的UIActivityIndicatorView就会被设置hidden。所以需要在列表显示的时候，且isRefreshing==YES的时候，再让UIActivityIndicatorView重新开启动画。
    if (self.collectionView.mj_header.isRefreshing) {
        UIActivityIndicatorView *activity = [self.collectionView.mj_header valueForKey:@"loadingView"];
        [activity startAnimating];
    }
}

- (void)listDidDisappear {
    //    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)reFreshUIWith:(NSString *)color{
    self.collectionView.backgroundColor = [UIColor colorWithHexString:color];
}

@end
