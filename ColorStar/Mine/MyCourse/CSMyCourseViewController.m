//
//  CSMyCourseViewController.m
//  ColorStar
//
//  Created by 陶涛 on 2020/8/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSMyCourseViewController.h"
#import "CSEmptyRefreshView.h"
#import "CSColorStar.h"
#import "CSNetworkManager.h"
#import <MBProgressHUD.h>
#import "CSMineCourseCell.h"
#import "UIColor+CS.h"
#import "CSCourseBasicModel.h"
#import <YYModel.h>
#import "CSEmptyDataCell.h"
#import "UIView+CS.h"
#import "CSArtorDetailViewController.h"

NSString * const CSMineCourseCellReuseIdentifier2 = @"CSMineCourseCellReuseIdentifier2";
NSString * const CSEmptyDataCellReuseIdentifier4 = @"CSEmptyDataCellReuseIdentifier4";


@interface CSMyCourseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView  * tableView;

@property (nonatomic, strong)CSEmptyRefreshView  * refreshView;

@property (nonatomic, strong)NSMutableArray  * list;


@end

@implementation CSMyCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"我的课程", nil);
    
    
    self.firstLoad = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.firstLoad) {
        [self loadData];
        self.refreshView = [[CSEmptyRefreshView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:self.refreshView];
        self.refreshView.frame = self.view.bounds;
        CS_Weakify(self, weakSelf);
        self.refreshView.refreshBlock = ^{
            [weakSelf loadData];
        };
        self.refreshView.hidden = YES;
    }
    
    self.firstLoad = NO;
}

- (void)loadData{
    
    
    self.refreshView.hidden = YES;
    CS_Weakify(self, weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[CSNetworkManager sharedManager] quaryPurchaseListSuccessComplete:^(CSNetResponseModel * response) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [weakSelf reloadResponse:response];
        
    } failureComplete:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        weakSelf.refreshView.hidden = NO;
    }];
    
}

- (void)reloadResponse:(CSNetResponseModel*)response{
    
    [self setupTableView];
    
    if ([response.data isKindOfClass:[NSArray class]]) {
        NSArray * data = response.data;
        if (data.count > 0) {
            for (NSDictionary * dict in data) {
                CSCourseBasicModel * model = [CSCourseBasicModel yy_modelWithDictionary:dict];
                [self.list addObject:model];
            }
        }
    }else if ([response.data isKindOfClass:[NSDictionary class]]){
        NSDictionary * data = response.data;
        NSArray * list1 = [data valueForKey:@"list"];
        if (list1.count > 0) {
            for (NSDictionary * dict in list1) {
                CSCourseBasicModel * model = [CSCourseBasicModel yy_modelWithDictionary:dict];
                [self.list addObject:model];
            }
            
        }
    }
    
    [self.tableView reloadData];
}

- (void)setupTableView{
    
    self.tableView.frame = self.view.bounds;
    [self.tableView registerClass:[CSMineCourseCell class] forCellReuseIdentifier:CSMineCourseCellReuseIdentifier2];
    [self.tableView registerClass:[CSEmptyDataCell class] forCellReuseIdentifier:CSEmptyDataCellReuseIdentifier4];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    [self.view addSubview:self.tableView];
    
}

#pragma mark - UITableView Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.list.count > 0) {
        return self.list.count;
    }
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
     if (self.list.count > 0) {
           CSMineCourseCell * cell = [tableView dequeueReusableCellWithIdentifier:CSMineCourseCellReuseIdentifier2 forIndexPath:indexPath];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
           CSCourseBasicModel * baseModel = self.list[indexPath.row];
           [cell configModel:baseModel];
           return cell;
       }else{
           CSEmptyDataCell * emptyCell = [tableView dequeueReusableCellWithIdentifier:CSEmptyDataCellReuseIdentifier4 forIndexPath:indexPath];
           return emptyCell;
       }    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.list.count > 0) {
        return 120;
    }
    return self.tableView.height;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CSCourseBasicModel * baseModel = self.list[indexPath.row];
    CSArtorDetailViewController * artorVC = [[CSArtorDetailViewController alloc]init];
    artorVC.artorId = baseModel.courseId;
    artorVC.artorName = baseModel.title;
    [self.navigationController pushViewController:artorVC animated:YES];
    
}


#pragma mark - Properties Method

 -(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#121212"];
    }
    return _tableView;
    
}

- (NSMutableArray*)list{
    if (!_list) {
        _list = [NSMutableArray arrayWithCapacity:0];
    }
    return _list;
}

@end
