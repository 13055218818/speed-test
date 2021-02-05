//
//  CSNewShopAllListViewController.m
//  ColorStar
//
//  Created by apple on 2020/11/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewShopAllListViewController.h"
#import "CSNewShopListCell.h"
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"
#import "CSNewShopAllListPageViewController.h"
#import "CSNewShopNetManage.h"

@interface CSNewShopAllListViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate,UITextFieldDelegate>
{
    NSString  *searchStr;
}
@property(nonatomic, strong)UIView          *navView;
@property(nonatomic, strong)UITextField         *searchLabel;
@property (nonatomic, strong)JXCategoryTitleView        *categoryView;
@property (nonatomic, strong)JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong)NSMutableArray      *titles;
@property (nonatomic, strong)NSMutableArray      *titleModels;
@property (nonatomic, strong) NSMutableArray <CSNewShopAllListPageViewController *> *listVCArray;

@end

@implementation CSNewShopAllListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    window.backgroundColor = [UIColor redColor];
   self.titles = [NSMutableArray array];
    self.titleModels = [NSMutableArray array];
    self.listVCArray = [NSMutableArray array];
    [self makeNavUI];
    [self makeTagView];
    [self loadCategoryListData];
}
#pragma mark--UI--
- (void)loadCategoryListData{
    [[CSNewShopNetManage sharedManager] getShopCategopryListSuccessWithLimit:@"" Complete:^(CSNetResponseModel * _Nonnull response) {
        NSArray  *array = response.data;
        if (array.count > 0) {
            [self.titleModels removeAllObjects];
            [self.titles removeAllObjects];
            for (NSDictionary  *dict in array) {
                CSNewShopCategoryModel *model = [CSNewShopCategoryModel yy_modelWithDictionary:dict];
                [self.titleModels addObject:model];
                [self.titles addObject:model.cate_name];
                }
            self.categoryView.titles = self.titles;
            if (self.currentCategoryModel) {
                for (NSInteger i=0; i<self.titleModels.count; i++) {
                    CSNewShopCategoryModel  *model = self.titleModels[i];
                    if ([model.categoryId isEqualToString:self.currentCategoryModel.categoryId]) {
                        self.categoryView.defaultSelectedIndex =i;
                    }
                }
            }
            [self.categoryView reloadData];
        }
    } failureComplete:^(NSError * _Nonnull error) {
        
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
    
    UIView  *labelBgView = [[UIView alloc] init];
    ViewRadius(labelBgView, 17.0*heightScale);
    labelBgView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.2];
    [self.navView addSubview:labelBgView];
    [labelBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.navView.mas_left).offset(55*widthScale);
        make.right.mas_equalTo(self.navView.mas_right).offset(-15*heightScale);
        make.centerY.mas_equalTo(backButton.mas_centerY);
        make.height.mas_offset(34.0*heightScale);
    }];
    
    self.searchLabel = [[UITextField alloc] init];
    //self.searchLabel.text = NSLocalizedString(@"08:10",nil);
    self.searchLabel.placeholder = NSLocalizedString(@"输入搜索关键字", nil);
    [self.searchLabel setValue:[UIColor colorWithWhite:1.0 alpha:0.38] forKeyPath:@"placeholderLabel.textColor"];
    self.searchLabel.font = [UIFont systemFontOfSize:15.0f];
    self.searchLabel.delegate = self;
    self.searchLabel.textColor = [UIColor whiteColor];
    self.searchLabel.clearButtonMode = UITextFieldViewModeAlways;
    self.searchLabel.returnKeyType = UIReturnKeySearch;
    [labelBgView addSubview:self.searchLabel];
    [self.searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(labelBgView.mas_centerY);
        make.right.mas_equalTo(labelBgView.mas_right);
        make.left.mas_equalTo(labelBgView.mas_left).offset(heightScale*15);
    }];
}

- (void)makeTagView{
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_CollectionView delegate:self];
    self.listContainerView.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    self.listContainerView.scrollView.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    [self.view addSubview:self.listContainerView];

 
    self.categoryView = [[JXCategoryTitleView alloc] init];
    //优化关联listContainer，以后后续比如defaultSelectedIndex等属性，才能同步给listContainer
    self.categoryView.contentEdgeInsetLeft = 12;
    self.categoryView.cellSpacing = 30;
    self.categoryView.separatorLineShowEnabled = YES;
    self.categoryView.separatorLineColor = [UIColor colorWithHexString:@"#4D4D4D"];
    self.categoryView.separatorLineSize = CGSizeMake(1/[UIScreen mainScreen].scale, 11*heightScale);
    self.categoryView.listContainer = self.listContainerView;
    self.categoryView.titles = self.titles;
    self.categoryView.defaultSelectedIndex = 0;
    self.categoryView.titleColor = [UIColor colorWithHexString:@"#B3B3B3"];
    self.categoryView.titleSelectedColor = [UIColor colorWithHexString:@"#CBA769"];
    self.categoryView.titleFont = kFont(15);
    self.categoryView.titleSelectedFont = kFont(18);
    self.categoryView.delegate = self;
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorWidth = 20;
    lineView.indicatorColor = [UIColor colorWithHexString:@"#CBA769"];
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
    
}


- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navView.mas_bottom).offset(10*heightScale);
        make.height.mas_offset(30*heightScale);
    }];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.categoryView.mas_bottom).offset(10*heightScale);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}

///**
// 重载数据源：比如从服务器获取新的数据、否则用户对分类进行了排序等
// */
//- (void)reloadData {
//    self.titles = @[@"sdsd",@"22",@"fddasffafds"];;
//
//    //重载之后默认回到0，你也可以指定一个index
//    self.categoryView.defaultSelectedIndex = 0;
//    self.categoryView.titles = self.titles;
//    [self.categoryView reloadData];
//}

#pragma mark - JXCategoryListContainerViewDataSource

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    CSNewShopAllListPageViewController *listVC = [[CSNewShopAllListPageViewController alloc] init];
//    listVC.title = self.titles[index];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    listVC.firstCategoryModel = self.titleModels[index];
    listVC.searchKey = @"";
    listVC.titleStr = self.titles[index];
    [self.listVCArray addObject:listVC];
    return listVC;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
//    for (CSNewShopAllListPageViewController *listVC in self.listVCArray) {
//        if ([listVC.titleStr isEqualToString:self.titles[index]]) {
//            if (![listVC.firstCategoryModel.categoryId isEqualToString:self.curentCategorySelectModel.categoryId]) {
//                listVC.categoryModel = self.curentCategorySelectModel;
//                [listVC loadData];
//            }
//
//        }
//    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (![NSString isNilOrEmpty:textField.text]) {
        [self searchWords:textField.text];

    }
}


- (void)searchWords:(NSString*)words{
    for (CSNewShopAllListPageViewController *listVC in self.listVCArray) {
        if ([listVC.titleStr isEqualToString:self.titles[self.categoryView.selectedIndex]]) {
//                    if ([listVC.firstCategoryModel.categoryId isEqualToString:self.curentCategorySelectModel.categoryId]) {
                listVC.searchKey = words;
                [listVC loadData];
//                    }

        }
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self searchWords:textField.text];
    return YES;
}
@end
