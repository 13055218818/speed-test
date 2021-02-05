//
//  CSLiveBottomView.m
//  ColorStar
//
//  Created by gavin on 2020/10/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSLiveBottomView.h"
#import <Masonry/Masonry.h>
#import "UIView+CS.h"
#import "CSColorStar.h"
#import "CSIMManager.h"
#import "UIColor+CS.h"
#import "CSLiveChatContainerView.h"
#import "CSLiveClassContainerView.h"
#import "CSLiveRecommendContainerView.h"
#import "CSLiveRankContainerView.h"


typedef NS_ENUM(NSUInteger, CSLiveBottomContainerType) {
    CSLiveBottomContainerChat = 10,//聊天
    CSLiveBottomContainerClass,//课堂
    CSLiveBottomContainerRecommend,//推荐
    CSLiveBottomContainerRank,//排行
};

@interface CSLiveBottomView ()

@property (nonatomic, strong)UIView   * selecteBar;

@property (nonatomic, strong)UIButton * currentBtn;//当前按钮

@property (nonatomic, strong)UIView   * bottomLine;//底部

@property (nonatomic, strong)UIView   * containerView;

@property (nonatomic, strong)CSLiveChatContainerView  * chatView;

@property (nonatomic, strong)CSLiveClassContainerView * classView;

@property (nonatomic, strong)CSLiveRecommendContainerView * recommendView;

@property (nonatomic, strong)CSLiveRankContainerView      * randView;

@end

@implementation CSLiveBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    self.selecteBar = [[UIView alloc]initWithFrame:CGRectZero];
    self.selecteBar.frame = CGRectMake(0, 0, self.width, 40);
    self.selecteBar.backgroundColor = [UIColor blackColor];
    [self addSubview:self.selecteBar];
    
    
    NSArray * btnNames = @[@"聊天",@"课堂",@"推荐",@"排行"];
    NSMutableArray * btns = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < btnNames.count ; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:btnNames[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#3953FA"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        btn.tag = CSLiveBottomContainerChat + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.selecteBar addSubview:btn];
        [btns addObject:btn];
        if (i == 0) {
            self.currentBtn = btn;
            self.currentBtn.selected = YES;
        }
    }
    
    [btns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:10 tailSpacing:10];
    [btns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.selecteBar);
        make.height.mas_equalTo(30);
    }];
    
    
    
    
    self.bottomLine = [[UIView alloc]initWithFrame:CGRectZero];
    self.bottomLine.backgroundColor = [UIColor colorWithHexString:@"#3953FA"];
    [self.selecteBar addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.currentBtn);
        make.bottom.mas_equalTo(self.selecteBar).offset(-2);
        make.size.mas_equalTo(CGSizeMake(30, 2));
    }];
    
    
    
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.selecteBar.bottom, self.width, self.height - self.selecteBar.height)];
    self.containerView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.containerView];

    self.chatView = [[CSLiveChatContainerView alloc]initWithFrame:CGRectMake(0, 0, self.containerView.width, self.containerView.height - kSafeAreaBottomHeight)];
    [self.containerView addSubview:self.chatView];
    
    self.classView = [[CSLiveClassContainerView alloc]initWithFrame:CGRectMake(0, 0, self.containerView.width, self.containerView.height - kSafeAreaBottomHeight)];
    [self.containerView addSubview:self.classView];
    
    self.recommendView = [[CSLiveRecommendContainerView alloc]initWithFrame:CGRectMake(0, 0, self.containerView.width, self.containerView.height - kSafeAreaBottomHeight)];
    [self.containerView addSubview:self.recommendView];
    
    self.randView = [[CSLiveRankContainerView alloc]initWithFrame:CGRectMake(0, 0, self.containerView.width, self.containerView.height - kSafeAreaBottomHeight)];
    [self.containerView addSubview:self.randView];
    
    self.chatView.hidden = NO;
    self.classView.hidden = YES;
    self.recommendView.hidden = YES;
    self.randView.hidden = YES;
    
    
    
    [[CSIMManager sharedManager] initClient];
    [[CSIMManager sharedManager] connect];
//    [[CSIMManager sharedManager] removeAllObserver];
//    [[CSIMManager sharedManager] addIMObserver:self.chatView];
    
}

- (void)setLiveModel:(CSLiveModel *)liveModel{
    _liveModel = liveModel;
    self.chatView.liveModel = _liveModel;
    self.randView.ranklist = _liveModel.live_reward.list;

}

- (void)btnClick:(UIButton*)sender{
    
    
    if (self.currentBtn == sender) {
        return;
    }
    
    CSLiveBottomContainerType selectedType = (CSLiveBottomContainerType)sender.tag;
    self.currentBtn.selected = NO;
    sender.selected = YES;
    self.currentBtn = sender;
    
    self.chatView.hidden = YES;
    self.classView.hidden = YES;
    self.recommendView.hidden = YES;
    self.randView.hidden = YES;
    
    if (selectedType == CSLiveBottomContainerChat) {
        self.chatView.hidden = NO;
    }else if (selectedType == CSLiveBottomContainerClass){
        self.classView.hidden = NO;
    }else if (selectedType == CSLiveBottomContainerRecommend){
        self.recommendView.hidden = NO;
    }else if (selectedType == CSLiveBottomContainerRank){
        self.randView.hidden = NO;
    }
    
    if (self.chatView.hidden) {
        [self.chatView registeKeyBoard];
    }
    
    
    [self.bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.currentBtn);
        make.bottom.mas_equalTo(self.selecteBar).offset(-2);
        make.size.mas_equalTo(CGSizeMake(30, 2));
    }];
    
}






@end
