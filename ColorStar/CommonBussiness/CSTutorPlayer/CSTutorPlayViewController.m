//
//  CSVideoPlayViewController.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorPlayViewController.h"
#import "CSTutorPlayKeyBoardView.h"
#import "CSTutorVideoDetailCell.h"
#import "CSTutorVideoBriefCell.h"
#import "CSTutorCourseTitleCell.h"
#import "CSTutorCourseCell.h"
#import "CSTutorCommentTitleCell.h"
#import "CSTutorNewestCommentCell.h"
#import "CSTutorLiveViewController.h"
#import "CSTutorVideoPlayManager.h"
#import "CSTutorVideoModel.h"
#import "CSTutorCommentModel.h"
#import "CSKeyBoardInputView.h"
#import "CSVideoPlayeRechargeAlertView.h"

#import "CSTutorPlayerContainerView.h"
#import "CSTutorCustomControlView.h"
#import "AppDelegate.h"
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/ZFIJKPlayerManager.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import "CSVideoUnopenAlertView.h"
#import "FXBlurView.h"
#import "UIImage+ImageEffects.h"
#import "CSShareManager.h"

static NSString *kVideoCover = @"https://upload-images.jianshu.io/upload_images/635942-14593722fe3f0695.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";

const CGFloat keyboardHeight = 56.0f;

@interface CSTutorPlayViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)CSTutorPlayerContainerView * containerView;
@property (nonatomic, strong)ZFPlayerController *player;
@property (nonatomic, strong)CSTutorCustomControlView  * controlView;


@property (nonatomic, strong)UITableView  * tableView;

@property (nonatomic, strong)CSTutorPlayKeyBoardView  * keyboardView;

@property (nonatomic, strong)CSTutorVideoModel  * model;

@property (nonatomic, strong)CSKeyBoardInputView  * inputView;

@property (nonatomic, strong)CSTutorCommentModel  * commentModel;

@property (nonatomic, strong)NSMutableArray       * discussList;

@property (nonatomic, assign)NSInteger              currentPage;

@property (nonatomic, assign)CGFloat               brigfHeight;

@property (nonatomic, assign)BOOL                  brigfIsOpen;
@end

@implementation CSTutorPlayViewController

#pragma mark - Life Cycle

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat x = 0;
    CGFloat y = kStatusBarHeight;
    CGFloat w = CGRectGetWidth(self.view.frame);
    CGFloat h = w*9/16;
    self.containerView.frame = CGRectMake(x, y, w, h);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.player.viewControllerDisappear = NO;

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.player.viewControllerDisappear = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    self.brigfIsOpen = NO;
    self.brigfHeight = 126;
    [self setupPlayer];
    [self setupViews];
    [self fetchVideoInfo:YES];
}


#pragma mark - init Method

- (void)setupPlayer{
    
    @zf_weakify(self)
    self.containerView.containerBlock = ^(CSTutorPlayerContainerBlockType type) {
        if (type == CSTutorPlayerContainerBlockTypeBack) {
            [weak_self.navigationController popViewControllerAnimated:YES];
        }else if (type == CSTutorPlayerContainerBlockTypeRecharge){
            [weak_self showRechargeAlertView];
        }else if (type == CSTutorPlayerContainerBlockTypeVip){
            [weak_self rechargeForVip];
        }
    };
    [self.view addSubview:self.containerView];
   
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    /// 播放器相关
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.containerView];
    self.player.controlView = self.controlView;
    /// 设置退到后台继续播放
    self.player.pauseWhenAppResignActive = NO;
//    self.player.viewControllerDisappear
    
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        ((AppDelegate*)[UIApplication sharedApplication].delegate).allowOrentitaionRotation = isFullScreen;
    };
    
    /// 播放完成
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @zf_strongify(self)
        [self.player.currentPlayerManager replay];
        
    };
    self.player.currentPlayerManager.shouldAutoPlay = NO;
    self.player.playerReadyToPlay = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, NSURL * _Nonnull assetURL) {
        @zf_strongify(self)
        if ([[UIViewController currentViewController] isEqual:self]) {
            [self.player.currentPlayerManager play];
        }else{
            [self.player.currentPlayerManager pause];
        }
    };
    
    self.player.playerPlayTimeChanged = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, NSTimeInterval currentTime, NSTimeInterval duration) {
        @zf_strongify(self)
        if ([CSNewLoginUserInfoManager sharedManager].currentAppVersionInfo.ios_hide) {//是否审核
                return;
        }
        if (self.model.taskInfo.free_time > 0) {
            if (currentTime > self.model.taskInfo.free_time) {
                if ([self needPayForVideo]) {
                    [self.player stop];
                    [self showVideoPriceView];
                }
            }
        }
    };
    
    
//    playerManager.assetURL = [NSURL URLWithString:@"https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h.mp4"];
}

- (void)setupViews{
    
    CS_Weakify(self, weakSelf);
    
    CGFloat playViewHeight = ScreenW*(9/16.0);
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, playViewHeight + kStatusBarHeight, self.view.width, self.view.height - (playViewHeight + kStatusBarHeight) - kSafeAreaBottomHeight - keyboardHeight) style:UITableViewStylePlain];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = LoadColor(@"#213D53");
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[CSTutorVideoDetailCell class] forCellReuseIdentifier:[CSTutorVideoDetailCell reuserIndentifier]];
    [self.tableView registerClass:[CSTutorVideoBriefCell class] forCellReuseIdentifier:[CSTutorVideoBriefCell reuserIndentifier]];
    [self.tableView registerClass:[CSTutorCourseTitleCell class] forCellReuseIdentifier:[CSTutorCourseTitleCell reuserIndentifier]];
    [self.tableView registerClass:[CSTutorCourseCell class] forCellReuseIdentifier:[CSTutorCourseCell reuserIndentifier]];
    [self.tableView registerClass:[CSTutorCommentTitleCell class] forCellReuseIdentifier:[CSTutorCommentTitleCell reuserIndentifier]];
    [self.tableView registerClass:[CSTutorNewestCommentCell class] forCellReuseIdentifier:[CSTutorNewestCommentCell reuserIndentifier]];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf fetchVideoInfo:NO];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf fetchCommentList];
    }];
    
    self.keyboardView = [[CSTutorPlayKeyBoardView alloc]initWithFrame:CGRectMake(0, self.tableView.bottom, self.view.width, keyboardHeight)];
    [self.view addSubview:self.keyboardView];
    
    if (![NSString isNilOrEmpty:[CSNewLoginUserInfoManager sharedManager].userInfo.avatar]) {
        [self.keyboardView.avtorImageView sd_setImageWithURL:[NSURL URLWithString:[CSNewLoginUserInfoManager sharedManager].userInfo.avatar]];
    }
    
    self.keyboardView.keyboardBlock = ^(CSTutorPlayKeyBoardBlockType type) {
        
        if (type == CSTutorPlayKeyBoardBlockTypeScroll) {
            [weakSelf scrollToNewsComment];
        }else{
            weakSelf.commentModel = nil;
            [weakSelf.inputView startComment];
        }
    };
    
    self.inputView = [[CSKeyBoardInputView alloc]initWithFrame:CGRectMake(0, ScreenH, self.view.width, 46)];
    self.inputView.placeHolder = csnation(@"说点什么吧…");
    [self.view addSubview:self.inputView];
    self.inputView.inputBlock = ^(NSString *content) {
        
        [weakSelf sendComment:content commentId:weakSelf.commentModel.commonId commenter:weakSelf.commentModel.uid];
    };
    
}

#pragma mark - network method

- (void)fetchVideoInfo:(BOOL)first{
    self.currentPage = 1;
    if ([NSString isNilOrEmpty:self.videoId]) {
        [csnation(@"入参为空") showAlert];
        return;
    }
    if (first) {
        [self showProgressHUD];
    }
    [self.discussList removeAllObjects];
    CS_Weakify(self, weakSelf);
    [[CSTutorVideoPlayManager shared] fetchVideoInfo:self.videoId specialId:@"" complete:^(CSNetResponseModel *response, NSError *error) {
        [weakSelf hideProgressHUD];
        [weakSelf.tableView.mj_header endRefreshing];
        if (response) {
            NSDictionary * dict = (NSDictionary*)response.data;
            CSTutorVideoModel * model = [CSTutorVideoModel yy_modelWithDictionary:dict];
            weakSelf.model = model;
            for (CSTutorCommentModel * comment in weakSelf.model.discussList) {
                if ([comment.rid isEqualToString:@"0"]) {
                    [weakSelf.discussList addObject:comment];
                }
            }
            weakSelf.tableView.mj_footer.hidden = weakSelf.discussList.count < 5;
            [weakSelf.tableView reloadData];
            [weakSelf.containerView showBackView];
            [weakSelf setBackImage];
            if (weakSelf.player.currentPlayerManager.isPlaying && !first) {
                return;
            }
            [weakSelf checkVideo];
        }
            
    }];
}


- (void)checkVideo{
    self.controlView.slider.userInteractionEnabled = YES;
    if ([CSNewLoginUserInfoManager sharedManager].currentAppVersionInfo.ios_hide) {//是否审核
        [self playVideo];
        return;
    }
    
    if (!self.model.taskInfo.is_show) {
        CSVideoUnopenAlertView * alertView = [[CSVideoUnopenAlertView alloc]init];
        alertView.alertBlock = ^{
            [self.navigationController popViewControllerAnimated:YES];
        };
        [alertView show];
        return;
    }
    
    if ([self.model.isPay isEqualToString:@"0"]) {//是否已为视频付费
        if (self.model.taskInfo.free_time > 0) {//免费播放视频
            self.controlView.slider.userInteractionEnabled = NO;
            [self playVideo];
            return;
        }
        [self showVideoPriceView];
        return;
    }
    
    [self playVideo];
}

- (void)showVideoPriceView{
    CSNewLoginModel * userInfo = [CSNewLoginUserInfoManager sharedManager].userInfo;
    if ([userInfo.is_vip isEqualToString:@"1"]) {
        if ([self.model.taskInfo.member_pay_type isEqualToString:@"1"]) {
            self.containerView.moneyDes = self.model.taskInfo.member_money_info;
            self.containerView.titleDes = csnation(@"vip需要付费");
            [self.containerView showRechargeView];
            self.containerView.vipBtn.hidden = YES;
            return;
        }
        [self playVideo];
    }else{
        if ([self.model.taskInfo.pay_type isEqualToString:@"1"]) {
            self.containerView.moneyDes = self.model.taskInfo.money_info;
            [self.containerView showRechargeView];
            return;
        }
        [self playVideo];
    }
}

- (BOOL)needPayForVideo{
    
    if ([self.model.isPay isEqualToString:@"0"]) {//是否需要付费
        CSNewLoginModel * userInfo = [CSNewLoginUserInfoManager sharedManager].userInfo;
        if ([userInfo.is_vip isEqualToString:@"1"]) {
            if ([self.model.taskInfo.member_pay_type isEqualToString:@"1"]) {
                return YES;
            }
            return NO;
        }else{
            if ([self.model.taskInfo.pay_type isEqualToString:@"1"]) {
                return YES;
            }
            return NO;
        }
    }
    return NO;
}

- (void)playVideo{
    if (![NSString isNilOrEmpty:self.model.taskInfo.link]) {
        if ([[UIViewController currentViewController] isKindOfClass:[CSTutorPlayViewController class]]) {
            self.player.assetURL = [NSURL URLWithString:self.model.taskInfo.link];
        }
        
    }else{
        [csnation(@"视频地址为空") showAlert];
    }
}


- (void)fetchCommentList{
    
    CS_Weakify(self, weakSelf);
    [[CSTutorVideoPlayManager shared] fetchCommentList:self.videoId page:self.currentPage complete:^(CSNetResponseModel *response, NSError *error) {
        [weakSelf.tableView.mj_footer endRefreshing];
        weakSelf.currentPage += 1;
        if ([response.data isKindOfClass:[NSArray class]]) {
            NSArray * list = response.data;
            if (list.count > 0) {
                for (NSDictionary * dict in list) {
                    CSTutorCommentModel * comment = [CSTutorCommentModel yy_modelWithDictionary:dict];
                    if ([comment.rid isEqualToString:@"0"]) {
                        [weakSelf.discussList addObject:comment];
                    }
                }
            }else{
                weakSelf.tableView.mj_footer.hidden = YES;
            }
        }else{
            weakSelf.tableView.mj_footer.hidden = YES;
        }
        
    }];
    
    
}

- (void)setBackImage{
    
    if (![NSString isNilOrEmpty:self.model.taskInfo.image]) {
        CS_Weakify(self, weakSelf);
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:self.model.taskInfo.image] options:SDWebImageDownloaderProgressiveDownload progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image) {
                    UIImage * blurry = [image applyExtraLightEffect];
                    UIImageView * blurryImageView = [[UIImageView alloc]initWithImage:blurry];
                    blurryImageView.frame = weakSelf.tableView.frame;
                    [weakSelf.view insertSubview:blurryImageView atIndex:0];
                    weakSelf.tableView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
                }
            });

        }];
    }
    
}

- (void)sendComment:(NSString*)content commentId:(NSString*)commentId commenter:(NSString*)commenter{
    
    CS_Weakify(self, weakSelf);
    [[CSTutorVideoPlayManager shared] reply:commentId commenter:commenter videoId:self.videoId content:content complete:^(CSNetResponseModel *response, NSError *error) {
        if (!error) {
            [weakSelf.inputView endComment];
            CSTutorCommentModel * comment = [CSTutorCommentModel yy_modelWithJSON:response.data];
            if (weakSelf.commentModel) {
                NSMutableArray * replies = [NSMutableArray arrayWithArray:weakSelf.commentModel.down_info];
                [replies insertObject:comment atIndex:0];
                weakSelf.commentModel.down_info = replies;
            }else{
                [weakSelf.discussList insertObject:comment atIndex:0];
            }
            [weakSelf.tableView reloadData];
            [weakSelf scrollToNewsComment];
        }
    
    }];
    
}

#pragma mark - Private Method

- (void)scrollToNewsComment{
    if (self.discussList.count > 0) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
}

#pragma mark - Action Method

- (void)commentCellClick:(CSTutorNewestCommentBlockType)type data:(id)data{
    
    if (![CSNewLoginUserInfoManager sharedManager].isLogin) {
        [[CSNewLoginUserInfoManager sharedManager] goToLogin:^(BOOL success) {
            
        }];
        return;
    }
    
    if (type == CSTutorNewestCommentBlockReply) {//回复
        self.commentModel = data;
        [self.inputView startComment];
    }else{//点赞
        
        CSTutorCommentModel * commentModel = data;
        [[CSTutorVideoPlayManager shared] commentLike:commentModel.commonId complete:^(CSNetResponseModel *response, NSError *error) {
            if (!error) {
//                BOOL success = [response.data boolValue];
                commentModel.is_click = !commentModel.is_click;
                NSInteger clickCount = commentModel.click_count + (commentModel.is_click ? 1 : -1);
                commentModel.click_count = clickCount;
                NSInteger index = [self.discussList indexOfObject:commentModel];
                
                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index+1 inSection:2];
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                
            }
                    
                }];
        
    }
    
}

- (void)showRechargeAlertView{
    
    if (![CSNewLoginUserInfoManager sharedManager].isLogin) {
        [[CSNewLoginUserInfoManager sharedManager] goToLogin:^(BOOL success) {
            [self doShowRechargeAlertView];
        }];
        return;
    }
    [self doShowRechargeAlertView];
}

- (void)doShowRechargeAlertView{
    CSVideoPlayeRechargeAlertView * recharegeView = [[CSVideoPlayeRechargeAlertView alloc]init];
    recharegeView.cs_tapToDismiss = YES;
    recharegeView.price = self.model.taskInfo.money;
    if ([[CSNewLoginUserInfoManager sharedManager].userInfo.is_vip isEqualToString:@"1"]) {
        recharegeView.price = self.model.taskInfo.member_money;
    }
    recharegeView.alertBlock = ^{
        [[CSNewPayManage sharedManager] gotoMoneyPayWith:self.model.taskInfo.taskInfoId WithPay:^(BOOL success) {
            if (success) {
                [self fetchVideoInfo:NO];
            }
        }];
    };
    [recharegeView show];
}

- (void)rechargeForVip{
    if (![CSNewLoginUserInfoManager sharedManager].isLogin) {
        [[CSNewLoginUserInfoManager sharedManager] goToLogin:^(BOOL success) {
            [self doRechargeForVip];
        }];
        return;
    }
    [self doRechargeForVip];
}

- (void)doRechargeForVip{
    //充值
    CS_Weakify(self, weakSelf);
    [[CSNewPayManage sharedManager] gotoVipPayWithPay:^(BOOL success) {
        if (success) {
            [[CSNewLoginNetManager sharedManager] getUserInfoWithTokenComplete:^(CSNetResponseModel * _Nonnull response) {
                if (response.code==200) {
                    NSDictionary  *dict = response.data;
                    CSNewLoginModel *model= [CSNewLoginModel yy_modelWithDictionary:dict];
                    [CSNewLoginUserInfoManager sharedManager].userInfo = model;
                    [weakSelf fetchVideoInfo:NO];
                }
            } failureComplete:^(NSError * _Nonnull error) {
                            
            }];
        }
    }];
}

- (void)dealClick:(CSTutorVideoBriefBlockType)type{
    
    CS_Weakify(self, weakSelf);
    if (type == CSTutorVideoBriefBlockTypeLike) {//喜欢
        [self performClick:^{
            [weakSelf doLikeClick];
        } needLogin:YES];
        
    }else if (type == CSTutorVideoBriefBlockTypeShare){//分享
        [[CSShareManager shared] showShareView];
    }else if (type == CSTutorVideoBriefBlockTypeCollect){//收藏
        [self performClick:^{
            [weakSelf doCollectClick];
        } needLogin:YES];
        
    }else if (type == CSTutorVideoBriefBlockTypeFollow){
        
        [self performClick:^{
            [weakSelf doFollowClick];
        } needLogin:YES];
        
    }
    
}


- (void)doLikeClick{
    
    CS_Weakify(self, weakSelf);
    [[CSTutorVideoPlayManager shared] likeVideo:self.videoId complete:^(CSNetResponseModel *response, NSError *error) {
        if (response.code == 200) {
            weakSelf.model.taskInfo.is_click = !weakSelf.model.taskInfo.is_click;
            [weakSelf refreshVideoInfo];
        }
    }];
}

- (void)doCollectClick{
    
    CS_Weakify(self, weakSelf);
    [[CSTutorVideoPlayManager shared] collectVideo:self.videoId complete:^(CSNetResponseModel *response, NSError *error) {
        if (response.code == 200) {
            weakSelf.model.taskInfo.is_collect = !weakSelf.model.taskInfo.is_collect;
            [weakSelf refreshVideoInfo];
        }
    }];
}

- (void)doFollowClick{
    
    CS_Weakify(self, weakSelf);
    [[CSNewHomeNetManager sharedManager] getHomeaddFollowSuccessId:self.model.specialId Complete:^(CSNetResponseModel * _Nonnull response) {
        if (response.code == 200) {
            weakSelf.model.specialInfo.is_follow = !weakSelf.model.specialInfo.is_follow;
            [weakSelf refreshVideoInfo];
        }else{
            [WHToast showMessage:response.msg duration:1.0 finishHandler:nil];
        }
    } failureComplete:^(NSError * _Nonnull error) {
                
    }];
}

- (void)performClick:(void(^)(void))complete needLogin:(BOOL)needLogin{
    
    if (needLogin) {
        if (![CSNewLoginUserInfoManager sharedManager].isLogin) {
            [[CSNewLoginUserInfoManager sharedManager] goToLogin:^(BOOL success) {
                            if (success) {
                                if (complete) {
                                    complete();
                                }
                            }
                        }];
        }else{
            if (complete) {
                complete();
            }
        }
    }else{
        if (complete) {
            complete();
        }
    }
    
}



- (void)refreshVideoInfo{
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITableView Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        if (self.model.specialList.count> 0) {
            return self.model.specialList.count + 1;
        }
        return 0;
    }else if (section == 2){
        if (self.discussList.count > 0) {
            return self.discussList.count + 1;
        }
        return 0;
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            CSTutorVideoDetailCell * detailCell = [tableView dequeueReusableCellWithIdentifier:[CSTutorVideoDetailCell reuserIndentifier]];
            [detailCell configModel:self.model];
            
            return detailCell;
        }else if (indexPath.row == 1) {
            CSTutorVideoBriefCell * brief = [tableView dequeueReusableCellWithIdentifier:[CSTutorVideoBriefCell reuserIndentifier]];
            [brief mockData];
            [brief configModel:self.model];
            CS_Weakify(self, weakSelf);
            brief.briefBlock = ^(CSTutorVideoBriefBlockType type) {
                [weakSelf dealClick:type];
            };
            CGRect rect = [self.model.specialInfo.abstract boundingRectWithSize:CGSizeMake(230, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:10]} context:nil];

            [brief.briefRightLabel setTapActionWithBlock:^{
                if (self.brigfIsOpen) {
                    self->_brigfHeight = 126;
                    
                }else{
                    self->_brigfHeight = rect.size.height + 100;
                }
                self.brigfIsOpen = !self.brigfIsOpen;
                [self.tableView reloadData];
            }];
            if (!self.brigfIsOpen) {
                brief.briefRightLabel.text = csnation(@"展开");
                
            }else{
                brief.briefRightLabel.text = csnation(@"合上");
            }
           
            return brief;
        }
        
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            CSTutorCourseTitleCell * titleCell = [tableView dequeueReusableCellWithIdentifier:[CSTutorCourseTitleCell reuserIndentifier]];
            
            return titleCell;
        }
        CSTutorCourseCell * course = [tableView dequeueReusableCellWithIdentifier:[CSTutorCourseCell reuserIndentifier]];
        CSTutorMasterCourse * model = self.model.specialList[indexPath.row-1];
        [course configModel:model];
        return course;
        
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            CSTutorCommentTitleCell * titleCell = [tableView dequeueReusableCellWithIdentifier:[CSTutorCommentTitleCell reuserIndentifier]];
            return titleCell;
        }
        CSTutorNewestCommentCell * commentCell = [tableView dequeueReusableCellWithIdentifier:[CSTutorNewestCommentCell reuserIndentifier]];
        CSTutorCommentModel * model = self.discussList[indexPath.row-1];
        [commentCell configModel:model];
        CS_Weakify(self, weakSelf);
        commentCell.commonBlock = ^(CSTutorNewestCommentBlockType type, id data) {
            
            [weakSelf commentCellClick:type data:data];
            
        };
        return commentCell;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 100;
        }else if (indexPath.row == 1){
            return self.brigfHeight;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            return 40;
        }
        return 118;
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            return 40;
        }
        CSTutorCommentModel * model = self.discussList[indexPath.row-1];
        return 90 + 50*model.down_info.count;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return;
        }

        CSTutorMasterCourse * model = self.model.specialList[indexPath.row-1];
//        CSTutorPlayViewController * playVC = [[CSTutorPlayViewController alloc]init];
//        playVC.videoId = model.source_id;
//        [self.navigationController pushViewController:playVC animated:YES];
        
        self.videoId = model.source_id;
        [self fetchVideoInfo:YES];
        
    }
    
}

#pragma mark - 屏幕翻转

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.player.isFullScreen) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - properties

- (CSTutorPlayerContainerView *)containerView {
    if (!_containerView) {
        _containerView = [[CSTutorPlayerContainerView alloc]init];
//        [_containerView setImageWithURLString:kVideoCover placeholder:[ZFUtilities imageWithColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] size:CGSizeMake(1, 1)]];
    }
    return _containerView;
}

- (CSTutorCustomControlView *)controlView {
    if (!_controlView) {
        _controlView = [CSTutorCustomControlView new];
        CS_Weakify(self, weakSelf);
        _controlView.backBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _controlView;
}

- (NSMutableArray*)discussList{
    if (!_discussList) {
        _discussList = [NSMutableArray arrayWithCapacity:0];
    }
    return _discussList;
}

@end
