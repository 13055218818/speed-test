//
//  CSCourseViewController.m
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSCourseViewController.h"
#import "CSNetworkManager.h"
#import "CSCourseChirdrenViewController.h"
#import "CSCourseTopCategoryModel.h"
#import <YYModel.h>
#import "UIView+CS.h"
#import "UIColor+CS.h"
#import <Masonry.h>
#import "CSColorStar.h"
#import "NSString+CS.h"
#import "CSCourseCategoryControl.h"
#import "CSEmptyRefreshView.h"
#import "CSSearchViewController.h"



#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RandomColor Color(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))/** 随机色  */

static CGFloat const titleH = 44;/** 文字高度  */

static CGFloat const MaxScale = 1.2;/** 选中文字放大  */




@interface CSCourseViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)UIView * searchBar;

@property (nonatomic, strong)CSEmptyRefreshView  * refreshView;

@property (nonatomic, strong)NSMutableArray * categories;
/** 文字scrollView  */
@property (nonatomic, strong) UIScrollView *titleScrollView;
/** 控制器scrollView  */
@property (nonatomic, strong) UIScrollView *contentScrollView;
/** 标签按钮  */
@property (nonatomic, strong) NSMutableArray *buttons;
/** 选中的按钮  */
@property (nonatomic,strong) UIButton * selectedBtn;
/** 选中的按钮背景图  */
@property (nonatomic,strong) UIImageView * imageBackView;

@property(nonatomic, strong) NSString * selectedCategoryId;

@end

@implementation CSCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"查看", nil);
    self.navigationItem.leftBarButtonItem = nil;
    self.view.backgroundColor = [UIColor blackColor];
    self.firstLoad = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.firstLoad) {
        self.searchBar = [[UIView alloc]initWithFrame:CGRectMake(14, 10, self.view.width - 28, 30)];
        self.searchBar.layer.masksToBounds = YES;
        self.searchBar.layer.cornerRadius = 15;
        self.searchBar.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.12];
        [self.view addSubview:self.searchBar];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectZero];
        label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.font = [UIFont systemFontOfSize:12.0f];
        label.text = NSLocalizedString(@"探索你的演绎之路", nil);
        label.textColor = [UIColor whiteColor];
        [self.searchBar addSubview:label];
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.image = [UIImage imageNamed:@"cs_home_search"];
        [self.searchBar addSubview:imageView];
        self.searchBar.height = 0.01;
        
        CS_Weakify(self, weakSelf);
        [self.searchBar setTapActionWithBlock:^{
            CSSearchViewController * searchVC = [[CSSearchViewController alloc]init];
            [weakSelf.navigationController pushViewController:searchVC animated:YES];
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.searchBar);
        }];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.searchBar);
            make.right.mas_equalTo(label.mas_left).offset(-8);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        
        self.refreshView = [[CSEmptyRefreshView alloc]initWithFrame:CGRectMake(0, self.searchBar.bottom, self.view.width, self.view.height - self.searchBar.bottom)];
        [self.view addSubview:self.refreshView];
           
        self.refreshView.refreshBlock = ^{
            [weakSelf loadTopLevelCategories];
        };
        self.refreshView.hidden = YES;
        
        [self loadTopLevelCategories];
    }
    self.firstLoad = NO;
}

- (void)loadTopLevelCategories{
    
    self.refreshView.hidden = YES;
    [[CSNetworkManager sharedManager] getTopLevelCategoriesSuccessComplete:^(CSNetResponseModel *response) {
        [self reloadData:response];
        
    } failureComplete:^(NSError *error) {
        self.refreshView.hidden = NO;
    }];
    
    
}

- (void)reloadData:(CSNetResponseModel*)data{
    
    NSArray * list = (NSArray*)data.data;
    [self.categories removeAllObjects];
    for (NSDictionary * dict in list) {
        CSCourseTopCategoryModel * model = [CSCourseTopCategoryModel yy_modelWithDictionary:dict];
        [self.categories addObject:model];
    }
    [self setupViews];

}

- (void)setupViews{
    
    [self addChildViewController];    /** 添加子控制器视图  */
    
    [self setTitleScrollView];        /** 添加文字标签  */
    
    [self setContentScrollView];      /** 添加scrollView  */
    
    [self setupTitle];                /** 设置标签按钮 文字 背景图  */
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.contentScrollView.contentSize = CGSizeMake(self.categories.count * ScreenW, 0);
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator  = NO;
    self.contentScrollView.delegate = self;
    
}

#pragma mark - PRIVATE

-(void)addChildViewController{

    for (int i = 0; i<self.categories.count; i++) {
        CSCourseChirdrenViewController *vc  = [[CSCourseChirdrenViewController alloc] initWithCategoryModel:self.categories[i]];
        [self addChildViewController:vc];

    }

}
-(void)setTitleScrollView{

    CGRect rect  = CGRectMake(0, 0, ScreenW, titleH);
    self.titleScrollView = [[UIScrollView alloc] initWithFrame:rect];
    self.titleScrollView.backgroundColor = [UIColor colorWithHexString:@"#121212"];
    [self.view addSubview:self.titleScrollView];


}
-(void)setContentScrollView{

    CGFloat y  = CGRectGetMaxY(self.titleScrollView.frame);
    CGRect rect  = CGRectMake(0, y, ScreenW, ScreenH - titleH);
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:rect];
    [self.view addSubview:self.contentScrollView];
    

}

-(void)setupTitle{
    NSUInteger count = self.categories.count;
    
    CGFloat x = 0;
    CGFloat w = 80;
    CGFloat h = titleH;
    
    self.titleScrollView.contentSize = CGSizeMake(count * w, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    for (int i = 0; i < count; i++){
        
        CSCourseTopCategoryModel * model = self.categories[i];
        
        x = i * w;
        CGRect rect = CGRectMake(x, 0, w, h);
        UIButton *btn = [[UIButton alloc] initWithFrame:rect];
        
        btn.tag = i;
        [btn setTitle:model.name forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.4] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        

        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        
        [self.buttons addObject:btn];
        [self.titleScrollView addSubview:btn];
        

        if (![NSString isNilOrEmpty:self.selectedCategoryId]) {
            
            if ([self.selectedCategoryId isEqualToString:model.categoryId]) {
                [self click:btn];
            }
        }else{
            if (i == 0){
                [self click:btn];
            }
        }
        
    }
    self.imageBackView  = [[UIImageView alloc] initWithFrame:CGRectMake(22, titleH - 1, 36, 1)];
    self.imageBackView.backgroundColor = [UIColor colorWithHexString:@"#344BDC"];
    self.imageBackView.userInteractionEnabled = YES;
    [self.titleScrollView addSubview:self.imageBackView];
    
    

}
-(void)click:(UIButton *)sender{
    
    [self selectTitleBtn:sender];
    NSInteger i = sender.tag;
    CGFloat x  = i *ScreenW;
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    
    [self setUpOneChildController:i];


}

-(void)selectTitleBtn:(UIButton *)btn{


    [self.selectedBtn setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.4] forState:UIControlStateNormal];
    self.selectedBtn.transform = CGAffineTransformIdentity;
    

    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.transform = CGAffineTransformMakeScale(MaxScale, MaxScale);
    self.selectedBtn = btn;

    [self setupTitleCenter:btn];

}

-(void)setupTitleCenter:(UIButton *)sender
{

    CGFloat offset = sender.center.x - ScreenW * 0.5;
    if (offset < 0) {
        offset = 0;
    }
    CGFloat maxOffset  = self.titleScrollView.contentSize.width - ScreenW;
    if (offset > maxOffset) {
        offset = maxOffset;
    }
    [self.titleScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];

}

-(void)setUpOneChildController:(NSInteger)index{


    CGFloat x  = index * ScreenW;
    UIViewController *vc  =  self.childViewControllers[index];
    if (vc.view.superview) {
        return;
    }
    vc.view.frame = CGRectMake(x, 0, self.view.width, self.view.height - self.contentScrollView.frame.origin.y);
    [self.contentScrollView addSubview:vc.view];

}


#pragma mark - Public Method

- (void)selecteCategoryId:(NSString*)categoryId{
    if (self.categories.count > 0) {
        for (int i = 0; i < self.categories.count; i++) {
            CSCourseTopCategoryModel * model = self.categories[i];
            if ([model.categoryId isEqualToString:categoryId]) {
                UIButton * btn = self.buttons[i];
                [self click:btn];
                break;
            }
        }
        
    }else{
        self.selectedCategoryId = categoryId;
    }
}

#pragma mark - UIScrollView  delegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    NSInteger i  = self.contentScrollView.contentOffset.x / ScreenW;
    [self selectTitleBtn:self.buttons[i]];
    [self setUpOneChildController:i];

}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat offsetX  = scrollView.contentOffset.x;
    NSInteger leftIndex  = offsetX / ScreenW;
    NSInteger rightIdex  = leftIndex + 1;
    
    UIButton *leftButton = self.buttons[leftIndex];
    UIButton *rightButton  = nil;
    if (rightIdex < self.buttons.count) {
        rightButton  = self.buttons[rightIdex];
    }
    CGFloat scaleR  = offsetX / ScreenW - leftIndex;
    CGFloat scaleL  = 1 - scaleR;
    CGFloat transScale = MaxScale - 1;

    self.imageBackView.transform  = CGAffineTransformMakeTranslation((offsetX*(self.titleScrollView.contentSize.width / self.contentScrollView.contentSize.width)), 0);
    
    leftButton.transform = CGAffineTransformMakeScale(scaleL * transScale + 1, scaleL * transScale + 1);
    rightButton.transform = CGAffineTransformMakeScale(scaleR * transScale + 1, scaleR * transScale + 1);
    
    UIColor *rightColor = [UIColor colorWithRed:(174+66*scaleR)/255.0 green:(174-71*scaleR)/255.0 blue:(174-174*scaleR)/255.0 alpha:1];
    UIColor *leftColor = [UIColor colorWithRed:(174+66*scaleL)/255.0 green:(174-71*scaleL)/255.0 blue:(174-174*scaleL)/255.0 alpha:1];
    
//    [leftButton setTitleColor:leftColor forState:UIControlStateNormal];
//    [rightButton setTitleColor:rightColor forState:UIControlStateNormal];

}


#pragma mark - Properties Method

- (NSMutableArray *)buttons{
    if (!_buttons)
    {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (NSMutableArray*)categories{
    if (!_categories) {
        _categories = [NSMutableArray arrayWithCapacity:0];
    }
    return _categories;
}

- (CSEmptyRefreshView*)refreshView{
    if (!_refreshView) {
        _refreshView = [[CSEmptyRefreshView alloc]initWithFrame:CGRectZero];
    }
    return _refreshView;
}


@end
