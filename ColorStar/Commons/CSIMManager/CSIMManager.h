//
//  CSIMManager.h
//  ColorStar
//
//  Created by gavin on 2020/9/30.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSIMClient.h"

@protocol CSIMManagerProtocol <NSObject>

- (void)didReceiveMsg:(MQTTMessage*)msg;//收到消息

- (void)didSendMsg:(NSString*)msg result:(int)code;//发送消息结束

- (void)didConnected:(MQTTConnectionReturnCode)resultCode;//连接回调

- (void)disConnected:(NSInteger)code;//断开连接回调

@end

typedef void(^CSIMConnectComplete)(MQTTConnectionReturnCode code);

@interface CSIMManager : NSObject

@property (nonatomic,strong)CSIMClient  * client;

@property (nonatomic, weak)id<CSIMManagerProtocol> delegate;

+ (instancetype)sharedManager;

//初始化客户端对象
- (void)initClient;

//连接服务器
- (BOOL)connect;

//推送消息
- (void)publishTopic:(NSString*)topic content:(NSString*)content;

//关注话题
- (void)subscribeWithTopic:(NSString*)topic;

//取消关注话题
- (void)unSubscribeWithTopic:(NSString*)topic;

//断开连接
- (void)disconnect;

@end


