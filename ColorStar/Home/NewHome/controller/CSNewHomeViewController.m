//
//  CSNewHomeViewController.m
//  ColorStar
//
//  Created by apple on 2020/11/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewHomeViewController.h"
#import "CSNewHomeFindView.h"
#import "CSNewHomeRecommendView.h"
#import "CSNewHomeLiveView.h"
#import "CSCalendarViewController.h"
#import "CSSearchViewController.h"
#import "CSAPPUpdateView.h"
//#import "CSNewLoginVersionModel.h"
@interface CSNewHomeViewController ()<UIScrollViewDelegate>
@property(nonatomic, strong)UIView          *navView;
@property(nonatomic, strong)UIView          *titleView;
@property(nonatomic, strong)UILabel         *findLabel;
@property(nonatomic, strong)UILabel         *recommendLabel;
@property(nonatomic, strong)UILabel         *liveLabel;
@property(nonatomic, strong)UIImageView     *titleLineView;
@property(nonatomic, strong)UIScrollView    *mainScrollerView;

@property(nonatomic, strong)UIView          *findView;
@property(nonatomic, strong)UIView          *recommendView;
@property(nonatomic, strong)UIView          *liveView;
@end

@implementation CSNewHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    [self makeNavUI];
    [self makeTitleView];
    if ([[CSNewLoginUserInfoManager sharedManager] currentAppVersionInfo].ios_hide) {
        self.liveLabel.hidden = YES;
    }else{
        self.liveLabel.hidden = NO;
    }
    [self makeScrollerView];
    CSNewLoginVersionModel *model = [CSNewLoginUserInfoManager sharedManager].currentAppVersionInfo;
    if (model.is_needUpdate) {
        [self updateAPPWithURL:model];
    }

}

- (void)updateAPPWithURL:(CSNewLoginVersionModel*)model{
    NSString * downURL = @"https://apps.apple.com/us/app/colorworld/id1529123508?uo=4";
    NSURL * down = [NSURL URLWithString:downURL];
   
    UIWindow  *window = [UIApplication sharedApplication].keyWindow;
    CSAPPUpdateView * updateView = [[CSAPPUpdateView alloc]initWithFrame:window.bounds updateNote:model.version_content];
    updateView.downURL = down;
    updateView.isUpdate = model.is_update;
    [window addSubview:updateView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
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
    
    UIButton  *calecdarButton = [[UIButton alloc] init];
    [calecdarButton setImage:[UIImage imageNamed:@"CS_home_topCalendar.png"] forState:UIControlStateNormal];
    [calecdarButton addTarget:self action:@selector(calecdarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:calecdarButton];
    [calecdarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(@(heightScale *26));
        make.left.mas_equalTo(self.navView.mas_left).offset(heightScale*12);
        make.bottom.mas_equalTo(self.navView.mas_bottom).offset(-heightScale *8);
    }];
    
    
    UIButton  *searchButton = [[UIButton alloc] init];
    [searchButton setImage:[UIImage imageNamed:@"CS_home_topSearch.png"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:searchButton];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(@(heightScale *26));
        make.right.mas_equalTo(self.navView.mas_right).offset(-heightScale*12);
//        make.bottom.mas_equalTo(self.navView.mas_bottom).offset(-heightScale *8);
        make.centerY.mas_equalTo(calecdarButton.mas_centerY);
    }];
}

- (void)makeTitleView{
    self.titleView = [[UIView alloc] init];
    self.titleView.backgroundColor =[UIColor colorWithHexString:@"#181F30"];
    [self.navView addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.navView.mas_left).offset(widthScale *40);
        make.right.mas_equalTo(self.navView.mas_right).offset(-widthScale *40);
        make.height.mas_offset(@(heightScale *44));
        make.bottom.mas_equalTo(self.navView.mas_bottom);
    }];
    self.recommendLabel = [[UILabel alloc] init];
    self.recommendLabel.text = NSLocalizedString(@"推荐",nil);
    self.recommendLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"about"]];
    self.recommendLabel.font = kFont(19);
    // self.recommendLabel.textColor = [UIColor whiteColor];
    self.recommendLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleView addSubview:self.recommendLabel];
    [self.recommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.titleView.mas_centerX);
        make.centerY.mas_equalTo(self.titleView.mas_centerY);
    }];
    
    self.findLabel = [[UILabel alloc] init];
    self.findLabel.text = NSLocalizedString(@"发现",nil);
    self.findLabel.font = kFont(19);
    self.findLabel.textColor = [UIColor whiteColor];
    self.findLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleView addSubview:self.findLabel ];
    [self.findLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.recommendLabel.mas_left).offset(-widthScale*22);
        make.centerY.mas_equalTo(self.titleView.mas_centerY);
    }];
    
    
    self.liveLabel= [[UILabel alloc] init];
    self.liveLabel.text = NSLocalizedString(@"直播",nil);
    self.liveLabel.font = kFont(19);
    self.liveLabel.textColor = [UIColor whiteColor];
    self.liveLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.titleView addSubview:self.liveLabel];
    [self.liveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.recommendLabel.mas_right).offset(widthScale*22);
        make.centerY.mas_equalTo(self.titleView.mas_centerY);
    }];
    
    self.titleLineView = [[UIImageView alloc] init];
    self.titleLineView.image = [UIImage imageNamed:@"about"];
    [self.titleView addSubview:self.titleLineView];
    
    [self.view layoutIfNeeded];
    self.titleLineView.frame = CGRectMake(self.recommendLabel.origin.x + (self.recommendLabel.width-27*widthScale)/2, 42*heightScale, 27*widthScale, 2*heightScale);
    self.liveLabel.userInteractionEnabled = YES;
    self.recommendLabel.userInteractionEnabled = YES;
    self.findLabel.userInteractionEnabled = YES;
    CS_Weakify(self, weakSelf);
    [weakSelf.liveLabel setTapActionWithBlock:^{
        self.titleLineView.frame = CGRectMake(self.liveLabel.origin.x + (self.liveLabel.width-27*widthScale)/2, 42*heightScale, 27*widthScale, 4*heightScale);
        self.liveLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"about"]];
        self.liveLabel.font = kFont(19);
        
        self.findLabel.textColor = self.recommendLabel.textColor = [UIColor whiteColor];
        self.findLabel.font = self.recommendLabel.font = kFont(19);
        self.mainScrollerView.contentOffset = CGPointMake(2*ScreenW, 0);
    }];
    [weakSelf.recommendLabel setTapActionWithBlock:^{
        self.titleLineView.frame = CGRectMake(self.recommendLabel.origin.x + (self.recommendLabel.width-27*widthScale)/2, 42*heightScale, 27*widthScale, 2*heightScale);
        self.recommendLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"about"]];
        self.recommendLabel.font = kFont(19);
        
        self.findLabel.textColor = self.liveLabel.textColor = [UIColor whiteColor];
        self.findLabel.font = self.liveLabel.font = kFont(19);
        self.mainScrollerView.contentOffset = CGPointMake(ScreenW, 0);
    }];
    [weakSelf.findLabel setTapActionWithBlock:^{
        self.titleLineView.frame = CGRectMake(self.findLabel.origin.x + (self.findLabel.width-27*widthScale)/2, 42*heightScale, 27*widthScale, 2*heightScale);
        self.findLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"about"]];
        self.findLabel.font = kFont(19);
        
        self.recommendLabel.textColor = self.liveLabel.textColor = [UIColor whiteColor];
        self.recommendLabel.font = self.liveLabel.font = kFont(19);
        self.mainScrollerView.contentOffset = CGPointMake(0, 0);
    }];
    
    
}

- (void)makeScrollerView{
    self.mainScrollerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight +44*heightScale ,ScreenW,ScreenH-kStatusBarHeight-44*heightScale -kTabBarHeight)];
    self.mainScrollerView.showsHorizontalScrollIndicator=NO;
    self.mainScrollerView.showsVerticalScrollIndicator=NO;
    self.mainScrollerView.scrollEnabled=YES;
    self.mainScrollerView.pagingEnabled = YES;
    self.mainScrollerView.delegate = self;
    self.mainScrollerView.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
   
    [self.view addSubview:self.mainScrollerView];
    self.mainScrollerView.contentOffset = CGPointMake(ScreenW, 0);
    
    self.findView = [[CSNewHomeFindView alloc] initWithFrame:CGRectMake(0,0,ScreenW,ScreenH-kStatusBarHeight-44*heightScale -kTabBarHeight)];
    [self.mainScrollerView addSubview:self.findView];
    self.recommendView = [[CSNewHomeRecommendView alloc] initWithFrame:CGRectMake(ScreenW,0,ScreenW,ScreenH-kStatusBarHeight-44*heightScale -kTabBarHeight)];
    [self.mainScrollerView addSubview:self.recommendView];
    if (![[CSNewLoginUserInfoManager sharedManager] currentAppVersionInfo].ios_hide) {
        self.liveView = [[CSNewHomeLiveView alloc] initWithFrame:CGRectMake(ScreenW * 2,0,ScreenW,ScreenH-kStatusBarHeight-44*heightScale -kTabBarHeight)];
        [self.mainScrollerView addSubview:self.liveView];
        self.mainScrollerView.contentSize=CGSizeMake(ScreenW *3,ScreenH-kStatusBarHeight-44*heightScale -kTabBarHeight);
    }else{
        self.mainScrollerView.contentSize=CGSizeMake(ScreenW *2,ScreenH-kStatusBarHeight-44*heightScale -kTabBarHeight);
    }
    
}

#pragma mark--ButtonAction--
-(void)calecdarButtonClick:(UIButton *)btn{
    CSCalendarViewController * calendarVC = [[CSCalendarViewController alloc]init];
    [self.navigationController pushViewController:calendarVC animated:YES];
}

-(void)searchButtonClick:(UIButton *)btn{
    CSSearchViewController * searchVC = [[CSSearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark-mainScrollerDelegete--
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.mainScrollerView) {
        NSInteger index = self.mainScrollerView.contentOffset.x/ScreenW;
        switch (index) {
            case 0:
            {
                self.titleLineView.frame = CGRectMake(self.findLabel.origin.x + (self.findLabel.width-27*widthScale)/2, 42*heightScale, 27*widthScale, 2*heightScale);
                self.findLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"about"]];
                self.findLabel.font = kFont(19);
                
                self.recommendLabel.textColor = self.liveLabel.textColor = [UIColor whiteColor];
                self.recommendLabel.font = self.liveLabel.font = kFont(19);
            }
                break;
                
            case 1:
            {
                self.titleLineView.frame = CGRectMake(self.recommendLabel.origin.x + (self.recommendLabel.width-27*widthScale)/2, 42*heightScale, 27*widthScale, 2*heightScale);
                self.recommendLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"about"]];
                self.recommendLabel.font = kFont(19);
                
                self.findLabel.textColor = self.liveLabel.textColor = [UIColor whiteColor];
                self.findLabel.font = self.liveLabel.font = kFont(19);
            }
                break;
                
            case 2:
            {
               
                if (![[CSNewLoginUserInfoManager sharedManager] currentAppVersionInfo].ios_hide){
                self.titleLineView.frame = CGRectMake(self.liveLabel.origin.x + (self.liveLabel.width-27*widthScale)/2, 42*heightScale, 27*widthScale, 2*heightScale);
                self.liveLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"about"]];
                self.liveLabel.font = kFont(19);
                
                self.findLabel.textColor = self.recommendLabel.textColor = [UIColor whiteColor];
                self.findLabel.font = self.recommendLabel.font = kFont(19);
                }
            }
                break;
                
            default:
                break;
        }
    }
    
    
}
@end
