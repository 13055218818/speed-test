//
//  CSNewMyCollectViewController.m
//  ColorStar
//
//  Created by apple on 2020/12/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewMyCollectViewController.h"
#import "CSNewShopGoodSDetailViewController.h"
#import "CSNewMyCollectionCell.h"
#import "CSNewMineModel.h"

@interface CSNewMyCollectViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSInteger       page;
}
@property(nonatomic, strong)UIView                      *navView;
@property (nonatomic, strong)UICollectionView           *collectionView;
@property (nonatomic, strong) NSMutableArray            *dataSource;
@end

@implementation CSNewMyCollectViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    self.dataSource = [NSMutableArray array];
    page = 1;
    [self makeNavUI];
    [self setupViews];
    
}
- (void)loadData{
    page = 1;
    [self getListData];
    [self.collectionView.mj_footer resetNoMoreData];
}
- (void)loadMoreData{
    page ++;
    [self getListData];
}

-(void)getListData{
    [[CSTotalTool sharedInstance] showHudInView:self.view hint:@""];
    [[CSNewMineNetManage sharedManager] getMineCollectionListInfoSuccessPagge:[NSString stringWithFormat:@"%ld",page] withLimit:@"10" Complete:^(CSNetResponseModel * _Nonnull response) {
        [[CSTotalTool sharedInstance] hidHudInView:self.view];
        [self.collectionView.mj_header endRefreshing];
        if (response.code == 200) {
            NSArray  *array = response.data;
            if (self->page==1) {
                [self.dataSource removeAllObjects];
                if (array.count > 0) {
                    for (NSDictionary  *dict in array) {
                        CSNewMineModel  *model = [CSNewMineModel yy_modelWithDictionary:dict];
                        [self.dataSource addObject:model];
                    }
                }
            }else{
                if (array.count >0) {
                    [self.collectionView.mj_footer endRefreshing];
                    for (NSDictionary  *dict in array) {
                        CSNewMineModel  *model = [CSNewMineModel yy_modelWithDictionary:dict];
                        [self.dataSource addObject:model];
                    }
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

#pragma mark--UI--
-(void)makeNavUI{
    self.navView = [[UIView alloc] init];
    self.navView.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_offset(@(kStatusBarHeight + 44.0*heightScale));
    }];
    //
    UIButton  *backButton = [[UIButton alloc] init];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"CSNewShopListBack"] forState:UIControlStateNormal];
    [self.navView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.navView);
        make.bottom.mas_equalTo(self.navView);
        make.width.mas_offset(@(55*heightScale));
        make.height.mas_offset(@(44*heightScale));
    }];
    UILabel  *titleLabel = [[UILabel alloc] init];
    titleLabel.text = NSLocalizedString(@"我的收藏",nil);
    titleLabel.font = kFont(18);
    titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.navView.mas_centerX);
        make.centerY.mas_equalTo(backButton.mas_centerY);
    }];
}
- (void)setupViews{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //layout.estimatedItemSize = CGSizeMake((ScreenW-30*widthScale/2), 10);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    //下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];//[MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    [self.collectionView registerClass:[CSNewMyCollectionCell class] forCellWithReuseIdentifier:@"CSNewMyCollectionCell"];
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navView.mas_bottom).offset(16*heightScale);
    }];
}
#pragma mark - UICollectionView Method
- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{

    return YES;

}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CSNewMyCollectionCell * innerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CSNewMyCollectionCell" forIndexPath:indexPath];
    if (self.dataSource.count > 0) {
        innerCell.model = self.dataSource[indexPath.row];
    }
    
    return innerCell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((ScreenW -40*widthScale)/2, 210*heightScale);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 10*widthScale, 0, 10*widthScale);
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CSTutorPlayViewController * playVC = [[CSTutorPlayViewController alloc]init];
    CSNewMineModel  *model = self.dataSource[indexPath.row];
    playVC.videoId = model.link_id;
    [self.navigationController pushViewController:playVC animated:YES];
    
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
