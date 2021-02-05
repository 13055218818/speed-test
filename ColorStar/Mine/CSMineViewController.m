//
//  CSMineViewController.m
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSMineViewController.h"
#import "CSMineTopViewModel.h"
#import "CSMineTopView.h"
#import "CSMineConfigModel.h"
#import "CSMineConfigCell.h"
#import <YYModel.h>
#import "CSRouterManger.h"
#import "UIView+CS.h"
#import "CSLoginManager.h"
#import "CSColorStar.h"
#import "NSString+CSAlert.h"

#import "CSSettingViewController.h"
#import "CSMyCourseViewController.h"
#import "CSMyRecordViewController.h"
#import "CSMyFavoriteViewController.h"
#import "CSMySignViewController.h"
#import "CSMyMemberViewController.h"
#import "CSMySpreadViewController.h"
#import "CSMyPinkViewController.h"
#import "CSMyApplyViewController.h"
#import "CSMyPresentViewController.h"
#import "CSMyRechargeViewController.h"
#import "CSAboutViewController.h"
#import "CSServiceViewController.h"
#import "CSWebViewController.h"
#import "CSAPPConfigManager.h"
#import "CSNetworkManager.h"

NSString * const CSMineConfigCellReuseIdentifier = @"CSMineConfigCellReuseIdentifier";

@interface CSMineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)CSMineTopViewModel * topViewModel;

@property (nonatomic, strong)CSMineTopView      * topView;

@property (nonatomic, strong)NSMutableArray   * listConfigs;

@property (nonatomic, strong)UITableView  * tableView;

@end

@implementation CSMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = nil;
    self.title = NSLocalizedString(@"个人中心", nil);
    self.firstLoad = YES;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.firstLoad) {
        [self loadConfig];
        [self setupTableView];
    }
    self.firstLoad = NO;
}

- (void)loadConfig{
    NSString * configPath = [[NSBundle mainBundle] pathForResource:@"cs_mine_setting" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:configPath];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    
    NSArray * list1 = [dict valueForKey:@"list1"];
    self.listConfigs = [NSMutableArray arrayWithCapacity:0];
    if (list1.count > 0) {
        for (NSDictionary * dict in list1) {
            CSMineConfigModel * model = [CSMineConfigModel yy_modelWithDictionary:dict];
            [self.listConfigs addObject:model];
        }
    }
    
    
    NSArray * list2 = [dict valueForKey:@"list2"];
    NSMutableArray * topData = [NSMutableArray arrayWithCapacity:0];
    if (list2.count > 0) {
        for (NSDictionary * dict in list2) {
            CSMineConfigModel * model = [CSMineConfigModel yy_modelWithDictionary:dict];
            [topData addObject:model];
        }
        self.topViewModel.configs = topData;
    }
    
    self.topView = [[CSMineTopView alloc]initWithTopViewModel:self.topViewModel];
    self.topView.frame = CGRectMake(0, 0, self.view.width, (300 - 66 - 100));
    
    
    CS_Weakify(self, weakSelf);
    self.topView.click = ^(CSMineConfigModel *config) {
        
         CSBaseViewController * vc = [weakSelf getConfigVCWithModel:config];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    self.topView.setting = ^{
        CSSettingViewController * vc = [[CSSettingViewController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    [[CSNetworkManager sharedManager] quaryMyInfoNumberSuccessComplete:^(CSNetResponseModel *response) {
        if ([response.data isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict = response.data;
            NSString * collNum = [dict valueForKey:@"collNum"];
            NSString * recordNum = [dict valueForKey:@"recordNum"];
            for (CSMineConfigModel * configModel in self.topViewModel.configs) {
                if (configModel.configType == CSMineConfigTypeFavorite) {
                    configModel.subName = [NSString stringWithFormat:@"已收藏%@个",collNum];
                }
                if (configModel.configType == CSMineConfigTypeRecord) {
                    configModel.subName = [NSString stringWithFormat:@"共有%@记录",recordNum];
                }
            }
            [weakSelf.topView reloadData];
        }
        
        
    } failureComplete:^(NSError *error) {
        
    }];
    
}

- (void)setupTableView{
    self.tableView  = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CSMineConfigCell class] forCellReuseIdentifier:CSMineConfigCellReuseIdentifier];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.tableHeaderView = self.topView;
    
}


#pragma mark - UITableView Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listConfigs.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CSMineConfigCell * configCell = [tableView dequeueReusableCellWithIdentifier:CSMineConfigCellReuseIdentifier forIndexPath:indexPath];
    CSMineConfigModel * model = self.listConfigs[indexPath.row];
    [configCell configModel:model];
    configCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return configCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CSMineConfigModel * model = self.listConfigs[indexPath.row];
    
    CSBaseViewController * vc = [self getConfigVCWithModel:model];
//    [[CSRouterManger sharedManger] pushToVC:vc];
    if (model.configType == CSMineConfigTypeCourse || model.configType == CSMineConfigTypeRecord || model.configType == CSMineConfigTypeFavorite ) {
        [self.navigationController pushViewController:vc animated:YES];
    }else if (model.configType == CSMineConfigTypeAbout){
        CSWebViewController * webVC = [[CSWebViewController alloc]init];
        webVC.title = NSLocalizedString(@"关于我们", nil);
        webVC.content = [CSAPPConfigManager sharedConfig].aboutUS;
        [self.navigationController pushViewController:webVC animated:YES];
        
    }else{
        [NSLocalizedString(@"功能暂未开通，敬请期待", nil) showAlert];
    }
    
}


#pragma mark - Private Method
- (CSBaseViewController*)getConfigVCWithModel:(CSMineConfigModel*)model{
    

    CSBaseViewController * configVC = nil;
    switch (model.configType) {
        case CSMineConfigTypeCourse:{
            configVC = [[CSMyCourseViewController alloc]init];
        }
        
             break;
        case CSMineConfigTypeRecord:{
            configVC = [[CSMyRecordViewController alloc]init];
        }
        
             break;
        case CSMineConfigTypeFavorite:{
            configVC = [[CSMyFavoriteViewController alloc]init];
        }
        
             break;
        case CSMineConfigTypeSign:{
            configVC = [[CSMySignViewController alloc]init];
        }
            
            break;
        case CSMineConfigTypeMember:{
            configVC = [[CSMyMemberViewController alloc]init];
        }
        
            break;
        case CSMineConfigTypeSpread:{
            configVC = [[CSMySpreadViewController alloc]init];
        }
        
            break;
        case CSMineConfigTypePink:{
            configVC = [[CSMyPinkViewController alloc]init];
        }
        
            break;
        case CSMineConfigTypeApply:{
            configVC = [[CSMyApplyViewController alloc]init];
        }
        
            break;
        case CSMineConfigTypePresent:{
            configVC = [[CSMyPresentViewController alloc]init];
        }
        
            break;
        case CSMineConfigTypeRecharge:{
            configVC = [[CSMyRechargeViewController alloc]init];
        }
        
            break;
        case CSMineConfigTypeAbout:{
            configVC = [[CSAboutViewController alloc]init];
        }
        
            break;
        case CSMineConfigTypeService:{
            configVC = [[CSServiceViewController alloc]init];
        }
            break;
    }
    return configVC;
}

#pragma mark  - Properties Method

- (CSMineTopViewModel*)topViewModel{
    if (!_topViewModel) {
        _topViewModel = [[CSMineTopViewModel alloc]init];
        _topViewModel.userInfo = [CSLoginManager sharedManager].userInfo;
    }
    return _topViewModel;
}


@end
