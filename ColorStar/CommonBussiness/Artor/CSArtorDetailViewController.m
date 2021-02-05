//
//  CSArtorDetailViewController.m
//  ColorStar
//
//  Created by gavin on 2020/8/14.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSArtorDetailViewController.h"
#import "CSNetworkManager.h"
#import <MBProgressHUD.h>
#import "CSArtorCourseListCell.h"
#import "UIView+CS.h"
#import "CSArtorTopView.h"
#import "CSArtorModels.h"
#import "CSEmptyRefreshView.h"
#import "CSColorStar.h"
#import <YYModel.h>
#import "CSArtorSwitchView.h"
#import "CSCourseDetailViewController.h"
#import <Masonry/Masonry.h>
#import "UIColor+CS.h"
#import "CSLiveDetailViewController.h"
#import "CSLoginManager.h"

static CGFloat liveViewHeight = 50;

NSString * const CSArtorCourseListCellReuseIdentifier = @"CSArtorCourseListCellReuseIdentifier";
NSString * const CSArtorSwitchViewReuseIdentifier = @"CSArtorSwitchViewReuseIdentifier";

@interface CSArtorDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)CSEmptyRefreshView  * refreshView;

@property (nonatomic, strong)CSArtorTopView  * topView;

@property (nonatomic, strong)UITableView  * tableView;

@property (nonatomic, strong)CSArtorDetailModel  * detailModel;

@property (nonatomic, strong)UIView       * liveView;//直播入口

@property (nonatomic, assign)BOOL         isLiveDetail;

@end

@implementation CSArtorDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.artorName;
    
    self.refreshView = [[CSEmptyRefreshView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.refreshView];
    self.refreshView.frame = self.view.bounds;
    CS_Weakify(self, weakSelf);
    self.refreshView.refreshBlock = ^{
        [weakSelf loadData];
    };
    self.refreshView.hidden = YES;
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)loadData{
    
    self.refreshView.hidden = YES;
    CS_Weakify(self, weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[CSNetworkManager sharedManager] quaryArtorDetail:self.artorId successComplete:^(CSNetResponseModel *response) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [weakSelf reloadResponse:response];
        
    } failureComplete:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        weakSelf.refreshView.hidden = NO;
    }];
}
- (void)reloadResponse:(CSNetResponseModel*)response{
    NSDictionary * dict = response.data;
    self.detailModel = [CSArtorDetailModel yy_modelWithDictionary:dict];
    
    [self setuTopView];
    [self setupTabelView];
    
}

- (void)setuTopView{
    self.topView = [[CSArtorTopView alloc]initWithModel:self.detailModel];
    self.topView.frame = CGRectMake(0, 0, self.view.width, self.view.width*((208.0/389.0)) + 120);
}

- (void)setupTabelView{
    
    CGRect tableViewRect = self.view.bounds;
    if (self.isLiveDetail) {
        [self setupLiveView];
        tableViewRect = CGRectMake(0, 0, self.view.width, self.view.height - liveViewHeight - kSafeAreaBottomHeight);
    }
    
    self.tableView = [[UITableView alloc]initWithFrame:tableViewRect style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CSArtorCourseListCell class] forCellReuseIdentifier:CSArtorCourseListCellReuseIdentifier];
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.topView;
    
}

- (void)setupLiveView{
    self.liveView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.liveView];
    [self.liveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(liveViewHeight + kSafeAreaBottomHeight);
    }];
    
    UIButton * liveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    liveBtn.layer.masksToBounds = YES;
    liveBtn.layer.cornerRadius = 20;
    liveBtn.backgroundColor = [UIColor colorWithHexString:@"#CBA56B"];
    [liveBtn setTitle:@"进入直播间" forState:UIControlStateNormal];
    [liveBtn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    liveBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [liveBtn addTarget:self action:@selector(liveClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.liveView addSubview:liveBtn];
    [liveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.liveView);
        make.left.mas_equalTo(self.liveView).offset(30);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.liveView).offset(5);
    }];
    
    
    
}

- (void)switchIndex:(NSInteger)index{
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    CSArtorCourseListCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell switchToIndex:index];
    
}


#pragma mark - Action Method

- (void)liveClick:(UIButton*)sender{
    
    if (![[CSLoginManager sharedManager] isLogin]) {
        [[CSLoginManager sharedManager] tryLoginOrRegisterComplete:^(BOOL success, NSString *msg) {
            if (success) {
                [self enterLiveVC];
            }
                }];
    }else{
        [self enterLiveVC];
    }
}

- (void)enterLiveVC{
    
    CSLiveDetailViewController * liveVC = [[CSLiveDetailViewController alloc]init];
    liveVC.liveInfo = self.detailModel.liveInfo;
    [self.navigationController pushViewController:liveVC animated:YES];
    
}

#pragma mark - UITableViewDataSource Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CSArtorCourseListCell * cell = (CSArtorCourseListCell*)[tableView dequeueReusableCellWithIdentifier:CSArtorCourseListCellReuseIdentifier forIndexPath:indexPath];
    cell.model = self.detailModel;
    CS_Weakify(self, weakSelf);
    
    cell.courseClick = ^(CSArtorCourseRowModel *rowModel, NSIndexPath *index) {
        CSCourseDetailViewController * courseVC = [[CSCourseDetailViewController alloc]init];
        courseVC.rowModels = self.detailModel.special.courses.list;
        courseVC.selectedIndex = index.row;
        [weakSelf.navigationController pushViewController:courseVC animated:YES];
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        CSArtorSwitchView * headerView = [[CSArtorSwitchView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 60)];
        CS_Weakify(self, weakSelf);
        headerView.switchBlock = ^(NSInteger index) {
            [weakSelf switchIndex:index];
        };
        headerView.isLive = self.isLiveDetail;
        return headerView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.tableView.height - self.topView.height - 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

#pragma mark - Properties Method

- (BOOL)isLiveDetail{
    return self.detailModel.special.special.type == 4 && self.detailModel.liveInfo != nil;
}

@end
