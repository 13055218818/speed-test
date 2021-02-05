//
//  CSLiveDetailViewController.m
//  ColorStar
//
//  Created by gavin on 2020/9/27.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSLiveDetailViewController.h"
#import <NELivePlayerFramework/NELivePlayerFramework.h>
#import "CSLivePlayerContainerView.h"
#import "UIView+CS.h"
#import "CSEmptyRefreshView.h"
#import "CSColorStar.h"
#import <MBProgressHUD.h>
#import "CSNetworkManager.h"
#import "CSLiveModel.h"
#import <YYModel.h>
#import "CSLiveBottomView.h"
#import "CSIMManager.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "AppDelegate.h"


@interface CSLiveDetailViewController ()<CSLivePlayerContainerViewProtocol>
{
    NSURL *_url;
    NSString *_mediaType;
    BOOL _isHardware;
    dispatch_source_t _timer;
}

@property (nonatomic, strong)CSEmptyRefreshView  * refreshView;

@property (nonatomic, strong)CSLiveModel         * liveModel;

@property (nonatomic, strong) NELivePlayerController *player; //播放器sdk

@property (nonatomic, strong) UIView *playerContainerView; //播放器包裹视图

@property (nonatomic, strong) CSLivePlayerContainerView *controlView; //播放器控制视图

@property (nonatomic, strong) CSLiveBottomView *  bottomView;

@property (nonatomic, assign) BOOL isFullScreen;

//外挂字幕处理缓存
@property (nonatomic, strong) NSMutableArray *subtitleIdArray;
@property (nonatomic, strong) NSMutableDictionary *subtitleDic;
@property (nonatomic, strong) NSMutableArray *exSubtitleIdArray;
@property (nonatomic, strong) NSMutableDictionary *exSubtitleDic;

@end

@implementation CSLiveDetailViewController

- (void)dealloc {
    NSLog(@"[NELivePlayer Demo] NELivePlayerVC 已经释放！");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    
//    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    [[UIApplication sharedApplication]setStatusBarHidden:NO];
//    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mediaType = @"livestream";
    self.navigationController.navigationBar.hidden = YES;
    
    self.refreshView = [[CSEmptyRefreshView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.refreshView];
    self.refreshView.frame = self.view.bounds;
    CS_Weakify(self, weakSelf);
    self.refreshView.refreshBlock = ^{
        [weakSelf loadData];
    };
    self.refreshView.hidden = YES;
    
    [self loadData];
}


- (void)loadData{
    
    self.refreshView.hidden = YES;
    CS_Weakify(self, weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [[CSNetworkManager sharedManager] quaryLiveInfoWithStreamName:self.liveInfo.stream_name successComplete:^(CSNetResponseModel *response) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [weakSelf reloadResponse:response];
        } failureComplete:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            weakSelf.refreshView.hidden = NO;
        }];
    
    
}
- (void)reloadResponse:(CSNetResponseModel*)response{
    NSDictionary * dict = response.data;
    self.liveModel = [CSLiveModel yy_modelWithDictionary:dict];
    _url = [NSURL URLWithString:self.liveModel.PullUrl];
    
    [self setup];
    
}

- (void)setup{
    
    [self setupSubviews];
    
    [self doInitPlayer];
    
    [self doInitPlayerNotication];
    
    if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDeviceOrientationChange) name:UIDeviceOrientationDidChangeNotification object:nil];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat x = 0;
    CGFloat y = kStatusBarHeight;
    CGFloat viewW = CGRectGetWidth(self.view.frame);
    CGFloat viewH = CGRectGetHeight(self.view.frame);
    
    if (viewW > viewH) {
        self.playerContainerView.frame = self.view.bounds;
        self.bottomView.hidden = YES;
        self.isFullScreen = YES;
    }else{
        self.playerContainerView.frame = CGRectMake(x, y, viewW, viewW*(9/16.0));
        self.bottomView.hidden = NO;
        self.isFullScreen = NO;
    }
    self.controlView.frame = self.playerContainerView.bounds;
    self.player.view.frame = self.playerContainerView.bounds;
    

}

//- (BOOL)shouldAutorotate {
//    return YES;
//}
//
//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return UIInterfaceOrientationLandscapeLeft;
//}



- (void)setupSubviews {
    
    self.playerContainerView = [[UIView alloc] init];
    self.playerContainerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_playerContainerView];
    self.playerContainerView.frame = CGRectMake(0, kStatusBarHeight, self.view.width, self.view.width*(9/16.0));
    
    self.controlView = [[CSLivePlayerContainerView alloc] init];
    self.controlView.fileTitle = self.liveInfo.live_title;
    self.controlView.delegate = self;
    self.controlView.frame = self.playerContainerView.bounds;
    [self.playerContainerView addSubview:_controlView];
    
    self.bottomView = [[CSLiveBottomView alloc]initWithFrame:CGRectMake(0, self.playerContainerView.bottom, self.view.width, self.view.height - self.playerContainerView.bottom)];
    self.bottomView.liveModel = self.liveModel;
    [self.view addSubview:self.bottomView];

}

- (void)handleDeviceOrientationChange{
    
    CGFloat x = 0;
    CGFloat y = kStatusBarHeight;
    CGFloat viewW = CGRectGetWidth(self.view.frame);
    CGFloat viewH = CGRectGetHeight(self.view.frame);
}

- (void)syncUIStatus
{
    _controlView.isPlaying = NO;
    
    __block NSTimeInterval mDuration = 0;
    __block bool getDurFlag = false;
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t syncUIQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = CreateDispatchSyncUITimerN(1.0, syncUIQueue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (!getDurFlag) {
                mDuration = [weakSelf.player duration];
                if (mDuration > 0) {
                    getDurFlag = true;
                }
            }
            
            weakSelf.controlView.isAllowSeek = (mDuration > 0);
            weakSelf.controlView.duration = mDuration;
            weakSelf.controlView.currentPos = [weakSelf.player currentPlaybackTime];
            weakSelf.controlView.isPlaying = ([weakSelf.player playbackState] == NELPMoviePlaybackStatePlaying);
        });
    });
}

#pragma mark - 播放器SDK功能

- (void)doInitPlayer {
    
    //[NELivePlayerController setLogLevel:NELP_LOG_VERBOSE];
    
//    NELPUrlConfig *urlConfig = nil;
    /**视频云加密的视频，自己已知密钥，增加以下一段**/
    /*
    urlConfig = [[NELPUrlConfig alloc] init];
    urlConfig.decryptionConfig = [[NELPUrlDecryptionConfig alloc] init];
    NSString *key = @"HelloWorld";
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    urlConfig.decryptionConfig = [NELPUrlDecryptionConfig configWithOriginalKey:keyData];
    */
     
    /**用视频云整套加解密系统，增加以下一段**/
    /*
    urlConfig = [[NELPUrlConfig alloc] init];
    urlConfig.decryptionConfig = [NELPUrlDecryptionConfig configWithTransferToken:@"exampleTransferToken"
                                                                            accid:@"exampleAccid"
                                                                           appKey:@"exampleAppKey"
                                                                            token:@"exampleToken"];
    */
    
    NSError *error = nil;
    self.player = [[NELivePlayerController alloc] initWithContentURL:_url error:&error];
    if (self.player == nil) {
        NSLog(@"player initilize failed, please tay again.error = [%@]!", error);
    }
    [self.playerContainerView insertSubview:self.player.view atIndex:0];
    self.player.view.frame = self.playerContainerView.bounds;
    
    self.view.autoresizesSubviews = YES;
    
    if ([_mediaType isEqualToString:@"livestream"] ) {
        [self.player setBufferStrategy:NELPLowDelay]; // 直播低延时模式
    }
    else {
        [self.player setBufferStrategy:NELPAntiJitter]; // 点播抗抖动
    }
    [self.player setScalingMode:NELPMovieScalingModeNone]; // 设置画面显示模式，默认原始大小
    [self.player setShouldAutoplay:YES]; // 设置prepareToPlay完成后是否自动播放
    [self.player setHardwareDecoder:_isHardware]; // 设置解码模式，是否开启硬件解码
    [self.player setPauseInBackground:NO]; // 设置切入后台时的状态，暂停还是继续播放
    [self.player setPlaybackTimeout:15 *1000]; // 设置拉流超时时间
    
    
    //字幕功能
    //[self subtitleFunction];
    
    //透传自定义信息功能
    //[self syncContentFunction];
    
    /** 视频云加密的视频，自己已知密钥 **/
    [self.player prepareToPlay];
//    [MBProgressHUD showHUDAddedTo:self.controlView animated:YES];
}

- (void)doInitPlayerNotication {
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

- (void)doDestroyPlayer {
    [self.player shutdown]; // 退出播放并释放相关资源
    [self.player.view removeFromSuperview];
    self.player = nil;
}



#pragma mark - 播放器通知事件
- (void)NELivePlayerDidPreparedToPlay:(NSNotification*)notification {
    //add some methods
    NSLog(@"[NELivePlayer Demo] 收到 NELivePlayerDidPreparedToPlayNotification 通知");
    [MBProgressHUD hideHUDForView:self.controlView animated:YES];
    
    //获取视频信息，主要是为了告诉界面的可视范围，方便字幕显示
    NELPVideoInfo info;
    memset(&info, 0, sizeof(NELPVideoInfo));
    [_player getVideoInfo:&info];
    _controlView.videoResolution = CGSizeMake(info.width, info.height);
    
    [self syncUIStatus];
    [_player play]; //开始播放
    
    //开
    [_player setRealTimeListenerWithIntervalMS:500 callback:^(NSTimeInterval realTime) {
        NSLog(@"当前时间戳：[%f]", realTime);
    }];
    
    //关
    [_player setRealTimeListenerWithIntervalMS:500 callback:nil];
    

}

- (void)NELivePlayerPlaybackStateChanged:(NSNotification*)notification {
    NSLog(@"[NELivePlayer Demo] 收到 NELivePlayerPlaybackStateChangedNotification 通知");
}

- (void)NeLivePlayerloadStateChanged:(NSNotification*)notification {
    NSLog(@"[NELivePlayer Demo] 收到 NELivePlayerLoadStateChangedNotification 通知");
    
    NELPMovieLoadState nelpLoadState = _player.loadState;
    
    if (nelpLoadState == NELPMovieLoadStatePlaythroughOK)
    {
        NSLog(@"finish buffering");
        _controlView.isBuffing = NO;
    }
    else if (nelpLoadState == NELPMovieLoadStateStalled)
    {
        NSLog(@"begin buffering");
        _controlView.isBuffing = YES;
    }
}

- (void)NELivePlayerPlayBackFinished:(NSNotification*)notification {
    NSLog(@"[NELivePlayer Demo] 收到 NELivePlayerPlaybackFinishedNotification 通知");
    
    [MBProgressHUD hideHUDForView:self.controlView animated:YES];
    
    UIAlertController *alertController = NULL;
    UIAlertAction *action = NULL;
    __weak typeof(self) weakSelf = self;
    switch ([[[notification userInfo] valueForKey:NELivePlayerPlaybackDidFinishReasonUserInfoKey] intValue])
    {
        case NELPMovieFinishReasonPlaybackEnded:
            if ([_mediaType isEqualToString:@"livestream"]) {
                alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"直播结束" preferredStyle:UIAlertControllerStyleAlert];
                action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    [weakSelf doDestroyPlayer];
                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertController addAction:action];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            }
            break;
            
        case NELPMovieFinishReasonPlaybackError:
        {
            alertController = [UIAlertController alertControllerWithTitle:@"注意" message:@"播放失败" preferredStyle:UIAlertControllerStyleAlert];
            action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                [weakSelf doDestroyPlayer];
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:action];
            [weakSelf presentViewController:alertController animated:YES completion:nil];
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
    [self cleanSubtitls];
}

- (void)NELivePlayerReleaseSuccess:(NSNotification*)notification {
    NSLog(@"[NELivePlayer Demo] 收到 NELivePlayerReleaseSueecssNotification 通知");
}

#pragma mark - 控制页面的事件
- (void)controlViewOnClickQuit:(CSLivePlayerContainerView *)controlView {
    NSLog(@"[NELivePlayer Demo] 点击退出");
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [self doDestroyPlayer];
    
    // 释放timer
    if (_timer != nil) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
    
    if (!self.isFullScreen) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        ((AppDelegate*)[UIApplication sharedApplication].delegate).allowOrentitaionRotation = NO;
        [self interfaceOrientation:UIInterfaceOrientationPortrait];
    }
    
}

- (void)controlViewOnClickPlay:(CSLivePlayerContainerView *)controlView isPlay:(BOOL)isPlay {
    NSLog(@"[NELivePlayer Demo] 点击播放，当前状态: [%@]", (isPlay ? @"播放" : @"暂停"));
    if (isPlay) {
        [self.player play];
    } else {
        [self.player pause];
    }
}

- (void)controlViewOnClickSeek:(CSLivePlayerContainerView *)controlView dstTime:(NSTimeInterval)dstTime {
    NSLog(@"[NELivePlayer Demo] 执行seek，目标时间: [%f]", dstTime);
    self.player.currentPlaybackTime = dstTime;
}

- (void)controlViewOnClickMute:(CSLivePlayerContainerView *)controlView isMute:(BOOL)isMute{
    NSLog(@"[NELivePlayer Demo] 点击静音，当前状态: [%@]", (isMute ? @"静音开" : @"静音关"));
    [self.player setMute:isMute];
}

- (void)controlViewOnClickSnap:(CSLivePlayerContainerView *)controlView{
    
    NSLog(@"[NELivePlayer Demo] 点击屏幕截图");
    
    UIImage *snapImage = [self.player getSnapshot];
    
    UIImageWriteToSavedPhotosAlbum(snapImage, nil, nil, nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"截图已保存到相册" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
    
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)controlViewOnClickScale:(CSLivePlayerContainerView *)controlView isFill:(BOOL)isFill {
    NSLog(@"[NELivePlayer Demo] 点击屏幕缩放，当前状态: [%@]", (isFill ? @"全屏" : @"适应"));
    if (isFill) {
        [self.player setScalingMode:NELPMovieScalingModeAspectFill];
    } else {
        [self.player setScalingMode:NELPMovieScalingModeAspectFit];
    }
    
    UIInterfaceOrientation orientation = UIInterfaceOrientationUnknown;
    orientation = isFill? UIInterfaceOrientationLandscapeRight : UIInterfaceOrientationPortrait;
    ((AppDelegate*)[UIApplication sharedApplication].delegate).allowOrentitaionRotation = isFill;
    [self interfaceOrientation:orientation];
}

- (void)interfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        UIInterfaceOrientation val = interfaceOrientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];

        [UIViewController attemptRotationToDeviceOrientation];
        
//        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
//
//        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
//
//        // 将输入的转屏方向（枚举）转换成Int类型
//        int orientation = (int)interfaceOrientation;
//
//        // 对象包装
//        NSNumber *orientationTarget = [NSNumber numberWithInt:orientation];
//
//        // 实现横竖屏旋转
//        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    }
}

#pragma mark - Tools
dispatch_source_t CreateDispatchSyncUITimerN(double interval, dispatch_queue_t queue, dispatch_block_t block)
{
    //创建Timer
    dispatch_source_t timer  = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);//queue是一个专门执行timer回调的GCD队列
    if (timer) {
        //使用dispatch_source_set_timer函数设置timer参数
        dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval*NSEC_PER_SEC), interval*NSEC_PER_SEC, (1ull * NSEC_PER_SEC)/10);
        //设置回调
        dispatch_source_set_event_handler(timer, block);
        //dispatch_source默认是Suspended状态，通过dispatch_resume函数开始它
        dispatch_resume(timer);
    }
    
    return timer;
}

- (void)decryptWarning:(NSString *)msg {
    UIAlertController *alertController = NULL;
    UIAlertAction *action = NULL;
    
    alertController = [UIAlertController alertControllerWithTitle:@"注意" message:msg preferredStyle:UIAlertControllerStyleAlert];
    action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if (self.presentingViewController) {
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 外挂字幕功能示例

- (void)subtitleFunction {
    
    NSString *srtPath1 = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"srt"];
    
    //设置外挂字幕
    NSURL *url = [NSURL fileURLWithPath:srtPath1];
    [self.player setLocalSubtitleFile:url];
    
    //关闭外挂字幕
//    [self.player setSubtitleFile:NULL];
    
    //切换外挂字幕
//    NSString *srtPath2 = @"test2";
//    NSURL *url2 = [NSURL fileURLWithPath:srtPath2];
//    [self.player setSubtitleFile:url];
//    [self.player setSubtitleFile:url2];
    
    //设置监听
    __weak typeof(self) weakSelf = self;
    [self.player registSubtitleStatBlock:^(BOOL isShown, NSInteger subtitleId, NSString *subtitleText) {
        [weakSelf processSubtitle:isShown subId:subtitleId subtitle:subtitleText];
    }];
}

//处理字幕
- (void)processSubtitle:(BOOL)isShown  subId:(NSInteger)subId subtitle:(NSString *)subtitle {
    //NSString *str = (isShown ? @"显示" : @"隐藏");
    //NSLog(@"[%@] id:[%zi] tx:[%@]", str, subId, subtitle);
    if (!_subtitleIdArray) {
        _subtitleIdArray = [NSMutableArray array];
    }
    if (!_subtitleDic) {
        _subtitleDic = [NSMutableDictionary dictionary];
    }
    
    if (!_exSubtitleIdArray) {
        _exSubtitleIdArray = [NSMutableArray array];
    }
    if (!_exSubtitleDic) {
        _exSubtitleDic = [NSMutableDictionary dictionary];
    }
    
    //数据存放
    NSRange range;
    BOOL isExSubtitle = [self isExSubtitle:subtitle range:&range];
    __block NSMutableArray *idArray = (isExSubtitle ? _exSubtitleIdArray : _subtitleIdArray);
    __block NSMutableDictionary *subDic  = (isExSubtitle ? _exSubtitleDic : _subtitleDic);
    NSString *insertSubStr = (isExSubtitle ? [subtitle stringByReplacingCharactersInRange:range withString:@""] : subtitle);
    if (isShown)
    {
        [idArray addObject:@(subId)];
        [subDic setObject:insertSubStr forKey:@(subId)];
    }
    else
    {
        __block NSUInteger index;
        [idArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj integerValue] == subId) {
                [subDic removeObjectForKey:obj];
                index = idx;
                *stop = YES;
            }
        }];
        if (index < idArray.count) {
            [idArray removeObjectAtIndex:index];
        }
    }
    
    //获取显示字符串
    NSMutableString *showStr = [NSMutableString stringWithFormat:@""];
    for (int i = 0; i < idArray.count; i++) {
        if (subDic[idArray[i]]) {
            [showStr appendString:subDic[idArray[i]]];
            if (i != idArray.count - 1) {
                [showStr appendString:@"\n"];
            }
        }
        else
        {
            break;
        }
    }
    
    //更新UI
    if (isExSubtitle) {
        //-----------
        _controlView.subtitle_ex = showStr;
    }
    else
    {
        //----------- 根据显示的字符串做格式处理 ---------------
        _controlView.subtitle = showStr;
    }
}

//扩展的字幕信息{扩展字幕信息，主要包括{}，主要记录附加信息}
- (BOOL)isExSubtitle:(NSString *)subtitle range:(NSRange *)range {
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\{[\\S\\s]+\\}"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSTextCheckingResult *result = [regex firstMatchInString:subtitle
                                                     options:0
                                                       range:NSMakeRange(0, [subtitle length])];
    BOOL ret = NO;
    if (result) {
        *range = result.range;
        ret = YES;
    }
    return ret;
}

- (void)cleanSubtitls { //seek完成后，或者切换完字幕，需要清空
    [_exSubtitleDic removeAllObjects];
    [_exSubtitleIdArray removeAllObjects];
    [_subtitleDic removeAllObjects];
    [_subtitleIdArray removeAllObjects];
    
    //更新UI
    _controlView.subtitle_ex = @"";
    _controlView.subtitle = @"";
}

#pragma mark - 透传自定义信息示例
- (void)syncContentFunction {
    [self.player registerSyncContentCB:^(NELivePlayerSyncContent *content) {
        NSArray *strings = content.contents;
        [strings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"透传的自定义信息是 ：----- %@ ------", obj);
        }];
    }];
}




@end
