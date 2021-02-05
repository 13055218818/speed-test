//
//  CSHomeMoreViewController.m
//  ColorStar
//
//  Created by gavin on 2020/9/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeMoreViewController.h"
#import "SDCycleScrollView.h"

@interface CSHomeMoreViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong)SDCycleScrollView  * cycleView;

@property (nonatomic, strong)UIView   * categoriesView;

@property (nonatomic, strong)UICollectionView   * collectionView;

//@property (nonatomic, strong)NSString *

@end

@implementation CSHomeMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstLoad = YES;
    self.title = self.sectionModel.title;
    
}

- (void)viewWillAppear:(BOOL)animated{
    if (self.firstLoad) {
        [self loadData];
    }
    self.firstLoad = YES;
}


- (void)loadData{
    
}


- (void)setupViews{
    
    self.cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"cs_home_banner"]];
    [self.view addSubview:self.cycleView];
    
    self.categoriesView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.categoriesView];
    
    
    
    
}

#pragma mark - SDCycleScrollViewDelegate Method




@end
