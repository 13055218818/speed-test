//
//  CSNetBaseViewController.m
//  ColorStar
//
//  Created by 陶涛 on 2020/9/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNetBaseViewController.h"
#import "CSEmptyRefreshView.h"
#import "CSColorStar.h"
#import <MBProgressHUD.h>

@interface CSNetBaseViewController ()

@property (nonatomic, strong)CSEmptyRefreshView  * refreshView;


@end

@implementation CSNetBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.firstLoad = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    if (self.firstLoad) {
        [self loadData];
        self.refreshView = [[CSEmptyRefreshView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:self.refreshView];
           
        CS_Weakify(self, weakSelf);
        self.refreshView.refreshBlock = ^{
            [weakSelf loadData];
        };
        self.refreshView.hidden = YES;
    }
    self.firstLoad = YES;
}

- (void)loadData{
    
    self.refreshView.hidden = YES;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    CS_Weakify(self, weakSelf);
    [self processNetWorkSuccessComplete:^(CSNetResponseModel *response) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [weakSelf processData:response];
    } failureComplete:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        weakSelf.refreshView.hidden = NO;
    }];
}

- (void)processNetWorkSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    
}

- (void)processData:(CSNetResponseModel *)response{
    
}

@end
