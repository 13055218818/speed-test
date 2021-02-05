//
//  CSSearchViewController.m
//  ColorStar
//
//  Created by gavin on 2020/8/13.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSSearchViewController.h"
#import "UIView+CS.h"
#import "CSSearchItemView.h"
#import "CSStorgeManager.h"
#import "CSEmptySearchCell.h"
#import "CSColorStar.h"
#import "CSNetworkManager.h"
#import "CSSearchReultModel.h"
#import <YYModel.h>
#import "NSString+CS.h"
#import "CSArtorDetailViewController.h"
#import "CSSearchCourseCell.h"
#import "CSSearchSpecialCell.h"
#import "CSSearchResultTopView.h"
#import "CSSearchManager.h"
#import "CSNewHomeNetManager.h"
#import "CSTutorPlayViewController.h"
#import "CSTutorDetailViewController.h"

NSString  * const CSEmptySearchCellReuseIdentifier = @"CSEmptySearchCellReuseIdentifier";

@interface CSSearchViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UIView      * searchView;

@property (nonatomic, strong)UITextField * searchTextField;

@property (nonatomic, strong)UIButton    * clearBtn;

@property (nonatomic, strong)UIButton    * searchBtn;

@property (nonatomic, strong)CSSearchItemView      * historyView;

@property (nonatomic, strong)CSSearchItemView      * hotSearchView;

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)CSSearchResultTopView * topView;

@property (nonatomic, strong)NSMutableArray * specials;

@property (nonatomic, strong)NSMutableArray * courses;

@property (nonatomic, assign)CSSearchHeaderClickType currentType;

@property (nonatomic, assign)BOOL   loadSpecial;

@property (nonatomic, assign)BOOL   loadCourse;

@property (nonatomic, strong)NSString * currentWords;

@end

@implementation CSSearchViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if (self.firstLoad) {
        [self setupViews];
    }
    self.firstLoad = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstLoad = YES;
    self.view.backgroundColor = LoadColor(@"#181F30");

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledDidChange:) name:UITextFieldTextDidChangeNotification object:self.searchTextField];
}


- (void)setupViews{
    
    [self setupSearchBar];
    [self setupHistoryView];
    [self setupHotView];
    [self setupTableView];
    [self fetchHotwords];
}


- (void)setupSearchBar{
    
    self.searchView = [[UIView alloc]initWithFrame:CGRectZero];
    self.searchView.frame = CGRectMake(0, kStatusBarHeight, self.view.width, 44);
    [self.view addSubview:self.searchView];
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:LoadImage(@"cs_artor_new_back") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.searchView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.searchView);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];
    
    UIView * containerView = [[UIView alloc]initWithFrame:CGRectZero];
    containerView.layer.masksToBounds = YES;
    containerView.layer.cornerRadius = 2;
    containerView.backgroundColor = LoadColor(@"#2E3955");
    [self.searchView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.searchView);
        make.left.mas_equalTo(42);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(-52);
    }];
    
    
    UIImageView * iconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    iconImageView.image = [UIImage imageNamed:@"cs_home_search"];
    iconImageView.frame = CGRectMake(15, 7.5, 15, 15);
    [containerView addSubview:iconImageView];
    
    self.searchTextField = [[UITextField alloc]initWithFrame:CGRectZero];
    self.searchTextField.frame = CGRectMake(iconImageView.right + 5, 5, self.searchView.width - iconImageView.right - 20, 20);
    self.searchTextField.placeholder = csnation(@"搜索你想要的内容吧");
    [self.searchTextField setValue:LoadColor(@"#9B9B9B") forKeyPath:@"placeholderLabel.textColor"];
    [self.searchTextField setValue:kFont(12.0f) forKeyPath:@"placeholderLabel.font"];
    self.searchTextField.font = [UIFont systemFontOfSize:12.0f];
    self.searchTextField.delegate = self;
    self.searchTextField.textColor = [UIColor whiteColor];
    self.searchTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    [containerView addSubview:self.searchTextField];
    
    self.clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.clearBtn setImage:LoadImage(@"CSHomeRecommendInterestingBannerDelete") forState:UIControlStateNormal];
    [self.clearBtn addTarget:self action:@selector(clearClick) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:self.clearBtn];
    self.clearBtn.hidden = YES;
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(containerView);
        make.right.mas_equalTo(containerView).offset(-7);
        make.width.height.mas_equalTo(17);
    }];
    
    
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.searchBtn setTitle:csnation(@"搜索") forState:UIControlStateNormal];
    [self.searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.searchBtn.titleLabel.font = kFont(12.0f);
    [self.searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    [self.searchView addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(containerView);
        make.right.mas_equalTo(self.searchView).offset(-12);
        make.size.mas_equalTo(CGSizeMake(35, 15));
    }];
    
}

- (void)setupHistoryView{
    self.historyView = [[CSSearchItemView alloc]initWithFrame:CGRectMake(0, self.searchView.bottom, self.view.width, 0)];
    self.historyView.title = NSLocalizedString(@"历史搜索", nil);
    self.historyView.showHotIcon = NO;
    self.historyView.list = [[CSStorgeManager sharedManager] getSearchHistoryWords];
    self.historyView.deleteItem = YES;
    CS_Weakify(self, weakSelf);
    self.historyView.searchClick = ^(NSString *text) {
        weakSelf.searchTextField.text = text;
        weakSelf.clearBtn.hidden = NO;
    };
    self.historyView.deleteClick = ^(NSString *text) {
        
    };
    [self.view addSubview:self.historyView];
    
}

- (void)setupHotView{
    
    self.hotSearchView = [[CSSearchItemView alloc]initWithFrame:CGRectMake(0, self.historyView.bottom, self.view.width, 0)];
    self.hotSearchView.title = csnation(@"搜索推荐");
    self.hotSearchView.showHotIcon = YES;
    self.hotSearchView.deleteItem = NO;
    CS_Weakify(self, weakSelf);
    self.hotSearchView.searchClick = ^(NSString *text) {
        weakSelf.searchTextField.text = text;
        weakSelf.clearBtn.hidden = NO;
    };
    
    [self.view addSubview:self.hotSearchView];
}

- (void)setupTableView{
    
    self.tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, self.searchView.bottom, self.view.width, self.view.height - self.searchView.bottom) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.hidden = YES;
    self.tableView.backgroundColor = LoadColor(@"#181F30");
    [self.tableView registerClass:[CSSearchSpecialCell class] forCellReuseIdentifier:[CSSearchSpecialCell reuserIndentifier]];
    [self.tableView registerClass:[CSSearchCourseCell class] forCellReuseIdentifier:[CSSearchCourseCell reuserIndentifier]];
    [self.tableView registerClass:[CSEmptySearchCell class] forCellReuseIdentifier:CSEmptySearchCellReuseIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.topView = [[CSSearchResultTopView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
    self.tableView.tableHeaderView = self.topView;
    
    CS_Weakify(self, weakSelf);
    self.topView.headerClick = ^(CSSearchHeaderClickType clickType) {
        weakSelf.currentType = clickType;
        [weakSelf fetchSearchReult:weakSelf.currentWords type:clickType];
    };
    
}

- (void)fetchHotwords{
    
    CS_Weakify(self, weakSelf);
    [[CSSearchManager shared] fetchHotWordsComplete:^(CSNetResponseModel *response, NSError *error) {
        
        if (!error) {
            if ([response.data isKindOfClass:[NSArray class]]) {
                weakSelf.hotSearchView.list = response.data;
            }
        }
        
    }];
    
}

#pragma mark - Action Method

- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchClick{
    if ([NSString isNilOrEmpty:self.searchTextField.text]) {
        return;
    }
    
    if (!self.currentWords || ![self.currentWords isEqualToString:self.searchTextField.text]) {
        self.currentWords = self.searchTextField.text;
        self.loadCourse = NO;
        self.loadSpecial = NO;
        [self.topView specialClick];
    }
}

- (void)clearClick{
    self.searchTextField.text = nil;
    [self hiddenSearchResult];
}

#pragma mark Private Method

- (void)fetchSearchReult:(NSString*)words type:(CSSearchHeaderClickType)clickType{
    
    NSMutableArray * currentList = nil;
    if (clickType == CSSearchHeaderClickTypeSpecial) {
        if (self.loadSpecial) {
            [self.tableView reloadData];
            return;
        }
        currentList = self.specials;
    }else{
        if (self.loadCourse) {
            [self.tableView reloadData];
            return;
        }
        currentList = self.courses;
    }
    
    [self showProgressHUD];
    [currentList removeAllObjects];
    CS_Weakify(self, weakSelf);
    NSString * type = clickType == CSSearchHeaderClickTypeSpecial ? @"1" : @"2";
    [[CSSearchManager shared] fetchSearchResult:words type:type page:1 limit:100 complete:^(CSNetResponseModel *response, NSError *error) {
        [self hideProgressHUD];
        [[CSStorgeManager sharedManager] storeSearchWords:weakSelf.currentWords];
        weakSelf.historyView.list = [[CSStorgeManager sharedManager] getSearchHistoryWords];
        if ([response.data isKindOfClass:[NSArray class]]) {
            
            NSArray * data = (NSArray*)response.data;
            if (data.count > 0) {
                for (NSDictionary * dict in data) {
                    CSSearchReultModel * model = [CSSearchReultModel yy_modelWithDictionary:dict];
                    [currentList addObject:model];
                }
            }else{
                [csnation(@"没有搜索到相关内容") showAlert];
            }
            
        }
        
        if (clickType == CSSearchHeaderClickTypeSpecial) {
            weakSelf.loadSpecial = YES;
        }else{
            weakSelf.loadCourse = YES;
        }
        [weakSelf showSearchResult];
        [weakSelf.tableView reloadData];
        
    }];
    
}

- (void)followClick:(NSIndexPath*)indexPath{
    
    CSSearchReultModel * model = self.specials[indexPath.row];
    CS_Weakify(self, weakSelf);
    [[CSNewHomeNetManager sharedManager] getHomeaddFollowSuccessId:model.modelId Complete:^(CSNetResponseModel * _Nonnull response) {
        if (response.code == 200) {
            model.is_follow = !model.is_follow;
            [weakSelf reloadCell:indexPath];
        }else{
            [WHToast showMessage:response.msg duration:1.0 finishHandler:nil];
        }
            
        } failureComplete:^(NSError * _Nonnull error) {
            
        }];
    
}

- (void)reloadCell:(NSIndexPath*)indexPath{
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITextFieldDelegate


- (void)textFieldDidEndEditing:(UITextField *)textField{
        
    

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFiledDidChange:(NSNotification*)notification{
    
    self.clearBtn.hidden = [NSString isNilOrEmpty:self.searchTextField.text];
    
    if ([NSString isNilOrEmpty:self.searchTextField.text]) {
        [self hiddenSearchResult];
    }
}

- (void)showSearchResult{
    self.clearBtn.hidden = NO;
    self.tableView.hidden = NO;
    self.historyView.hidden = YES;
    self.hotSearchView.hidden = YES;
}

- (void)hiddenSearchResult{
    self.currentWords = nil;
    self.clearBtn.hidden = YES;
    self.tableView.hidden = YES;
    self.historyView.hidden = NO;
    self.hotSearchView.hidden = NO;
}

#pragma mark - UITableView Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.currentType == CSSearchHeaderClickTypeSpecial) {
        if (self.specials.count > 0) {
            return self.specials.count;
        }
        return 10;
    }else{
        if (self.courses.count > 0) {
            return self.courses.count;
        }
        return 10;
    }
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.currentType == CSSearchHeaderClickTypeSpecial && self.specials.count > 0) {
        
        CSSearchReultModel * model = self.specials[indexPath.row];
        CSSearchSpecialCell * specialCell = [tableView dequeueReusableCellWithIdentifier:[CSSearchSpecialCell reuserIndentifier] forIndexPath:indexPath];
        [specialCell configModel:model];
        CS_Weakify(self, weakSelf);
        specialCell.specialBlock = ^(BOOL follow) {
            [weakSelf followClick:indexPath];
        };
        return specialCell;
        
        
    }else if (self.currentType == CSSearchHeaderClickTypeCourse && self.courses.count > 0){
        
        CSSearchReultModel * model = self.courses[indexPath.row];
        CSSearchCourseCell * courseCell = [tableView dequeueReusableCellWithIdentifier:[CSSearchCourseCell reuserIndentifier] forIndexPath:indexPath];
        [courseCell configModel:model];
        return courseCell;
        
    }
    
    CSEmptySearchCell * emptyCell = [tableView dequeueReusableCellWithIdentifier:CSEmptySearchCellReuseIdentifier forIndexPath:indexPath];
    CS_Weakify(self, weakSelf);
    emptyCell.reSearchBlock = ^{
        weakSelf.historyView.hidden = NO;
        weakSelf.hotSearchView.hidden = NO;
        weakSelf.tableView.hidden = YES;
        weakSelf.searchTextField.text = nil;
        [weakSelf.searchTextField becomeFirstResponder];

    };
    return emptyCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.currentType == CSSearchHeaderClickTypeSpecial && self.specials.count > 0) {
        
        return 120;
    }else if (self.currentType == CSSearchHeaderClickTypeCourse && self.courses.count > 0){
        
        return 120;
    }
    return self.tableView.height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.currentType == CSSearchHeaderClickTypeCourse && self.courses.count > 0) {
        CSSearchReultModel * model = self.courses[indexPath.row];
        CSTutorPlayViewController * playVC = [[CSTutorPlayViewController alloc]init];
        playVC.videoId = model.modelId;
        [self.navigationController pushViewController:playVC animated:YES];
        
        
    }else if (self.currentType == CSSearchHeaderClickTypeSpecial && self.specials.count > 0){
        CSSearchReultModel * model = self.specials[indexPath.row];
        CSTutorDetailViewController * detailVC = [[CSTutorDetailViewController alloc]init];
        detailVC.tutorId = model.modelId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
}

- (NSMutableArray*)specials{
    if (!_specials) {
        _specials = [NSMutableArray arrayWithCapacity:0];
    }
    return _specials;
}

- (NSMutableArray*)courses{
    if (!_courses) {
        _courses = [NSMutableArray arrayWithCapacity:0];
    }
    return _courses;
}

@end
