//
//  CSCourseDetailViewController.m
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSCourseDetailViewController.h"
#import "CSCourseTopView.h"
#import "UIImage+CS.h"
#import <UIImageView+WebCache.h>
#import "NSString+CS.h"
#import "AppDelegate.h"
#import "CSCourseCourseListCell.h"
#import "CSColorStar.h"
#import "CSCourseSwitchView.h"
#import "UIView+CS.h"
#import <Masonry.h>

#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/ZFIJKPlayerManager.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import <ZFPlayer/UIView+ZFFrame.h>
#import <ZFPlayer/UIImageView+ZFCache.h>
#import <ZFPlayer/ZFPlayerConst.h>

NSString  * const CSCourseCourseListCellReuseIdentifier = @"CSCourseCourseListCellReuseIdentifier";

@interface CSCourseDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CSArtorCourseRowModel  * currentModel;

@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) UIImageView *containerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (nonatomic, strong) UIButton *playBtn;

@property (nonatomic, strong)UILabel  * abstractLabel;

@property (nonatomic, strong)UILabel  * playCount;


@property (nonatomic, strong)UITableView  * tableView;


@end

@implementation CSCourseDetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentModel = self.rowModels[self.selectedIndex];
    self.title = self.currentModel.title;
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.player.viewControllerDisappear = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.player.viewControllerDisappear = YES;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = CGRectGetWidth(self.view.frame);
    CGFloat h = w*9/16;
    self.containerView.frame = CGRectMake(x, y, w, h);
    
    w = 44;
    h = w;
    x = (CGRectGetWidth(self.containerView.frame)-w)/2;
    y = (CGRectGetHeight(self.containerView.frame)-h)/2;
    self.playBtn.frame = CGRectMake(x, y, w, h);
    
}

- (void)setupViews{
    [self setupTableView];
    [self setupTopViews];
    
}

- (void)setupTopViews{
    if (![NSString isNilOrEmpty:self.currentModel.image]) {
        [self.containerView sd_setImageWithURL:[NSURL URLWithString:self.currentModel.image] placeholderImage:[UIImage imageWithColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] size:CGSizeMake(1, 1)]];
    }else{
        self.containerView.image = [UIImage imageWithColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] size:CGSizeMake(1, 1)];
    }
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.playBtn];
    
    if (self.currentModel.courseType == CSCourseTypeVideo || self.currentModel.courseType == CSCourseTypeAudio) {
        if ([NSString isNilOrEmpty:self.currentModel.link]) {
            self.playBtn.hidden = YES;
        }else{
            self.playBtn.hidden = NO;
            self.player.assetURL = [NSURL URLWithString:self.currentModel.link];
        }
        
    }else{
        self.playBtn.hidden = YES;
    }
    
    [self setupPlayer];
    
    [self.view addSubview:self.abstractLabel];
    [self.view addSubview:self.playCount];
    [self.abstractLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(14);
        make.top.mas_equalTo(self.view).offset(ScreenW*9/16 + 10);
    }];
    
    [self.playCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.abstractLabel);
        make.top.mas_equalTo(self.abstractLabel.mas_bottom).offset(5);
    }];
    
    self.abstractLabel.text = self.currentModel.title;
    self.playCount.text = [[@(self.currentModel.play_count) stringValue] getPlayCount];
    
}

- (void)setupTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CSCourseCourseListCell class] forCellReuseIdentifier:CSCourseCourseListCellReuseIdentifier];
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.tableView];
    self.tableView.contentInset = UIEdgeInsetsMake(ScreenW*9/16 + 50, 0, 0, 0);
}


- (void)setupPlayer {
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];

    playerManager.shouldAutoPlay = NO;
    
    /// 播放器相关
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.containerView];
    self.player.controlView = self.controlView;
    /// 设置退到后台继续播放
    self.player.pauseWhenAppResignActive = NO;
//    self.player.resumePlayRecord = YES;
    
    @zf_weakify(self)
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        ((AppDelegate*)[UIApplication sharedApplication].delegate).allowOrentitaionRotation = isFullScreen;
    };
    
    /// 播放完成
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @zf_strongify(self)
        
        [self.player stop];
    };
    
    self.abstractLabel.text = self.currentModel.title;
    self.playCount.text = [[@(self.currentModel.play_count) stringValue] getPlayCount];
    
}

- (void)switchIndex:(NSInteger)index{
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    CSCourseCourseListCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell switchToIndex:index];
    
    
    
}
- (void)playClick:(UIButton *)sender {
    
    self.player.assetURL = [NSURL URLWithString:self.currentModel.link];
    [self.controlView showTitle:self.currentModel.title coverURLString:self.currentModel.image fullScreenMode:ZFFullScreenModeAutomatic];
}

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
    return UIInterfaceOrientationMaskPortrait;
}

- (void)reloadTopViews{
    self.currentModel = self.rowModels[self.selectedIndex];
    
    if (![NSString isNilOrEmpty:self.currentModel.image]) {
        [self.containerView sd_setImageWithURL:[NSURL URLWithString:self.currentModel.image] placeholderImage:[UIImage imageWithColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] size:CGSizeMake(1, 1)]];
    }else{
        self.containerView.image = [UIImage imageWithColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] size:CGSizeMake(1, 1)];
    }
    [self.player stop];
    
    if (![NSString isNilOrEmpty:self.currentModel.link]) {
        self.playBtn.hidden = NO;
        self.player.assetURL = [NSURL URLWithString:self.currentModel.link];
    }else{
        self.playBtn.hidden = YES;
    }
    
    
}

#pragma mark - Properties Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CSCourseCourseListCell * cell = (CSCourseCourseListCell*)[tableView dequeueReusableCellWithIdentifier:CSCourseCourseListCellReuseIdentifier forIndexPath:indexPath];
    CS_Weakify(self, weakSelf);
    
    cell.courseClick = ^(NSInteger index) {
        weakSelf.selectedIndex = index;
        [weakSelf reloadTopViews];
    };
    cell.models = self.rowModels;
    cell.index = self.selectedIndex;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        CSCourseSwitchView * headerView = [[CSCourseSwitchView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 60)];
        CS_Weakify(self, weakSelf);
        headerView.switchBlock = ^(NSInteger index) {
            [weakSelf switchIndex:index];
        };
        return headerView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.tableView.height - ScreenW*9/16 - 40 - 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

#pragma mark - Properties

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.fastViewAnimated = YES;
        _controlView.autoHiddenTimeInterval = 5;
        _controlView.autoFadeTimeInterval = 0.5;
        _controlView.prepareShowLoading = YES;
        _controlView.prepareShowControlView = NO;
    }
    return _controlView;
}

- (UIImageView *)containerView {
    if (!_containerView) {
        _containerView = [UIImageView new];
        _containerView.image = [UIImage imageWithColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] size:CGSizeMake(1, 1)];
    }
    return _containerView;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"cs_video_play_icon"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (UILabel*)abstractLabel{
    if (!_abstractLabel) {
        _abstractLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _abstractLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.8];
        _abstractLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return _abstractLabel;
}

- (UILabel*)playCount{
    if (!_playCount) {
        _playCount = [[UILabel alloc]initWithFrame:CGRectZero];
        _playCount.font = [UIFont systemFontOfSize:12.0f];
        _playCount.textColor = [UIColor colorWithWhite:1.0 alpha:0.38];
    }
    return _playCount;
}

@end
