//
//  CSCourseChirdrenViewController.m
//  ColorStar
//
//  Created by gavin on 2020/8/7.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSCourseChirdrenViewController.h"
#import "CSNetworkManager.h"
#import "CSCourseSecondLevelCategoryModel.h"
#import "UIColor+CS.h"
#import "UIView+CS.h"
#import "NSString+CS.h"
#import <Masonry.h>
#import <YYModel.h>
#import "CSColorStar.h"
#import "CSCourseTopicTableCell.h"
#import "CSEmptyDataCell.h"
#import "CSCourseTopicModel.h"
#import "CSCourseCategoryControl.h"
#import "CSArtorDetailViewController.h"

NSString * const CSCourseTopicTableCellReuseIdentifier = @"CSCourseTopicTableCellReuseIdentifier";
NSString * const CSEmptyDataCellReuseIdentifier = @"CSEmptyDataCellReuseIdentifier";

@interface CSCourseChirdrenViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)CSCourseTopCategoryModel  * categoryModel;

@property (nonatomic, strong)UIView * containerView;

@property (nonatomic, strong)NSMutableArray * subCategories;

@property (nonatomic, strong)UIScrollView  * titleScrollView;

@property (nonatomic, strong)UITableView   * tableView;

@property (nonatomic, strong)CSCourseCategoryControl      * selectedBtn;

@property (nonatomic, strong)NSMutableDictionary   * topicList;

@property (nonatomic, strong)CSCourseSecondLevelCategoryModel * currentSubCategoryModel;

@property (nonatomic, strong)NSMutableDictionary  * pageList;


@end

@implementation CSCourseChirdrenViewController

- (instancetype)initWithCategoryModel:(CSCourseTopCategoryModel*)model{
    if (self = [super init]) {
        _categoryModel = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    self.firstLoad = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.firstLoad) {
        [self.view addSubview:self.containerView];
        self.containerView.frame = CGRectMake(0, 10, self.view.width, self.view.height - 10);
        [self loadData];
    }
    self.firstLoad = NO;
    
}

- (void)loadData{
    
    [[CSNetworkManager sharedManager] getSecondLevelCategoriesWithCategoryId:self.categoryModel.categoryId successComplete:^(CSNetResponseModel *response) {
        
        [self reloadData:response];
        
    } failureComplete:^(NSError *error) {
        
    }];
}

- (void)reloadData:(CSNetResponseModel*)model{
    NSArray * data = (NSArray*)model.data;
    [self.subCategories removeAllObjects];
    if (data.count > 0) {
        for (NSDictionary * dict in data) {
            CSCourseSecondLevelCategoryModel * model = [CSCourseSecondLevelCategoryModel yy_modelWithDictionary:dict];
            [self.subCategories addObject:model];
            
        }
    }
    if (self.subCategories.count > 0) {
        [self setupTitleScrollView];
    }
    
    
}

- (void)setupTitleScrollView{
    
    self.titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.containerView.width, 75)];
    [self.containerView addSubview:self.titleScrollView];
    
    CGFloat leftMargin = 0;
    CGFloat top = 15;
    CSCourseCategoryControl * firstBtn;
    for (int i = 0; i < self.subCategories.count; i++) {
        CSCourseSecondLevelCategoryModel * model = self.subCategories[i];
        NSString * title = model.name;
//        CGSize  size = [title textSizeWithHeight:12.0f withFont:[UIFont systemFontOfSize:12.0f]];
//        CGFloat width = MAX(size.width, 30);
        CSCourseCategoryControl * btn = [[CSCourseCategoryControl alloc]initWithFrame:CGRectMake(leftMargin, top, 76, 60)];
        btn.title = title;
        btn.titleColor = [UIColor colorWithWhite:1.0 alpha:0.38];
        btn.font = [UIFont systemFontOfSize:15.0f];
        btn.imageURL = model.pic;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 15;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        btn.tag = i;
        leftMargin = btn.right + 12;
        [self.titleScrollView addSubview:btn];
        if (i == 0) {
            firstBtn = btn;
        }
    }
    CGFloat contentWidth = MAX(ScreenW, leftMargin);
    self.titleScrollView.contentSize = CGSizeMake(contentWidth, 0);
    
    if (firstBtn) {
        [self click:firstBtn];
    }
}

- (void)setupTableView{
    self.tableView.frame = CGRectMake(0, self.titleScrollView.bottom + 10, self.view.width, self.containerView.height - self.titleScrollView.bottom - 10);
    [self.tableView registerClass:[CSCourseTopicTableCell class] forCellReuseIdentifier:CSCourseTopicTableCellReuseIdentifier];
    [self.tableView registerClass:[CSEmptyDataCell class] forCellReuseIdentifier:CSEmptyDataCellReuseIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    [self.containerView addSubview:self.tableView];
    
}

#pragma mark - Click Method

- (void)click:(CSCourseCategoryControl*)sender{
    
    self.selectedBtn.titleColor = [UIColor colorWithWhite:1.0 alpha:0.38];
    

    sender.titleColor = [UIColor whiteColor];
    self.selectedBtn = sender;
    
    CGFloat offset = sender.center.x - ScreenW * 0.5;
    if (offset < 0) {
        offset = 0;
    }
    CGFloat maxOffset  = self.titleScrollView.contentSize.width - ScreenW;
    if (offset > maxOffset) {
        offset = maxOffset;
    }
    [self.titleScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
    
    self.currentSubCategoryModel = self.subCategories[sender.tag];
    
    [self loadTopicListWithRefresh:YES];
    
    
}


- (void)loadTopicListWithRefresh:(BOOL)refresh{
    if (refresh) {
        NSMutableArray * tableList = [self.topicList valueForKey:self.currentSubCategoryModel.subCategoryId];
        if (tableList) {
            [self.tableView reloadData];
            return;
        }
    }
    NSInteger page = [[self.pageList valueForKey:self.currentSubCategoryModel.subCategoryId] integerValue];
    if (refresh) {
        page = 1;
    }
    
    [[CSNetworkManager sharedManager] getTopicListWithCategoryId:self.currentSubCategoryModel.subCategoryId page:page successComplete:^(CSNetResponseModel *response) {
        [self reloadTabel:response];
        
    } failureComplete:^(NSError *error) {
        [self reloadTabel:nil];
    }];
}

- (void)reloadTabel:(CSNetResponseModel*)response{
    
    NSArray * list = (NSArray*)response.data;
    NSMutableArray * tableList = [self.topicList valueForKey:self.currentSubCategoryModel.subCategoryId];
    if (!tableList) {
        tableList = [NSMutableArray arrayWithCapacity:0];
    }
    for (NSDictionary * dict in list) {
        CSCourseTopicModel * topiModel = [CSCourseTopicModel yy_modelWithDictionary:dict];
        [tableList addObject:topiModel];
    }
    [self.topicList setValue:tableList forKey:self.currentSubCategoryModel.subCategoryId];
    if (!self.tableView.superview) {
        [self setupTableView];
    }
    [self.tableView reloadData];
}

#pragma mark - UITableView Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray * tableList = [self.topicList valueForKey:self.currentSubCategoryModel.subCategoryId];
    if (tableList.count > 0) {
        return tableList.count;
    }
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     NSMutableArray * tableList = [self.topicList valueForKey:self.currentSubCategoryModel.subCategoryId];
    if (tableList.count > 0) {
        CSCourseTopicTableCell * cell = [tableView dequeueReusableCellWithIdentifier:CSCourseTopicTableCellReuseIdentifier forIndexPath:indexPath];
        NSMutableArray * tableList = [self.topicList valueForKey:self.currentSubCategoryModel.subCategoryId];
        [cell configModel:tableList[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        CSEmptyDataCell * emptyCell = [tableView dequeueReusableCellWithIdentifier:CSEmptyDataCellReuseIdentifier forIndexPath:indexPath];
        return emptyCell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray * tableList = [self.topicList valueForKey:self.currentSubCategoryModel.subCategoryId];
    if (tableList.count > 0) {
        return 120;
    }else{
        return self.tableView.height;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray * tableList = [self.topicList valueForKey:self.currentSubCategoryModel.subCategoryId];
    CSCourseTopicModel * model = tableList[indexPath.row];
    
    CSArtorDetailViewController * artorVC = [[CSArtorDetailViewController alloc]init];
    artorVC.artorId = model.topicId;
    artorVC.artorName = model.title;
    [self.parentViewController.navigationController pushViewController:artorVC animated:YES];
}

#pragma mark Properties Method

- (NSMutableArray*)subCategories{
    if (!_subCategories) {
        _subCategories = [NSMutableArray arrayWithCapacity:0];
    }
    return _subCategories;
}

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
        _containerView.backgroundColor = [UIColor colorWithHexString:@"#121212"];
    }
    return _containerView;
}

- (NSMutableDictionary*)topicList{
    if (!_topicList) {
        _topicList = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _topicList;
}

- (NSMutableDictionary*)pageList{
    if (!_pageList) {
        _pageList = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _pageList;
}

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#121212"];
    }
    return _tableView;
    
}

@end
