//
//  CSNewMediaLiveViewController.m
//  ColorStar
//
//  Created by apple on 2021/1/11.
//  Copyright © 2021 gavin. All rights reserved.
//

#import "CSNewMediaLiveViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UIAlertView+NE.h"
#import "CSNewLiveDefinitionView.h"
#import "CSNewLiveFaceView.h"
#import "CSTutorLiveSurfaceMessageView.h"
#import "CSIMManager.h"
#import "CSTutorLiveManager.h"
#import "NEReachability.h"
#import "CSMediaInfoModel.h"

@interface CSNewMediaLiveViewController ()<CSNewLiveDefinitionViewDelegate,CSNewLiveFaceViewDelegate,LSAudioCaptureDelegate,MPMediaPickerControllerDelegate,CSIMManagerProtocol>
//直播SDK API
@property (nonatomic,strong) LSMediaCapture *mediaCapture;
@property (nonatomic, assign) BOOL isfirst;
@property (nonatomic, strong) UIView *localPreview;//相机预览视图
@property (nonatomic, strong) UIButton*startButton;
@property (nonatomic, strong) UIView *functionView;
@property (nonatomic, strong) CSNewLiveDefinitionView *definitionView;
@property (nonatomic, strong) CSNewLiveFaceView *liveFaceView;
@property (nonatomic, strong) CSTutorLiveSurfaceMessageView  * messageView;

@property (nonatomic, strong) CSMediaInfoModel  * mediaModel;

@end

@implementation CSNewMediaLiveViewController{
    NSString* _streamUrl;//推流地址
    LSVideoParaCtxConfiguration* paraCtx;//推流视频参数设置
    BOOL _isLiving;//是否正在直播
    BOOL _needStartLive;//是否需要开启直播
    LSCameraPosition _isBackCameraPosition;//前置或后置摄像头
    LSCameraOrientation _interfaceOrientation;//摄像头采集方向
    BOOL _isRecording;//是否正在录制
    
    BOOL _isAccess;
}
@synthesize localPreview;
//- (instancetype)initWithUrl:(NSString*)url sLSctx:(LSVideoParaCtxConfiguration *)sLSctx
//{
//    self = [self init];
//    if(self) {
//        _streamUrl = url;
//        paraCtx = sLSctx;
//        [NEMediaCaptureEntity sharedInstance].videoParaCtx = sLSctx;
//        _needStartLive = NO;
//        _isLiving = NO;
//        _isBackCameraPosition = LS_CAMERA_POSITION_FRONT;
//        _isAccess = YES;
//        _isRecording = NO;
//
//    }
//    return self;
//}
#pragma mark - UI Setup
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    paraCtx = [NEMediaCaptureEntity sharedInstance].videoParaCtx;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [NEMediaCaptureEntity sharedInstance].videoParaCtx = paraCtx;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    [self setupSubviews];
    [self getAddress];
    
}
- (void)getAddress{
    [[CSNewMineNetManage sharedManager] getLiveAddressComplete:^(CSNetResponseModel * _Nonnull response) {
        if (response.code==200) {
            NSDictionary *dict = response.data;
            self.mediaModel = [CSMediaInfoModel yy_modelWithDictionary:dict];
            self.functionView.hidden = NO;
            self.startButton.hidden = NO;
            self->_streamUrl = self.mediaModel.url;
            [[CSIMManager sharedManager] initClient];
            [[CSIMManager sharedManager] connect];
            [CSIMManager sharedManager].delegate = self;
            [self initMedia];
        }
        
    } failureComplete:^(NSError * _Nonnull error) {
        
    }];
}

- (void)setupSubviews{
    
    UIButton  *backButton = [[UIButton alloc] init];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"liveStopBack.png"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(12);
        make.top.mas_equalTo(self.view.mas_top).offset(kStatusBarHeight);
        make.width.mas_offset(@(30*heightScale));
        make.height.mas_offset(@(30*heightScale));
    }];
    
    self.startButton = [[UIButton alloc] init];
    self.startButton.hidden = YES;
    [self.startButton  addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    self.startButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.startButton setTitle:csnation(@"开始直播") forState:UIControlStateNormal];
    [self.startButton setBackgroundImage:[UIImage imageNamed:@"startLiveBg.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.startButton ];
    [self.startButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-80);
        make.height.mas_offset(42*heightScale);
    }];
    
    paraCtx = [NEMediaCaptureEntity sharedInstance].videoParaCtx;
    _interfaceOrientation = paraCtx.interfaceOrientation;
    paraCtx.isVideoFilterOn = NO;
    paraCtx.filterType = LS_GPUIMAGE_NORMAL;
    self.view.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    __unused NSInteger width = 0, height = 0, statusBarheight = 0, sliderHeight = 0;
    if (_interfaceOrientation == LS_CAMERA_ORIENTATION_PORTRAIT || _interfaceOrientation == LS_CAMERA_ORIENTATION_UPDOWN) {
        width = self.view.bounds.size.width;
        height = self.view.bounds.size.height;
//        sliderHeight = UIScale(50);
    }else{
        width = self.view.bounds.size.height;
        height = self.view.bounds.size.width;
        statusBarheight = 20;
//        sliderHeight = UIScale(40);
    }
    
    self.localPreview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width,  height)];
    self.localPreview.backgroundColor = [UIColor whiteColor];
    [self.view insertSubview:localPreview atIndex:0];
    
    self.functionView = [[UIView alloc] init];
    self.functionView.hidden = YES;
    self.functionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.functionView];
    [self.functionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-22);
        make.bottom.mas_equalTo(self.startButton.mas_top).offset(-60);
        make.height.mas_offset(@(210));
        make.width.mas_offset(@(26));
   }];
    [self makeFunctionView];
    
    self.definitionView = [[CSNewLiveDefinitionView alloc]init];
    [self.definitionView getMaskConfig].tapToDismiss = NO;
    self.definitionView.delegate = self;
    
    self.liveFaceView = [[CSNewLiveFaceView alloc]init];
    [self.liveFaceView getMaskConfig].tapToDismiss = NO;
    self.liveFaceView.clickBlock = ^(BOOL isDiss) {
       // self.smoothSloder.hidden = YES;
    };
    self.liveFaceView.delegate = self;
    
    
    self.messageView = [[CSTutorLiveSurfaceMessageView alloc]initWithFrame:CGRectMake(0, self.view.bottom - 330*heightScale - 150 - kTabBarStatusHeight, self.view.width -100, 330*heightScale)];
    [self.view addSubview:self.messageView];
    
    
    [self initMedia];
}

- (void)initMedia{
    _needStartLive = NO;
    _isLiving = NO;
    _isBackCameraPosition = LS_CAMERA_POSITION_FRONT;
    _isAccess = YES;
    _isRecording = NO;
    
    //初始化直播参数，并创建音视频直播
    LSLiveStreamingParaCtxConfiguration *streamparaCtx = [LSLiveStreamingParaCtxConfiguration defaultLiveStreamingConfiguration];
    _mediaCapture = [[LSMediaCapture alloc]initLiveStream:_streamUrl withLivestreamParaCtxConfiguration:streamparaCtx];
    _mediaCapture.audioCaptureDelegate = self;
     [_mediaCapture setFilterType:LS_GPUIMAGE_NORMAL];

    if (_mediaCapture == nil) {
        [WHToast showMessage:csnation(@"初始化失败") duration:1 finishHandler:nil];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onStartLiveStream:) name:LS_LiveStreaming_Started object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onFinishedLiveStream:) name:LS_LiveStreaming_Finished object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onBadNetworking:) name:LS_LiveStreaming_Bad object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didNetworkConnectChanged:) name:ne_kReachabilityChangedNotification object:nil];
    if (streamparaCtx.eOutStreamType != LS_HAVE_AUDIO) {
        //打开摄像头预览
        [_mediaCapture setSmoothFilterIntensity:0.0];
        [_mediaCapture setWhiteningFilterIntensity:0.0];
        [_mediaCapture adjustExposure:0.0];
       [_mediaCapture startVideoPreview:self.localPreview];
    }
}

-(void)onStartLiveStream:(NSNotification*)notification
{
    NSLog(@"on start live stream");//只有收到直播开始的 信号，才可以关闭直播
    [WHToast showMessage:csnation(@"直播开始") duration:1.0 finishHandler:nil];
    dispatch_async(dispatch_get_main_queue(), ^(void){
        self->_isLiving = YES;
        self.startButton.hidden = YES;

    });
}

//直播结束的通知消息
-(void)onFinishedLiveStream:(NSNotification*)notification
{
    NSLog(@"on finished live stream");
    [WHToast showMessage:csnation(@"直播结束") duration:1.0 finishHandler:nil];
    dispatch_async(dispatch_get_main_queue(), ^(void){
        self->_isLiving = NO;
        self.startButton.hidden = NO;
    });
}

//网络不好的情况下，连续一段时间收到这种错误，可以提醒应用层降低分辨率
-(void)onBadNetworking:(NSNotification*)notification
{
     NSLog(@"live streaming on bad networking");
    [WHToast showMessage:csnation(@"网络不好请切换清晰度") duration:1.0 finishHandler:nil];
}
#pragma mark -网络监听通知
- (void)didNetworkConnectChanged:(NSNotification *)notify{
    NEReachability *reachability = notify.object;
    NENetworkStatus status = [reachability ne_currentReachabilityStatus];
    
    if (status == ReachableViaWiFi) {
        NSLog(@"切换为WiFi网络");
        //开始直播
        __weak typeof(self) weakSelf = self;
        [_mediaCapture startLiveStream:^(NSError *error) {
            if (error != nil) {
//                [weakSelf showErrorInfo:error ];
            }
        }];
    }else if (status == ReachableViaWWAN) {
        if (_isLiving) {
            //wifi切4G，容易导致底层rtmp socket断开
            //__weak NESelectionView *weakSelectView = self.selectView;
            [_mediaCapture stopLiveStream:^(NSError *error) {
                if(error == nil){
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        _isLiving = NO;
                        self.startButton.hidden = NO;
                        //[weakSelectView.startBtn setBackgroundImage:[UIImage imageNamed:@"restart"] forState:UIControlStateNormal];
                    });
                }
            }];
        }
        NSLog(@"切换为移动网络");
        //提醒用户当前网络为移动网络，是否开启直播
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:csnation(@"提示") message:csnation(@"当前网络为移动网络，是否开启直播") delegate:self cancelButtonTitle:csnation(@"确定") otherButtonTitles:csnation(@"取消"), nil];
        [alert showAlertWithCompletionHandler:^(NSInteger i) {
            if (i == 0) {
                //开始直播
                __weak typeof(self) weakSelf = self;
                [_mediaCapture startLiveStream:^(NSError *error) {
                    if (error != nil) {
                        //[weakSelf showErrorInfo:error ];
                    }
                }];
            }
        }];
    }else if(status == NotReachable) {
        NSLog(@"网络已断开");
        //释放资源
        if (_isLiving) {
            //__weak NESelectionView *weakSelectView = self.selectView;
            [_mediaCapture stopLiveStream:^(NSError *error) {
                if(error == nil){
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        _isLiving = NO;
                        self.startButton.hidden = NO;
                        //[weakSelectView.startBtn setBackgroundImage:[UIImage imageNamed:@"restart"] forState:UIControlStateNormal];
                    });
                }
            }];
        }
    }
}

//显示错误消息
//-(void)showErrorInfo:(NSError*)error
//{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSString *errMsg = @"";
//        if(error == nil){
//            errMsg = @"推流过程中发生错误，请尝试重新开启";
//
//        }else if([error class] == [NSError class]){
//            errMsg = [error localizedDescription];
//        }else{
//            NSLog(@"error = %@", error);
//        }
//        self.errorInfoView.message = errMsg;
//
//        [self.errorInfoView show];
//        self.selectView.startBtn.enabled = YES;
//
//        _isLiving = NO;
//
//        [self.selectView.startBtn setBackgroundImage:[UIImage imageNamed:@"restart"] forState:UIControlStateNormal];
//    });
//}

- (void)makeFunctionView{
    NSArray  *images = @[@"liveTalkText.png",@"liveDefinition.png",@"liveSavePhoto.png",@"liveMakeFace.png",@"liveCammarChage.png"];
    
    for (NSInteger i = 0; i<images.count; i ++) {
        UIButton  *button = [[UIButton alloc] init];
        button.tag = 100+i;
        [button addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, i * (26+20), 26, 26);
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [self.functionView addSubview:button];
    }
}

- (void)functionButtonClick:(UIButton  *)btn{
    switch (btn.tag) {
        case 100://弹幕
        {
            self.messageView.hidden = !self.messageView.hidden;
        }
            break;
        case 101://清晰度
        {
                
        [self.definitionView show];
            
        }
            break;
        case 102://截图
        {
            [self screenCapBtnTapped];
        }
            break;
        case 103://美颜
        {
            [self.liveFaceView show];
            
            //[[[ UIApplication sharedApplication] keyWindow] addSubview :self.smoothSloder];
        }
            break;
        case 104://切换摄像头
        {
            _isBackCameraPosition = [_mediaCapture switchCamera:^{
                NSLog(@"切换摄像头");
            }];
        }
            break;
        default:
            break;
    }
}
//截图
- (void)screenCapBtnTapped {
    CS_Weakify(self, weakSelf);
    [weakSelf.mediaCapture snapShotWithCompletionBlock:^(UIImage *latestFrameImage) {
         UIImageWriteToSavedPhotosAlbum(latestFrameImage, weakSelf, @selector(image:didFinishSavingWithError:contextInfo:), nil);}];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(error)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:csnation(@"提示") message:csnation(@"保存失败") delegate:self cancelButtonTitle:csnation(@"确定") otherButtonTitles:nil, nil];
        [alert showAlertWithCompletionHandler:^(NSInteger index) {
            if (index == 0) {
//                NSLog(csnation(@"保存失败"));
            }
        }];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:csnation(@"提示") message:@"保存成功" delegate:self cancelButtonTitle:csnation(@"确定") otherButtonTitles:nil, nil];
        [alert showAlertWithCompletionHandler:^(NSInteger index) {
            if (index == 0) {
//                NSLog(@"截屏保存到本地相册成功");
            }
        }];
    }
}

//切换清晰度
- (void)CSNewLiveDefinitionViewSelectDefinition:(NSInteger)index{
    LSVideoStreamingQuality quality = paraCtx.videoStreamingQuality;
    switch (index) {
        case 0:
        {
            quality = LS_VIDEO_QUALITY_MEDIUM;
        }
            break;
        case 1:
        {
            quality = LS_VIDEO_QUALITY_HIGH;
        }
            break;
        case 2:
        {
            quality = LS_VIDEO_QUALITY_SUPER;
        }
            break;
        case 3:
        {
            quality = LS_VIDEO_QUALITY_SUPER_HIGH;
        }
            break;
            
        default:
            break;
    }
    //切换分辨率，支持直播过程中切换分辨率，切换分辨率，水印将自动清除，需要外部根据分辨率，再次设置水印大小
    BOOL isSuccess = [_mediaCapture switchVideoStreamingQuality:quality block:^(LSVideoStreamingQuality quality1) {
        //[self addWaterMarkLayer:quality1];
//        [self addDynamicWaterMark:quality1];
    }];
    if (isSuccess) {
        paraCtx.videoStreamingQuality = quality;
        [self.definitionView refreshDefinitionView:index];
    }else{
        switch (paraCtx.videoStreamingQuality) {
            case LS_VIDEO_QUALITY_MEDIUM:
               
                break;
            case LS_VIDEO_QUALITY_HIGH:
               
                break;
            case LS_VIDEO_QUALITY_SUPER:
               
                break;
            case LS_VIDEO_QUALITY_SUPER_HIGH:
                
                break;
            default:
                break;
        }
    }
}

- (void)CSNewLiveFaceView1SelectDefinition:(NSInteger)index{

    switch (index) {
        case 0:
        {
            [_mediaCapture setSmoothFilterIntensity:0.0];
            [_mediaCapture setWhiteningFilterIntensity:0.0];
            [_mediaCapture adjustExposure:0.0];
            self.liveFaceView.smoothSlider.value = 0.0;
            self.liveFaceView.WhiteningSlider.value = 0.0;
            self.liveFaceView.adjustExposureSlider.value = 0.0;
        }
            break;
            
        case 1:
        {

            self.liveFaceView.smoothSlider.valueChanged = ^(QiSlider *slider) {
                slider.valueText = [NSString stringWithFormat:@"%.2f", slider.value];
                [self->_mediaCapture setSmoothFilterIntensity:slider.value];
            };
            
        }
            break;
        case 2:
        {
            self.liveFaceView.WhiteningSlider.valueChanged = ^(QiSlider *slider) {
                slider.valueText = [NSString stringWithFormat:@"%.2f", slider.value];
                [self->_mediaCapture setWhiteningFilterIntensity:slider.value];
            };
        }
            break;
        case 3:
        {
            self.liveFaceView.adjustExposureSlider.valueChanged = ^(QiSlider *slider) {
                slider.valueText = [NSString stringWithFormat:@"%.2f", slider.value];
                [self->_mediaCapture adjustExposure:slider.value];
            };
        }
            break;
            
        default:
            break;
    }
    [self.liveFaceView refreshFaceView1:index];
    
    
    
}
- (void)CSNewLiveFaceView2SelectDefinition:(NSInteger)index{
    switch (index) {
        case 0:
        {
           paraCtx.isVideoFilterOn = NO;
           paraCtx.filterType = LS_GPUIMAGE_NORMAL;
            [_mediaCapture setFilterType:LS_GPUIMAGE_NORMAL];
        }
            break;
        case 1:
        {
            paraCtx.isVideoFilterOn = YES;
            paraCtx.filterType = LS_GPUIMAGE_ZIRAN;
            [_mediaCapture setFilterType:LS_GPUIMAGE_ZIRAN];
        }
            break;
        case 2:
        {
            paraCtx.isVideoFilterOn = YES;
            paraCtx.filterType = LS_GPUIMAGE_MEIYAN1;
            [_mediaCapture setFilterType:LS_GPUIMAGE_MEIYAN1];
        }
            break;
        case 3:
        {
            paraCtx.isVideoFilterOn = YES;
            paraCtx.filterType = LS_GPUIMAGE_MEIYAN2;
            [_mediaCapture setFilterType:LS_GPUIMAGE_MEIYAN2];
        }
            break;
            
        default:
            break;
    }

    
    [self.liveFaceView refreshFaceView2:index];
}
- (void)start{
            [_mediaCapture startLiveStream:^(NSError *error) {
                if (error != nil) {
                    //开始推流，出现错误，首先检查参数和网络是否正常，对应日志查看具体错误内容
//                    [weakSelf showErrorInfo:error ];
//                    dispatch_async(dispatch_get_main_queue(), ^(void){
//                        weakSelf.funcitonView.hidden = YES;
//                    });
                }else{
                    //self.startButton.hidden = YES;
                }
            }];
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        //释放占有的系统资源
        [self->_mediaCapture unInitLiveStream];
        self->_mediaCapture = nil;
    }];
}


#pragma mark - CSIMManagerProtocol Method

- (void)didReceiveMsg:(MQTTMessage*)msg{

    dispatch_async(dispatch_get_main_queue(), ^{

        
        NSError *err;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:msg.payload
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
        NSString * messageType = [dict valueForKey:@"type"];
        NSLog(@"收到消息了:%@",dict);
        if ([messageType isEqualToString:@"message"]) {//发送消息
            CSIMMessageModel * messageModel = [CSIMMessageModel yy_modelWithDictionary:dict];
            CSChatModel * model = [messageModel transformChatModel];

            if (model) {
                [self.messageView addComment:messageModel];

            }
        }else if ([messageType isEqualToString:@"live_reward"]){
            CSIMGiftModel * giftModel = [CSIMGiftModel yy_modelWithDictionary:dict];
            [self.messageView addGift:giftModel];

        }else if ([messageType isEqualToString:@"room_user_count"]){
            NSString * count = [dict valueForKey:@"onLine_user_count"];
//            self.topView.visitorNumLabel.text = count;
        }else if ([messageType isEqualToString:@"user_in"]){
//            NSInteger count = [self.topView.visitorNumLabel.text integerValue];
//            self.topView.visitorNumLabel.text = [@(count+1) stringValue];

        }else if ([messageType isEqualToString:@"user_out"]){
//            NSInteger count = [self.topView.visitorNumLabel.text integerValue];
//            self.topView.visitorNumLabel.text = [@(count-1) stringValue];
        }

    });
}

- (void)didConnected:(MQTTConnectionReturnCode)resultCode{
    if (resultCode == ConnectionAccepted) {
        NSLog(@"连接成功");
        [[CSIMManager sharedManager] subscribeWithTopic:self.mediaModel.topic];

    }
}

- (void)disConnected:(NSInteger)code{
    NSLog(@"断开连接了");
    
    if ([CSIMManager sharedManager].delegate) {
        [[CSIMManager sharedManager] initClient];
        [[CSIMManager sharedManager] connect];
    }

    
}


-(void)dealloc
{
//        _logoView = nil;
//        _selectView = nil;
        _functionView = nil;
    
//        _menuAudioView = nil;//伴奏
//        _menuFilterView = nil;//滤镜
//        _menuWaterMarkView = nil;//水印
//        _errorInfoView = nil;//错误信息动态显示试图
//        _alert = nil;//提醒用户当前正在直播
        localPreview = nil;//相机预览视图
    
//        _allView = nil;
//        _allSegment = nil;
//        _staticInfoView = nil;//统计信息
//        _trackSliderView = nil;//slider
//        _previewMirrorSegment = nil;//镜像
//        _codeMirrorSegment = nil;
//        _changeQuailtySegment = nil;//分辨率
//        _camera = nil;
//        _audioCapture = nil;
        _mediaCapture = nil;
//        _soundTouch = nil;
        paraCtx = nil;
//        _neTimer = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




@end
