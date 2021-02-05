//
//  CSLiveSurfaceView.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorLiveSurfaceView.h"
#import "CSColorStar.h"
#import "UIColor+CS.h"
#import "CSTutorLiveSurfaceTopView.h"
#import "CSTutorLiveSurfaceMessageView.h"
#import "CSTutorLiveSurfaceBottomView.h"
#import "CSKeyBoardInputView.h"
#import "CSLiveGiftSelectedView.h"
#import "CSIMManager.h"
#import "CSIMMessageModel.h"
#import "CSIMGiftModel.h"
#import "CSNewLoginUserInfoManager.h"
#import "CSNetworkManager.h"
#import "CSTutorLiveManager.h"
#import "CSShareManager.h"
#import "CSTutorLiveViewController.h"


@interface CSTutorLiveSurfaceView ()<CSIMManagerProtocol>

@property (nonatomic, strong)UIView  * statusBar;

@property (nonatomic, strong)CSTutorLiveSurfaceTopView      * topView;//92

@property (nonatomic, strong)CSTutorLiveSurfaceMessageView  * middleView;

@property (nonatomic, strong)CSTutorLiveSurfaceBottomView   * bottomView;

@property (nonatomic, strong)CSKeyBoardInputView  * inputView;

@end

@implementation CSTutorLiveSurfaceView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    self.statusBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, kStatusBarHeight)];
    self.statusBar.backgroundColor = LoadColor(@"#181F30");
    [self addSubview:self.statusBar];
    
    CS_Weakify(self, weakSelf);
    self.topView = [[CSTutorLiveSurfaceTopView alloc]initWithFrame:CGRectMake(0, self.statusBar.bottom, self.width, 92)];
    [self.topView mockData];
    [self addSubview:self.topView];
    self.topView.topBlock = ^(CSTutorLiveSurfaceTopViewBlockType type) {
        [weakSelf dealTopViewBlock:type];
    };
    
    
    self.bottomView = [[CSTutorLiveSurfaceBottomView alloc]initWithFrame:CGRectMake(0, self.height - kSafeAreaBottomHeight - 54 , self.width, 54)];
    
    [self addSubview:self.bottomView];
    
    self.middleView = [[CSTutorLiveSurfaceMessageView alloc]initWithFrame:CGRectMake(0, self.bottomView.top - 330*heightScale, self.width, 330*heightScale)];
    [self addSubview:self.middleView];


    self.bottomView.clickBlock = ^(CSTutorLiveSurfaceBottomType type, id obj) {
        [weakSelf dealBottomViewBlock:type data:obj];
    };
    
    self.inputView = [[CSKeyBoardInputView alloc]initWithFrame:CGRectMake(0, ScreenH, self.width, 46)];
    self.inputView.placeHolder = csnation(@"主播我好喜欢你啊～");
    [self addSubview:self.inputView];
    self.inputView.inputBlock = ^(NSString *content) {
        [weakSelf sendContent:content];
    };
}


- (void)setLiveModel:(CSTutorLiveModel *)liveModel{
    _liveModel = liveModel;

    self.topView.liveModel = _liveModel;
    self.bottomView.hasAttention = _liveModel.is_follow;
    [self.middleView initComments:liveModel.OpenComment.list];
    [[CSIMManager sharedManager] initClient];
    [[CSIMManager sharedManager] connect];
    [CSIMManager sharedManager].delegate = self;
}

- (void)setVistors:(NSArray *)vistors{
    self.topView.vistors = vistors;
}

//- (void)removeFromSuperview{
//    if (self.topView.clickCount > 0) {
//        [[CSTutorLiveManager shared] uploadLiveCount:self.topView.clickCount liveId:self.liveModel.liveInfo.liveId complete:^(CSNetResponseModel *response, NSError *error) {
//
//            }];
//    }
//
//}



#pragma mark - CSIMManagerProtocol Method
/**
 {"type":"live_reward","uid":1,"live_gift_id":171,"live_gift_num":1,"live_id":"15","special_id":26}
 这个是打赏礼物的消息体
 */
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
                [self.middleView addComment:messageModel];
                
            }
        }else if ([messageType isEqualToString:@"live_reward"]){
            CSIMGiftModel * giftModel = [CSIMGiftModel yy_modelWithDictionary:dict];
            [self.middleView addGift:giftModel];
            
        }else if ([messageType isEqualToString:@"room_user_count"]){
            NSString * count = [dict valueForKey:@"onLine_user_count"];
            self.topView.visitorNumLabel.text = count;
        }else if ([messageType isEqualToString:@"user_in"]){
            NSInteger count = [self.topView.visitorNumLabel.text integerValue];
            self.topView.visitorNumLabel.text = [@(count+1) stringValue];
            
        }else if ([messageType isEqualToString:@"user_out"]){
            NSInteger count = [self.topView.visitorNumLabel.text integerValue];
            self.topView.visitorNumLabel.text = [@(count-1) stringValue];
        }
        
    });
}

- (void)didConnected:(MQTTConnectionReturnCode)resultCode{
    if (resultCode == ConnectionAccepted) {
        NSLog(@"连接成功");
        [[CSIMManager sharedManager] subscribeWithTopic:self.liveModel.liveInfo.topic];
        
    }
}

- (void)disConnected:(NSInteger)code{
    NSLog(@"断开连接了");
    
    if ([CSIMManager sharedManager].delegate) {
        [[CSIMManager sharedManager] initClient];
        [[CSIMManager sharedManager] connect];
    }

    
}

#pragma mark - Private Method

- (void)followLive{

    [self.topView clickLike];
    
}

- (void)dealTopViewBlock:(CSTutorLiveSurfaceTopViewBlockType)type{
    
    if (type == CSTutorLiveSurfaceTopViewBlockTypeBack) {
        if (self.surfaceBlock) {
            self.surfaceBlock(CSTutorLiveSurfaceViewTypeBack);
        }
    }else if (type == CSTutorLiveSurfaceTopViewBlockTypeMore){
        if (self.surfaceBlock) {
            self.surfaceBlock(CSTutorLiveSurfaceViewTypeBack);
        }
    }else if (type == CSTutorLiveSurfaceTopViewBlockTypeFollow){
        [self followLive];
    }
}

- (void)dealBottomViewBlock:(CSTutorLiveSurfaceBottomType)type data:(id)obj{
    
    if (!self.liveModel) {
        [csnation(@"获取直播信息失败") showAlert];
        return;
    }
    CS_Weakify(self, weakSelf);
    if (type == CSTutorLiveSurfaceBottomTypeKeyBoard) {//键盘
        [self.inputView startComment];
    }else if (type == CSTutorLiveSurfaceBottomTypeGift){//礼物
        CSLiveGiftSelectedView * giftView = [[CSLiveGiftSelectedView alloc]initWithFrame:self.window.bounds giftlist:self.liveModel.live_gift];
        giftView.goldCount = [CSNewLoginUserInfoManager sharedManager].userInfo.now_money;;
        giftView.giveClick = ^(NSString *giftCount, NSString *giftId, NSString * giftName,NSString * giftPrice,NSString *giftImage) {
            [weakSelf sendGift:giftCount giftId:giftId giftName:giftName giftPrice:giftPrice giftImage:giftImage];
        };
        __block CSLiveGiftSelectedView *strongGift = giftView;
        giftView.rechargeClick = ^{
            [[CSNewPayManage sharedManager] gotoGoldPayWithPay:^(BOOL success) {
                            if (success) {
                                [[CSNewLoginNetManager  sharedManager] getUserInfoWithTokenComplete:^(CSNetResponseModel * _Nonnull response) {
                                    if (response.code == 200) {
                                        NSDictionary  *dict = response.data;
                                        CSNewLoginModel *model= [CSNewLoginModel yy_modelWithDictionary:dict];
                                        [CSNewLoginUserInfoManager sharedManager].userInfo = model;
                                        if ([[UIViewController currentViewController] isKindOfClass:[CSTutorLiveViewController class]]) {
                                            strongGift.goldCount = model.now_money;

                                        }
                                    }
                                    
                                } failureComplete:^(NSError * _Nonnull error) {
                                    
                                }];
                            };
                        }];
            
        };
        [self addSubview:giftView];
        
        
    }else if (type == CSTutorLiveSurfaceBottomTypeAttention){//关注
        [self followLive];
        
        
    }else if (type == CSTutorLiveSurfaceBottomTypeShare){//分享
        [[CSShareManager shared] showShareView];
    }
}

- (void)sendContent:(NSString*)content{
    [self.inputView endComment];
    
    CSIMMessageModel * model = [[CSIMMessageModel alloc]init];
    model.message = content;
    model.m_type = @"1";
    model.type = @"message";
    model.user_type = @"2";
    CSIMMessageSenderModel * senderModel = [[CSIMMessageSenderModel alloc]init];
    senderModel.nickname = [CSNewLoginUserInfoManager sharedManager].userInfo.nickname;
    senderModel.avatar = [CSNewLoginUserInfoManager sharedManager].userInfo.avatar;
    model.userInfo = senderModel;
    NSString * mgs = [model yy_modelToJSONString];
    
    
    [[CSNetworkManager sharedManager] uploadMessage:content liveId:self.liveModel.liveInfo.liveId messageType:@"1" successComplete:^(CSNetResponseModel *response) {
        if (response.code == 200) {
            [[CSIMManager sharedManager] publishTopic:self.liveModel.liveInfo.topic content:mgs];
        }
        
    } failureComplete:^(NSError *error) {
        
    }];
    
}

//赠送礼物
- (void)sendGift:(NSString*)count giftId:(NSString*)giftId giftName:(NSString*)giftName giftPrice:(NSString*)giftPrice giftImage:(NSString*)giftImage{
    
    CSIMGiftModel * giftModel = [[CSIMGiftModel alloc]init];
    giftModel.live_gift_id = giftId;
    giftModel.live_gift_num = count;
    giftModel.live_id = self.liveModel.liveInfo.liveId;
    giftModel.special_id = self.liveModel.liveInfo.special_id;
    giftModel.user_avatar = [CSNewLoginUserInfoManager sharedManager].userInfo.avatar;
    giftModel.username = [CSNewLoginUserInfoManager sharedManager].userInfo.nickname;
    giftModel.type = @"live_reward";
    giftModel.user_type = @"2";
    giftModel.recharge_status = @"1";
    giftModel.live_gift_name = giftName;
    giftModel.live_gift_image = giftImage;
    NSString * giftMsg = [giftModel yy_modelToJSONString];
    

    [[CSNetworkManager sharedManager] uploadGift:giftId gitfNum:count liveId:self.liveModel.liveInfo.liveId successComplete:^(CSNetResponseModel *response) {
        if (response.code == 200) {
            NSInteger cost = [count integerValue] * [giftPrice integerValue];
            NSInteger left = [[CSNewLoginUserInfoManager sharedManager].userInfo.now_money integerValue] - cost;
            [CSNewLoginUserInfoManager sharedManager].userInfo.now_money = [NSString stringWithFormat:@"%ld",(long)left];
            [[CSIMManager sharedManager] publishTopic:self.liveModel.liveInfo.topic content:giftMsg];
        }
        } failureComplete:^(NSError *error) {
            
        }];
}


- (void)dealloc{
    
}

@end
