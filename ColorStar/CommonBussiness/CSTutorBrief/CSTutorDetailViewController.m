//
//  CSNewArtorDetailViewController.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorDetailViewController.h"
#import "CSTutorDetailNavView.h"
#import "CSTutorAvtorCell.h"
#import "CSTutorBriefCell.h"
#import "CSTutorCoursePreviewCell.h"
#import "CSTutorCourseListCell.h"
#import "CSTutorCommonListCell.h"
#import "CSTutorCourseDetailCell.h"
#import "CSTutorCourseDetaiHeaderCell.h"
#import "CSTutorPlayViewController.h"
#import "CSTutorDetailManager.h"
#import "CSTutorDetailModel.h"
#import "CSNewHomeNetManager.h"
#import "CSShareManager.h"
#import "CSTutorDetailEmptyCell.h"

@interface CSTutorDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)CSTutorDetailNavView * navView;

@property (nonatomic, strong)UITableView * tableView;//主页面

@property (nonatomic, strong)CSTutorDetailModel * detailModel;

@end

@implementation CSTutorDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    [self setupViews];
    [self fetchTutorInfo:YES];
}

- (void)setupViews{
    
    CS_Weakify(self, weakSelf);

    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = LoadColor(@"#181F30");
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.tableView registerClass:[CSTutorDetailEmptyCell class] forCellReuseIdentifier:[CSTutorDetailEmptyCell reuserIndentifier]];
    
    [self.tableView registerClass:[CSTutorAvtorCell class] forCellReuseIdentifier:[CSTutorAvtorCell reuserIndentifier]];
    
    [self.tableView registerClass:[CSTutorBriefCell class] forCellReuseIdentifier:[CSTutorBriefCell reuserIndentifier]];
    
    [self.tableView registerClass:[CSTutorCoursePreviewCell class] forCellReuseIdentifier:[CSTutorCoursePreviewCell reuserIndentifier]];
    
    
    [self.tableView registerClass:[CSTutorCourseListCell class] forCellReuseIdentifier:[CSTutorCourseListCell reuserIndentifier]];
    
    
    [self.tableView registerClass:[CSTutorCommonListCell class] forCellReuseIdentifier:[CSTutorCommonListCell reuserIndentifier]];
    
    [self.tableView registerClass:[CSTutorCourseDetaiHeaderCell class] forCellReuseIdentifier:[CSTutorCourseDetaiHeaderCell reuserIndentifier]];
    [self.tableView registerClass:[CSTutorCourseDetailCell class] forCellReuseIdentifier:[CSTutorCourseDetailCell reuserIndentifier]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchTutorInfo:NO];
    }];

    
    self.navView = [[CSTutorDetailNavView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, kNavigationHeight)];
    self.navView.backgroundColor = [UIColor colorWithHexString:@"#181F30" alpha:0.01];
    self.navView.titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.01];
    self.navView.followBtn.alpha = 0.01;
    [self.view addSubview:self.navView];
    
    self.navView.navBlock = ^(CSTutorDetailNavBlockType type) {
        if (type == CSTutorDetailNavBlockTypeBack) {
            [weakSelf backClick];
        }else if (type == CSTutorDetailNavBlockTypeShare){
            [weakSelf shareClick];
        }else if (type == CSTutorDetailNavBlockTypeFollow){
            [weakSelf followClick];
        }
        
    };
    
    
}

#pragma mark - NetWork

- (void)fetchTutorInfo:(BOOL)first{
    
    if (first) {
        [self showProgressHUD];
    }
    CS_Weakify(self, weakSelf);
    [[CSTutorDetailManager sharedManager] fetchTutorInfo:self.tutorId complete:^(CSNetResponseModel *response, NSError *error) {
        [weakSelf hideProgressHUD];
        [weakSelf.tableView.mj_header endRefreshing];
        if (response) {
            NSDictionary * dict = (NSDictionary*)response.data;
            CSTutorDetailModel * model = [CSTutorDetailModel yy_modelWithDictionary:dict];
            weakSelf.detailModel = model;
            weakSelf.navView.titleLabel.text = weakSelf.detailModel.title;
            weakSelf.navView.followBtn.isFollow = weakSelf.detailModel.is_follow;
            [self.tableView reloadData];
            
        }
        
    }];

}

#pragma mark - action

- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareClick{
    [[CSShareManager shared] showShareView];
}

- (void)followClick{
    
    if ([CSNewLoginUserInfoManager sharedManager].isLogin) {
        [self dofollow];
    }else{
        [[CSNewLoginUserInfoManager sharedManager] goToLogin:^(BOOL success) {
            
        }];
    }
    
    
}

- (void)dofollow{
    CS_Weakify(self, weakSelf);
    [[CSNewHomeNetManager sharedManager] getHomeaddFollowSuccessId:self.detailModel.tutorId Complete:^(CSNetResponseModel * _Nonnull response) {
        if (response.code == 200) {
            weakSelf.detailModel.is_follow = !weakSelf.detailModel.is_follow;
            weakSelf.navView.followBtn.isFollow = weakSelf.detailModel.is_follow;
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }else{
            [WHToast showMessage:response.msg duration:1.0 finishHandler:nil];
        }
        
        } failureComplete:^(NSError * _Nonnull error) {
            
        }];
}

- (void)showBannerExpand:(BOOL)expand{

    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0],[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offSetY = scrollView.contentOffset.y;
    
    if (offSetY > 0) {
        
        CGFloat height = 400.0;
        CGFloat alpha = offSetY/height;
        self.navView.backgroundColor = [UIColor colorWithHexString:@"#181F30" alpha:alpha];
        self.navView.titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:alpha];
        self.navView.followBtn.alpha = alpha;
    }else{
        self.navView.backgroundColor = [UIColor colorWithHexString:@"#181F30" alpha:0.01];
        self.navView.titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.01];
        self.navView.followBtn.alpha = 0.01;
    }
    
}

#pragma mark UITableView Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (!self.detailModel) {
        return 1;
    }
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!self.detailModel) {
        return 1;
    }
    if (section == 0) {
        return 3;
    }else if (section == 3){
        return self.detailModel.round_tasks.count;
    }
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!self.detailModel) {
        CSTutorDetailEmptyCell  * emptyCell = [tableView dequeueReusableCellWithIdentifier:[CSTutorDetailEmptyCell reuserIndentifier]];
        return emptyCell;
    }
    
    if (indexPath.section == 0) {
        CS_Weakify(self, weakSelf);
        if (indexPath.row == 0) {
            
            CSTutorAvtorCell * cell = [tableView dequeueReusableCellWithIdentifier:[CSTutorAvtorCell reuserIndentifier] forIndexPath:indexPath];
            [cell configModel:self.detailModel];
            CS_Weakify(self, weakSelf);
            cell.avtorBlock = ^{
                [weakSelf followClick];
            };
            return cell;
        }else if (indexPath.row == 1){
            CSTutorBriefCell * cell = [tableView dequeueReusableCellWithIdentifier:[CSTutorBriefCell reuserIndentifier] forIndexPath:indexPath];
            [cell configModel:self.detailModel];
            
            cell.briefBlock = ^{
                [weakSelf showBannerExpand:YES];
            };
            return cell;
        }else if (indexPath.row == 2){
            CSTutorCoursePreviewCell * cell = [tableView dequeueReusableCellWithIdentifier:[CSTutorCoursePreviewCell reuserIndentifier] forIndexPath:indexPath];
            [cell configModel:self.detailModel.banner];
            cell.previewBlock = ^{
                [weakSelf showBannerExpand:NO];
            };
            return cell;
        }
        return nil;
    }else if (indexPath.section == 1){
        
        
        CSTutorCourseListCell * cell = [tableView dequeueReusableCellWithIdentifier:[CSTutorCourseListCell reuserIndentifier] forIndexPath:indexPath];
        [cell configModel:self.detailModel.task_list];
        CS_Weakify(self, weakSelf);
        cell.cellBlock = ^(id obj) {
            if ([obj isKindOfClass:[CSTutorCourseModel class]]) {
                [weakSelf enterVideoPlayVC:obj];
            }
            
        };
        return cell;
        
    }else if (indexPath.section == 2){
        
        CSTutorCommonListCell * cell = [tableView dequeueReusableCellWithIdentifier:[CSTutorCommonListCell reuserIndentifier] forIndexPath:indexPath];
        [cell configModel:self.detailModel.discuss_list];
        return cell;
        
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            CSTutorCourseDetaiHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:[CSTutorCourseDetaiHeaderCell reuserIndentifier]];
            return cell;
        }
        
        CSTutorCourseModel * courseModel = self.detailModel.round_tasks[indexPath.row-1];
        CSTutorCourseDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:[CSTutorCourseDetailCell reuserIndentifier] forIndexPath:indexPath];
        [cell configModel:courseModel];
        return cell;
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!self.detailModel) {
        return self.tableView.height;
    }
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            CGFloat height = ScreenW*(400.0/375.0) + 75;
            return height;
        }else if (indexPath.row == 1){
            CGFloat originHeight = 20 + 13 + 14 + 25;
            NSString * text = self.detailModel.abstract;
            CGSize detailSize = [text boundingRectWithSize:CGSizeMake(ScreenW - 30, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]} context:nil].size;
            self.detailModel.shouldExpand = detailSize.height > 50;
            self.detailModel.textHeight = detailSize.height;
            CGFloat textHeight = (self.detailModel.shouldExpand && self.detailModel.expanding) ? detailSize.height : 50;
            return originHeight + textHeight;
        }else if (indexPath.row == 2){
            CGFloat contentHeight = 30 + widthScale*280 + 10 + widthScale*110 + 15;
            CGFloat height = self.detailModel.showBanner ? contentHeight : 0.01;
            return height;
        }
        
    }else if (indexPath.section == 1){
        if (self.detailModel.task_list.count == 0) {
            return 0;
        }
        CGFloat height = (ScreenW*3/4)*(165.0/270.0) + 50;
        return height;
    }else if (indexPath.section == 2){
        if (self.detailModel.discuss_list.count == 0) {
            return 0.01;
        }
        CGFloat height = (widthScale*315.0f)*(165.0/315.0) + 50;
        return height;
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            return 50;
        }
        return 130;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!self.detailModel) {
        return;                        
    }
    
    if (indexPath.section == 3) {
        if (indexPath.row > 0) {
            CSTutorCourseModel * courseModel = self.detailModel.round_tasks[indexPath.row-1];
            [self enterVideoPlayVC:courseModel];
            
        }
    }
    
}

- (void)enterVideoPlayVC:(CSTutorCourseModel*)model{
    CSTutorPlayViewController * playVC = [[CSTutorPlayViewController alloc]init];
    playVC.videoId = model.courseId;
    [self.navigationController pushViewController:playVC animated:YES];
    
}

@end
