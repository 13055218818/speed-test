//
//  CSLiveListViewController.m
//  ColorStar
//
//  Created by gavin on 2020/9/27.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSLiveListViewController.h"

@interface CSLiveListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray  * liveList;

@property (nonatomic, strong)UITableView     * tableView;

@end

@implementation CSLiveListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)processNetWorkSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    
}

- (void)processData:(CSNetResponseModel*)response{
    
    
}

- (void)setupView{
    [self.view addSubview:self.tableView];
    
}


#pragma mark - Properties Method

- (NSMutableArray*)liveList{
    if (!_liveList) {
        _liveList = [NSMutableArray arrayWithCapacity:0];
    }
    return _liveList;
}

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
