//
//  CSNewPunchListViewController.m
//  ColorStar
//
//  Created by apple on 2021/1/14.
//  Copyright © 2021 gavin. All rights reserved.
//

#import "CSNewPunchListViewController.h"
#import "CSNewPunchListCell.h"
#import "CSNewMineModel.h"

@interface CSNewPunchListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger  page;
}
@property(nonatomic, strong)UIView                      *navView;
@property (nonatomic, strong)UITableView            *mainTableView;
@property (nonatomic, strong)NSMutableArray         *dataSource;
@end

@implementation CSNewPunchListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    page = 1;
    self.dataSource = [NSMutableArray array];
    [self makeNavUI];
    [self makeUI];
    [self loadData];
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
    [[CSNewMineNetManage sharedManager] getSignListWithPage:[NSString stringWithFormat:@"%ld",page] Complete:^(CSNetResponseModel * _Nonnull response) {
        [[CSTotalTool sharedInstance] hidHudInView:self.view];
        [self.mainTableView.mj_header endRefreshing];
        if (response.code == 200) {
            NSArray  *array = response.data;
            if (self->page==1) {
                [self.dataSource removeAllObjects];
                if (array.count > 0) {
                    for (NSDictionary  *dict in array) {
                        CSNewPunchListModel  *model = [CSNewPunchListModel yy_modelWithDictionary:dict];
                        [self.dataSource addObject:model];
                    }
                }
            }else{
                if (array.count >0) {
                    [self.mainTableView.mj_footer endRefreshing];
                    for (NSDictionary  *dict in array) {
                        CSNewPunchListModel  *model = [CSNewPunchListModel yy_modelWithDictionary:dict];
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
    titleLabel.text = csnation(@"打卡明细");
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
    [self.mainTableView registerClass:[CSNewPunchListCell class] forCellReuseIdentifier:@"CSNewPunchListCell"];
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
   
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    CSNewPunchListCell *cell = [[CSNewPunchListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CSNewPunchListCell"];
     cell.model = self.dataSource[indexPath.row];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
       return cell;

}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
