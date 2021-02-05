//
//  CSNewMyOrderViewController.m
//  ColorStar
//
//  Created by apple on 2020/12/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewMyOrderViewController.h"
#import "CSNewMyOrderListCell.h"
#import "CSNewMineModel.h"
#import "CSNewShopGoodSDetailViewController.h"
@interface CSNewMyOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger  page;
}
@property(nonatomic, strong)UIView                      *navView;
@property (nonatomic, strong)UITableView            *mainTableView;
@property (nonatomic, strong)NSMutableArray         *dataSource;
@end

@implementation CSNewMyOrderViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    page = 1;
    self.dataSource = [NSMutableArray array];
    [self makeNavUI];
    [self makeUI];
}

- (void)loadData{
    page = 1;
    [self getListData];
    [self.mainTableView.mj_footer resetNoMoreData];
}

- (void)loadMoreData{
    page ++;
    [self getListData];
}

-(void)getListData{
    [[CSTotalTool sharedInstance] showHudInView:self.view hint:@""];
    [[CSNewMineNetManage sharedManager] getMineOrederListInfoSuccessPagge:[NSString stringWithFormat:@"%ld",page] withLimit:@"10" Complete:^(CSNetResponseModel * _Nonnull response) {
        [[CSTotalTool sharedInstance] hidHudInView:self.view];
        [self.mainTableView.mj_header endRefreshing];
        if (response.code == 200) {
            NSArray  *array = response.data;
            if (self->page==1) {
                [self.dataSource removeAllObjects];
                if (array.count > 0) {
                    for (NSDictionary  *dict in array) {
                        CSNewMineOrderModel  *model = [CSNewMineOrderModel yy_modelWithDictionary:dict];
                        [self.dataSource addObject:model];
                    }
                }
            }else{
                if (array.count >0) {
                    [self.mainTableView.mj_footer endRefreshing];
                    for (NSDictionary  *dict in array) {
                        CSNewMineOrderModel  *model = [CSNewMineOrderModel yy_modelWithDictionary:dict];
                        [self.dataSource addObject:model];
                    }
                }else{
                    [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
                }
                
            }
        }
        [self.mainTableView reloadData];
    } failureComplete:^(NSError * _Nonnull error) {
        [[CSTotalTool sharedInstance] hidHudInView:self.view];
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
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
    titleLabel.text = NSLocalizedString(@"我的订单",nil);
    titleLabel.font = kFont(18);
    titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.navView.mas_centerX);
        make.centerY.mas_equalTo(backButton.mas_centerY);
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
    [self.mainTableView registerClass:[CSNewMyOrderListCell class] forCellReuseIdentifier:@"CSNewMyOrderListCell"];
    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navView.mas_bottom).offset(10*heightScale);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 200*heightScale;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    CSNewMyOrderListCell *cell = [[CSNewMyOrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CSNewMyOrderListCell"];
    cell.model = self.dataSource[indexPath.row];
    CS_Weakify(self, weakSelf);
    cell.clickBlock = ^(CSNewMineOrderModel * _Nonnull model) {
        [[CSNewMineNetManage sharedManager] getDeleteOrederListInfoSuccessOrderId:model.order_id Complete:^(CSNetResponseModel * _Nonnull response) {
            if (response.code == 200) {
                [WHToast showMessage:NSLocalizedString(@"删除成功！", nil) duration:1 finishHandler:nil];
                [weakSelf loadData];
            }else{
                [WHToast showMessage:NSLocalizedString(@"删除失败！", nil) duration:1 finishHandler:nil];
            }
        } failureComplete:^(NSError * _Nonnull error) {
            [WHToast showMessage:NSLocalizedString(@"删除失败！", nil) duration:1 finishHandler:nil];
        }];
    };
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSNewMineOrderModel  *model = self.dataSource[indexPath.row];
    NSDictionary  *goodsInfo = model.goodsInfo;
    if ([model.type isEqualToString:@"0"]) {//课程订单
        CSTutorPlayViewController * playVC = [[CSTutorPlayViewController alloc]init];
        playVC.videoId = goodsInfo[@"id"];
        [self.navigationController pushViewController:playVC animated:YES];
        

    }else if([model.type isEqualToString:@"1"]){//会员订单
        
    }else if([model.type isEqualToString:@"2"]){//商品订单
        CSNewShopGoodSDetailViewController  *vc = [CSNewShopGoodSDetailViewController new];
        vc.productId = goodsInfo[@"id"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
