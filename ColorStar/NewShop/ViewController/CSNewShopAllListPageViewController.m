//
//  CSNewShopAllListPageViewController.m
//  ColorStar
//
//  Created by apple on 2020/11/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewShopAllListPageViewController.h"
#import "CSNewShopListCell.h"
#import <MJRefresh.h>
#import "CSNewCourseViewPageCell.h"
#import "JHWaterfallCollectionLayout.h"
#import "CSNewShopGoodSDetailViewController.h"
#import "CSNewShopNetManage.h"

@interface CSNewShopAllListPageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WaterFlowLayoutDelegate>
{
    NSInteger  page;
    NSInteger  selectIndex;
}
@property (nonatomic, strong)UICollectionView  * collectionView;
@property (nonatomic,strong) NSMutableArray* heightArr ;
@property (nonatomic, strong)NSMutableArray *productDataArray;
@property (nonatomic, assign) BOOL isDataLoaded;
@property (nonatomic, strong)CSNewShopCategoryModel  *currentCategoryModel;
@end

@implementation CSNewShopAllListPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    self.productDataArray = [NSMutableArray array];
    self.currentCategoryModel = [[CSNewShopCategoryModel alloc] init];
    self.currentCategoryModel = self.firstCategoryModel;
    selectIndex = 0;
    [self setupViews];
    [self loadDataForFirst];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    window.backgroundColor = [UIColor redColor];
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
    [self loadProductData];
}

- (void)loadMoreData{
    page = page +1;
    [self loadProductData];
}
- (void)loadProductData{
    [[CSTotalTool sharedInstance] showHudInView:[CSTotalTool getCurrentShowViewController].view hint:@""];
    [[CSNewShopNetManage sharedManager] getShopCategopryListSuccessWithCid:self.currentCategoryModel.categoryId withKey:self.searchKey withPage:[NSString stringWithFormat:@"%ld",page] withLimit:@"10" Complete:^(CSNetResponseModel * _Nonnull response) {
        [self.collectionView.mj_header endRefreshing];
        [[CSTotalTool sharedInstance] hidHudInView:[CSTotalTool getCurrentShowViewController].view];
        NSArray  *array = response.data;
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
        
    }];
}

- (void)setupViews{
    JHWaterfallCollectionLayout* layout = [[JHWaterfallCollectionLayout alloc]init];
    layout.delegate = self ;
    
    //2.初始化collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.collectionView registerClass:[CSNewShopListCell class] forCellWithReuseIdentifier:@"CSNewShopListCell"];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
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
    return UIEdgeInsetsMake(10*heightScale, 10*heightScale, 10*heightScale, 10*heightScale);
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CSNewShopModel *model = self.productDataArray[indexPath.row];
    CSNewShopGoodSDetailViewController  *vc = [CSNewShopGoodSDetailViewController new];
    vc.productId = model.productId;
    [self.navigationController pushViewController:vc animated:YES];
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


@end
