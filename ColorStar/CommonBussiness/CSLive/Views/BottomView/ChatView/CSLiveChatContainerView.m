//
//  CSLiveChatContainerView.m
//  ColorStar
//
//  Created by gavin on 2020/10/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSLiveChatContainerView.h"
#import "CSIMManager.h"
#import "CSChatTableCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "CSChatKeyBoard.h"
#import "CSColorStar.h"
#import "UIColor+CS.h"
#import <Masonry/Masonry.h>
#import "SDAnalogDataGenerator.h"
#import "CSIMMessageModel.h"
#import <YYModel/YYModel.h>
#import "CSLoginManager.h"
#import "CSNetworkManager.h"
#import "CSLiveGiftSelectedView.h"
#import "CSIMGiftModel.h"
#import "NSString+CSAlert.h"
#import <SDWebImage/SDWebImageDownloader.h>

NSString  * const CSChatTableCellReuseIdentifier = @"CSChatTableCellReuseIdentifier";

@interface CSLiveChatContainerView ()<CSIMManagerProtocol,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView      * chatTableView;
//#53D16B
@property (nonatomic, strong)UILabel          * liveNumberLabel;

@property (nonatomic, strong)CSChatKeyBoard   * keyboard;

@property (nonatomic, strong)NSMutableArray   * chatList;

@property (nonatomic, strong)UIButton         * giftBtn;

@end

@implementation CSLiveChatContainerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    self.chatTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
    [self.chatTableView registerClass:[CSChatTableCell class] forCellReuseIdentifier:CSChatTableCellReuseIdentifier];
    self.chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.chatTableView];
    
    self.liveNumberLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.liveNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.liveNumberLabel.backgroundColor = [UIColor colorWithHexString:@"#53D16B"];
    self.liveNumberLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.liveNumberLabel.font = [UIFont systemFontOfSize:13.0f];
    self.liveNumberLabel.layer.masksToBounds = YES;
    self.liveNumberLabel.layer.cornerRadius = 15;
    [self addSubview:self.liveNumberLabel];
    
    self.giftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.giftBtn setImage:LoadImage(@"cs_live_gift_enter") forState:UIControlStateNormal];
    [self.giftBtn addTarget:self action:@selector(giftClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.giftBtn];
    
    [self addSubview:self.keyboard];
    
    self.chatTableView.frame = CGRectMake(0, 0, self.width, self.height - defaultMsgBarHeight);
    
    [self.liveNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(self).offset(20);
        make.top.mas_equalTo(self).offset(30);
    }];
    
    self.keyboard.frame = CGRectMake(0, self.height - defaultMsgBarHeight, self.width, CTKEYBOARD_DEFAULTHEIGHT);
    self.keyboard.containerHeight = self.height;
    
    [self.giftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-20);
        make.bottom.mas_equalTo(self).offset(-(20 + defaultMsgBarHeight));
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    
    //系统键盘弹起通知
    [[NSNotificationCenter defaultCenter]addObserver:self.keyboard selector:@selector(systemKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self.keyboard selector:@selector(systemKeyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self.keyboard selector:@selector(keyboardResignFirstResponder:) name:ChatKeyboardResign object:nil];
}

- (void)setLiveModel:(CSLiveModel *)liveModel{
    _liveModel = liveModel;
    self.liveNumberLabel.text = [NSString stringWithFormat:@"%@人在观看",_liveModel.UserSum];
    [self loadCommons];
}

- (void)loadCommons{
    
    NSMutableArray * commones = [NSMutableArray arrayWithCapacity:0];
    for (CSLiveOpenCommentDetailModel * common in self.liveModel.OpenComment.list) {
        
        CSChatModel * model = [common transformChatModel];
        [commones insertObject:model atIndex:0];
    }
    [self.chatList removeAllObjects];
    [self.chatList addObjectsFromArray:commones];
    [self.chatTableView reloadData];
    [self scrollToBottom];
    //https://color.ehxkc.com/wap/Login/jsondata/api/valid_sessionkey
}

- (void)makeMockData{
    for (int i = 0; i < 20; i++) {
        CSChatModel *model = [CSChatModel new];
        model.messageType = arc4random_uniform(2);
        if (model.messageType) {
            model.iconName = [SDAnalogDataGenerator randomIconImageName];
            if (arc4random_uniform(10) > 5) {
                int index = arc4random_uniform(5);
                model.imageName = [NSString stringWithFormat:@"test%d.jpg", index];
            }
        } else {
            if (arc4random_uniform(10) < 5) {
                int index = arc4random_uniform(5);
                model.imageName = [NSString stringWithFormat:@"test%d.jpg", index];
            }
            model.iconName = @"2.jpg";
        }
        
        
//        model.text = [SDAnalogDataGenerator randomMessage];
        [self.chatList addObject:model];
    }
    
    [self scrollToBottom];
}


- (void)scrollToBottom{
    NSIndexPath * lastIndexPath = [NSIndexPath indexPathForRow:self.chatList.count - 1 inSection:0];
    [self.chatTableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}


#pragma mark - tableview delegate and datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.chatList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CSChatTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CSChatTableCellReuseIdentifier];
    cell.model = self.chatList[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    [cell setDidSelectLinkTextOperationBlock:^(NSString *link, MLEmojiLabelLinkType type) {
        
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat h = [tableView cellHeightForIndexPath:indexPath model:self.chatList[indexPath.row] keyPath:@"model" cellClass:[CSChatTableCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
    return h;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter]postNotificationName:ChatKeyboardResign object:nil];
}

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
                [self.chatList addObject:model];
                [self.chatTableView reloadData];
                [self scrollToBottom];
            }
        }else if ([messageType isEqualToString:@"live_reward"]){
            CSIMGiftModel * giftModel = [CSIMGiftModel yy_modelWithDictionary:dict];
            NSString * giftImage = [self loadGiftImageURL:giftModel.live_gift_id];
            NSString * giftName = [self loadGiftName:giftModel.live_gift_id];
            giftModel.live_gift_name = giftName;
            if (giftImage) {
                [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:giftImage] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                    if (image && !err) {
                        
                        CSChatModel * chateModel = [giftModel transformChatModelWithGiftImage:image];
                        
                        if (chateModel) {
                            [self.chatList addObject:chateModel];
                            [self.chatTableView reloadData];
                            [self scrollToBottom];
                        }
                        
                        
                    }
                                    
                                }];
                
            }
            
            
            
            
        }else if ([messageType isEqualToString:@"room_user_count"]){
            NSString * count = [dict valueForKey:@"onLine_user_count"];
            self.liveNumberLabel.text = [NSString stringWithFormat:@"%@人在观看",count];
        }
        
    });
}

- (void)didSendMsg:(NSString*)msg result:(int)code{
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        CSChatModel * model = [[CSChatModel alloc]init];
//        model.messageType = CSMessageTypeSendToOthers;
//        model.text = msg;
//        [self.chatList addObject:model];
//        [self.chatTableView reloadData];
//    });
    
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


- (void)mockSend{
    CSIMMessageModel * model = [[CSIMMessageModel alloc]init];
    model.message = @"现在用户信息有数据了";
    model.m_type = @"1";
    model.type = @"message";
    model.user_type = @"2";
    CSIMMessageSenderModel * senderModel = [[CSIMMessageSenderModel alloc]init];
    senderModel.nickname = @"莱";
    senderModel.avatar = @"http://thirdwx.qlogo.cn/mmopen/yhZQjNNOKR5e1x4Xic1C3bev7hNwQ1sl3JJIQRRhwo5Q4dODuicRpSibUeaLFHUPvVnWQzicmbRvEVaAlMmzJsxsgw/132";
    model.userInfo = senderModel;
    NSString * mgs = [model yy_modelToJSONString];
    
    [[CSIMManager sharedManager] publishTopic:@"room15" content:mgs];
    
}

#pragma mark - Action Method

- (void)sendMsg:(NSString*)msg{
    
    CSIMMessageModel * model = [[CSIMMessageModel alloc]init];
    model.message = msg;
    model.m_type = @"1";
    model.type = @"message";
    model.user_type = @"2";
    CSIMMessageSenderModel * senderModel = [[CSIMMessageSenderModel alloc]init];
    senderModel.nickname = [CSLoginManager sharedManager].userInfo.nickname;
    senderModel.avatar = [CSLoginManager sharedManager].userInfo.avatar;
    model.userInfo = senderModel;
    NSString * mgs = [model yy_modelToJSONString];
    
    [[CSIMManager sharedManager] publishTopic:self.liveModel.liveInfo.topic content:mgs];
    
    [[CSNetworkManager sharedManager] uploadMessage:msg liveId:self.liveModel.liveInfo.liveId messageType:@"1" successComplete:^(CSNetResponseModel *response) {
        
    } failureComplete:^(NSError *error) {
        
    }];
    
}

- (void)keyBoardFrameChange:(CGRect)frame{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.chatTableView.height = frame.origin.y;
    } completion:^(BOOL finished) {
        [self scrollToBottom];
    }];
    
}

- (void)giftClick{
    
    CSLiveGiftSelectedView * giftView = [[CSLiveGiftSelectedView alloc]initWithFrame:self.window.bounds giftlist:self.liveModel.live_gift];
    
    giftView.giveClick = ^(NSString *giftCount, NSString *giftId, NSString * giftName,NSString * giftPrice,NSString * giftImage) {
        [self sendGift:giftCount giftId:giftId giftName:giftName giftPrice:giftPrice];
    };
    [self.window addSubview:giftView];
}

//赠送礼物
- (void)sendGift:(NSString*)count giftId:(NSString*)giftId giftName:(NSString*)giftName giftPrice:(NSString*)giftPrice{
    
    CSIMGiftModel * giftModel = [[CSIMGiftModel alloc]init];
    giftModel.live_gift_id = giftId;
    giftModel.live_gift_num = count;
    giftModel.live_id = self.liveModel.liveInfo.liveId;
    giftModel.special_id = self.liveModel.liveInfo.special_id;
    giftModel.user_avatar = [CSLoginManager sharedManager].userInfo.avatar;
    giftModel.username = [CSLoginManager sharedManager].userInfo.nickname;
    giftModel.type = @"live_reward";
    giftModel.user_type = @"2";
    giftModel.recharge_status = @"1";
    NSString * giftMsg = [giftModel yy_modelToJSONString];
    
    [[CSIMManager sharedManager] publishTopic:self.liveModel.liveInfo.topic content:giftMsg];

    [[CSNetworkManager sharedManager] uploadGift:giftId gitfNum:count liveId:self.liveModel.liveInfo.liveId successComplete:^(CSNetResponseModel *response) {
        if (response.code == 200) {
//            NSInteger cost = [count integerValue] * [giftPrice integerValue];
//            NSInteger left = [[CSLoginManager sharedManager].userInfo.gold_num integerValue] - cost;
//            [CSLoginManager sharedManager].userInfo.gold_num = [NSString stringWithFormat:@"%ld",left];
        }
        } failureComplete:^(NSError *error) {
            
        }];
    
}

#pragma mark - Private Method

- (NSString*)loadGiftImageURL:(NSString*)giftId{
    NSString * url = nil;
    for (CSLiveGiftModel * gift in self.liveModel.live_gift) {
        if ([gift.giftId isEqualToString:giftId]) {
            url = gift.live_gift_show_img;
            break;
        }
    }
    return url;
}

- (NSString*)loadGiftName:(NSString*)giftId{
    NSString * name = nil;
    for (CSLiveGiftModel * gift in self.liveModel.live_gift) {
        if ([gift.giftId isEqualToString:giftId]) {
            name = gift.live_gift_name;
            break;
        }
    }
    return name;
}

#pragma mark - Properties Method

- (NSMutableArray*)chatList{
    if (!_chatList) {
        _chatList = [NSMutableArray arrayWithCapacity:0];
    }
    return _chatList;
}

- (CSChatKeyBoard*)keyboard{
    if (!_keyboard) {
        _keyboard = [[CSChatKeyBoard alloc]init];
        _keyboard.backgroundColor = [UIColor blackColor];
        CS_Weakify(self, weakSelf);
        [_keyboard textCallback:^(NSString *text) {
            [weakSelf sendMsg:text];
            
        } audioCallback:^(CSChatAlbumModel *audio) {
            
        } picCallback:^(NSArray<CSChatAlbumModel *> *images) {
            
        } videoCallback:^(CSChatAlbumModel *videoModel) {
            
        } target:self];
        
        [_keyboard frameChangeCallback:^(CGRect frame) {
            [weakSelf keyBoardFrameChange:frame];
        }];
    }
    return _keyboard;
}

- (void)registeKeyBoard{
    [[NSNotificationCenter defaultCenter]postNotificationName:ChatKeyboardResign object:nil];
}

- (void)dealloc{
}

@end
