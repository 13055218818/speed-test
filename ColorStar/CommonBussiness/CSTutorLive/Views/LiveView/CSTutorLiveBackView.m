//
//  CSTutorLiveBackView.m
//  ColorStar
//
//  Created by gavin on 2020/11/21.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorLiveBackView.h"
#import <NELivePlayerFramework/NELivePlayerFramework.h>


@interface CSTutorLiveBackView ()

@property (nonatomic, strong)UIImageView * backImageView;

@property (nonatomic, strong) NELivePlayerController *player; //播放器sdk

@property (nonatomic, assign)CGSize  videoResolution;//视频宽高

@end

@implementation CSTutorLiveBackView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    self.backImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    self.backImageView.image = LoadImage(@"cs_tutor_live_inner_back");
    [self addSubview:self.backImageView];
    
}

- (void)setLiveModel:(CSTutorLiveModel *)liveModel{
    _liveModel = liveModel;
    [self setupPlayer];
    [self addObserver];
}


- (void)setupPlayer{
    
    NSError * error;
    if (![NSString isNilOrEmpty:self.liveModel.liveInfo.httpPullUrl]) {
        self.player = [[NELivePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.liveModel.liveInfo.httpPullUrl] error:&error];
    }
    if (self.player == nil) {
        NSLog(@"player initilize failed, please tay again.error = [%@]!", error);
    }
    [self addSubview:self.player.view];
    self.player.view.frame = self.bounds;
        
    [self.player setBufferStrategy:NELPLowDelay]; // 直播低延时模式
    [self.player setScalingMode:NELPMovieScalingModeNone]; // 设置画面显示模式，默认原始大小
    [self.player setShouldAutoplay:YES]; // 设置prepareToPlay完成后是否自动播放
    [self.player setHardwareDecoder:YES]; // 设置解码模式，是否开启硬件解码
    [self.player setPauseInBackground:NO]; // 设置切入后台时的状态，暂停还是继续播放
    [self.player setPlaybackTimeout:15 *1000]; // 设置拉流超时时间
    [self.player prepareToPlay];
    
}

- (void)addObserver{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerDidPreparedToPlay:)
                                                 name:NELivePlayerDidPreparedToPlayNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerPlaybackStateChanged:)
                                                 name:NELivePlayerPlaybackStateChangedNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NeLivePlayerloadStateChanged:)
                                                 name:NELivePlayerLoadStateChangedNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerPlayBackFinished:)
                                                 name:NELivePlayerPlaybackFinishedNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerFirstVideoDisplayed:)
                                                 name:NELivePlayerFirstVideoDisplayedNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerFirstAudioDisplayed:)
                                                 name:NELivePlayerFirstAudioDisplayedNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerReleaseSuccess:)
                                                 name:NELivePlayerReleaseSueecssNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerSeekComplete:)
                                                 name:NELivePlayerMoviePlayerSeekCompletedNotification
                                               object:_player];
}


#pragma mark -  播放器通知事件

- (void)NELivePlayerDidPreparedToPlay:(NSNotification*)notification {
    //add some methods
    NSLog(@"[NELivePlayer Demo] 收到 NELivePlayerDidPreparedToPlayNotification 通知");
    
    
    //获取视频信息，主要是为了告诉界面的可视范围，方便字幕显示
    NELPVideoInfo info;
    memset(&info, 0, sizeof(NELPVideoInfo));
    [self.player getVideoInfo:&info];
    self.videoResolution = CGSizeMake(info.width, info.height);
    
//    [self syncUIStatus];
    [self.player play]; //开始播放
    
    //开
    [self.player setRealTimeListenerWithIntervalMS:500 callback:^(NSTimeInterval realTime) {
        NSLog(@"当前时间戳：[%f]", realTime);
    }];
    
    //关
    [self.player setRealTimeListenerWithIntervalMS:500 callback:nil];
    

}

- (void)NELivePlayerPlaybackStateChanged:(NSNotification*)notification {
    NSLog(@"[NELivePlayer Demo] 收到 NELivePlayerPlaybackStateChangedNotification 通知");
}

- (void)NeLivePlayerloadStateChanged:(NSNotification*)notification {
    NSLog(@"[NELivePlayer Demo] 收到 NELivePlayerLoadStateChangedNotification 通知");
    
    NELPMovieLoadState nelpLoadState = _player.loadState;
    
    if (nelpLoadState == NELPMovieLoadStatePlaythroughOK)
    {
        
        [MBProgressHUD hideHUDForView:self animated:YES];
    }
    else if (nelpLoadState == NELPMovieLoadStateStalled)
    {
        
        [MBProgressHUD showHUDAddedTo:self animated:YES];
    }
}

- (void)NELivePlayerPlayBackFinished:(NSNotification*)notification {
    NSLog(@"[NELivePlayer Demo] 收到 NELivePlayerPlaybackFinishedNotification 通知");
    
    [MBProgressHUD hideHUDForView:self animated:YES];
    
    
    switch ([[[notification userInfo] valueForKey:NELivePlayerPlaybackDidFinishReasonUserInfoKey] intValue])
    {
        case NELPMovieFinishReasonPlaybackEnded:
            
            [csnation(@"直播结束") showAlert];
            break;
            
        case NELPMovieFinishReasonPlaybackError:
        {
            [csnation(@"播放失败") showAlert];
            break;
        }
            
        case NELPMovieFinishReasonUserExited:
            break;
            
        default:
            break;
    }
}

- (void)NELivePlayerFirstVideoDisplayed:(NSNotification*)notification {
    NSLog(@"[NELivePlayer Demo] 收到 NELivePlayerFirstVideoDisplayedNotification 通知");
}

- (void)NELivePlayerFirstAudioDisplayed:(NSNotification*)notification {
    NSLog(@"[NELivePlayer Demo] 收到 NELivePlayerFirstAudioDisplayedNotification 通知");
}

- (void)NELivePlayerSeekComplete:(NSNotification*)notification {
    NSLog(@"[NELivePlayer Demo] 收到 NELivePlayerMoviePlayerSeekCompletedNotification 通知");
    
}

- (void)NELivePlayerReleaseSuccess:(NSNotification*)notification {
    NSLog(@"[NELivePlayer Demo] 收到 NELivePlayerReleaseSueecssNotification 通知");
}

- (void)doDestroyPlayer {
    [self.player shutdown]; // 退出播放并释放相关资源
    [self.player.view removeFromSuperview];
    self.player = nil;
}

- (void)dealloc {
    NSLog(@"[NELivePlayer Demo] NELivePlayerVC 已经释放！");
    [self doDestroyPlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
