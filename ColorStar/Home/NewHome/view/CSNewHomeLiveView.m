//
//  CSNewHomeLiveView.m
//  ColorStar
//
//  Created by apple on 2020/11/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewHomeLiveView.h"
#import "CSNewHomeLiveViewTopCell.h"
#import "CSNewHomeLiveViewListCell.h"
#import "CSNewHomeNetManager.h"
#import "CSNewHomeRecommendModel.h"
#import "CSTutorLiveViewController.h"
@interface CSNewHomeLiveView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSInteger page;
    NSString *type;
}
@property (nonatomic, strong)UICollectionView  * collectionView;
@property (nonatomic, strong)NSMutableArray     *bannerArray;
@property (nonatomic, strong)NSMutableArray     *tagsArray;
@property (nonatomic, strong)NSMutableArray     *listArray;
@end

@implementation CSNewHomeLiveView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.bannerArray = [NSMutableArray array];
        self.tagsArray = [NSMutableArray array];
        self.listArray = [NSMutableArray array];
        self.backgroundColor =  [UIColor colorWithHexString:@"#181F30"];
        page = 1;
        type = @"";
        [self setupViews];
        [self loadFirstData];
        [self loadData];
        }
    return self;
}
- (void)loadData{
    page = 1;
    [self loadListDataWithPage:[NSString stringWithFormat:@"%ld",page] withLimit:@"10" withType:type];
    [self.collectionView.mj_footer resetNoMoreData];
}

- (void)loadMoreData{
    page = page + 1;
    [self loadListDataWithPage:[NSString stringWithFormat:@"%ld",page] withLimit:@"10" withType:type];
   
}
- (void)loadListDataWithPage:(NSString *)pagestr withLimit:(NSString *)limit withType:(NSString *)type{
    NSDictionary  *dict = @{@"type":type,
                            @"page":pagestr,
                            @"limit":limit,
                            @"token":[CSAPPConfigManager sharedConfig].sessionKey
    };
    [[CSTotalTool sharedInstance] showHudInView:[CSTotalTool getCurrentShowViewController].view hint:@""];
    [[CSNewHomeNetManager sharedManager] getHomeLiveInfoListSuccessWithDict:dict Complete:^(CSNetResponseModel * _Nonnull response) {
        [self.collectionView.mj_header endRefreshing];
        [[CSTotalTool sharedInstance] hidHudInView:[CSTotalTool getCurrentShowViewController].view];
        if (response.code == 200) {
            NSArray *arrray = response.data;
            if (self->page==1) {
                [self.listArray removeAllObjects];
                if (arrray.count > 0) {
                    for (NSDictionary *dict in arrray) {
                        CSNewHomeLiveListModel *model = [CSNewHomeLiveListModel yy_modelWithDictionary:dict];
                        [self.listArray addObject:model];
                    }
                }
                
            }else{
                if (arrray.count > 0) {
                    for (NSDictionary *dict in arrray) {
                        CSNewHomeLiveListModel *model = [CSNewHomeLiveListModel yy_modelWithDictionary:dict];
                        [self.listArray addObject:model];
                    }
                    [self.collectionView.mj_footer endRefreshing];
                }else{
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }
                
            }
        }else{
            [WHToast showMessage:response.msg duration:1.0 finishHandler:nil];
        }
        [self.collectionView reloadData];
        
    } failureComplete:^(NSError * _Nonnull error) {
        [[CSTotalTool sharedInstance] hidHudInView:[CSTotalTool getCurrentShowViewController].view];
    }];
}
- (void)loadFirstData{
    [[CSTotalTool sharedInstance] showHudInView:[CSTotalTool getCurrentShowViewController].view hint:@""];
    [[CSNewHomeNetManager sharedManager] getHomeLiveInfoSuccessComplete:^(CSNetResponseModel * _Nonnull response) {
        if (response.code == 200) {
        [self.collectionView.mj_header endRefreshing];
        [[CSTotalTool sharedInstance] hidHudInView:[CSTotalTool getCurrentShowViewController].view];
        NSDictionary  *dict = response.data;
        NSMutableArray *bannerArray = dict[@"banner"];
        NSMutableArray *tagsListArray = dict[@"subjectList"];
        //NSMutableArray *listArray = dict[@"liveList"];
        for (NSDictionary  *dict1 in bannerArray) {
            CSNewHomeLiveBannerModel *model = [CSNewHomeLiveBannerModel yy_modelWithDictionary:dict1];
            [self.bannerArray addObject:model];
        }
        for (NSDictionary  *dict2 in tagsListArray) {
            CSNewHomeLiveTagModel *model = [CSNewHomeLiveTagModel yy_modelWithDictionary:dict2];
            model.isSelect = NO;
            [self.tagsArray addObject:model];
        }
//        for (NSDictionary  *dict3 in listArray) {
//            CSNewHomeLiveListModel *model = [CSNewHomeLiveListModel yy_modelWithDictionary:dict3];
//            [self.listArray addObject:model];
//        }

        
        
            
        }else{
            [WHToast showMessage:response.msg duration:1.0 finishHandler:nil];
        }
        [self.collectionView reloadData];
        
    } failureComplete:^(NSError * _Nonnull error) {
        [[CSTotalTool sharedInstance] hidHudInView:[CSTotalTool getCurrentShowViewController].view];
    }];
}
- (void)setupViews{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //layout.estimatedItemSize = CGSizeMake(ScreenW, 10);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    [self.collectionView registerClass:[CSNewHomeLiveViewTopCell class] forCellWithReuseIdentifier:@"CSNewHomeLiveViewTopCell"];
    [self.collectionView registerClass:[CSNewHomeLiveViewListCell class] forCellWithReuseIdentifier:@"CSNewHomeLiveViewListCell"];
    
    [self addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];
  
}


#pragma mark - UICollectionView Method
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.listArray.count;
    }
    
    
    //return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        CSNewHomeLiveViewTopCell * innerCell =[collectionView dequeueReusableCellWithReuseIdentifier:@"CSNewHomeLiveViewTopCell" forIndexPath:indexPath];
        innerCell.bannerArray = self.bannerArray;
        innerCell.tagsArray = self.tagsArray;
        CS_Weakify(self, weakSelf);
        innerCell.clickBlock = ^(CSNewHomeLiveTagModel * _Nonnull model) {
            self->type = model.subjectId;
            [weakSelf loadData];
            
        };
        return innerCell;
    }else{
        
        CSNewHomeLiveViewListCell * innerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CSNewHomeLiveViewListCell" forIndexPath:indexPath];
        innerCell.model = self.listArray[indexPath.row];
        return innerCell;
    }
    
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section ==1) {
        return UIEdgeInsetsMake(0, 10*widthScale, 0, 10*widthScale);
    }else{
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section== 1) {
        return CGSizeMake((ScreenW-30*widthScale)/2, 218*heightScale);
    }
    else{
        return CGSizeMake(ScreenW, 237*heightScale);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if ([[CSNewLoginUserInfoManager sharedManager] isLogin]) {
            CSNewHomeLiveListModel *modl = self.listArray[indexPath.row];
            CSTutorLiveViewController *vc = [CSTutorLiveViewController new];
            vc.stream_name =modl.stream_name;
            vc.live_id = modl.liveListId;
            vc.special_id = modl.special_id;
            [[CSTotalTool getCurrentShowViewController].navigationController pushViewController:vc animated:YES];
        }else{
            [[CSNewLoginUserInfoManager sharedManager] goToLogin:^(BOOL success) {
                
            }];
        }
        
    }
}

- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}




@end
