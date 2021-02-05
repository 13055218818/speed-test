//
//  CSIMManager.m
//  ColorStar
//
//  Created by gavin on 2020/9/30.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSIMManager.h"
#import "CSNewLoginUserInfoManager.h"


@interface CSIMManager ()

@property (nonatomic, strong)NSMutableArray  * observers;


@end

static CSIMManager * manager = nil;
@implementation CSIMManager

+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CSIMManager alloc]init];
    });
    return manager;
}

- (instancetype)init{
    if (self = [super init]) {
        [self initClient];
    }
    return self;
}

- (void)addIMObserver:(id)obj{
    if (![self.observers containsObject:obj]) {
        [self.observers addObject:obj];
    }
    
}

- (void)removeIMObserver:(id)obj{
    if ([self.observers containsObject:obj]) {
        [self.observers removeObject:obj];
    }
}

- (void)removeAllObserver{
    [self.observers removeAllObjects];
}

//初始化客户端对象
- (void)initClient{
    if (!self.client) {
        
        if ([[CSNewLoginUserInfoManager sharedManager] isLogin]) {
            [self setupClient];
        }else{
            
            [[CSNewLoginUserInfoManager sharedManager] goToLogin:^(BOOL success) {
                
            }];;
        }
    }
}

- (void)setupClient{
    self.client = [[CSIMClient alloc]initWithClientId:[CSNewLoginUserInfoManager sharedManager].userInfo.uid];
    [self connect];
    
    CS_Weakify(self, weakSelf);
    [self.client.dms setMessageHandler:^(MQTTMessage *message) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            if (self.observers.count > 0) {
//                for (id observer in weakSelf.observers) {
//                    if ([observer respondsToSelector:@selector(didReceiveMsg:)]) {
//                        [observer didReceiveMsg:message];
//                    }
//                }
//            }
            if (weakSelf.delegate) {
                if ([weakSelf.delegate respondsToSelector:@selector(didReceiveMsg:)]) {
                    [weakSelf.delegate didReceiveMsg:message];
                }
            }
        });
        
    }];
    
    [self.client.dms setDisconnectionHandler:^(NSUInteger code) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            if (self.observers.count > 0) {
//                for (id observer in weakSelf.observers) {
//                    if ([observer respondsToSelector:@selector(disConnected:)]) {
//                        [observer disConnected:code];
//                    }
//                }
//            }
            if (weakSelf.delegate) {
                if ([weakSelf.delegate respondsToSelector:@selector(disConnected:)]) {
                    [weakSelf.delegate disConnected:code];
                }
            }
        });
        
    }];
    
}

//连接服务器
- (BOOL)connect{
    
    NSString* address = @"mqtt.dms.aodianyun.com";
    NSString* pubkey = @"pub_8f21a8fc2b79e4abf17af4349be986d5";
    NSString* subkey = @"sub_c2b68e9936fee90c446d5954fd89df58";
    CS_Weakify(self, weakSelf);
    return [self.client.dms connectToHost:address withPubKey:pubkey subKey:subkey completionHandler:^(MQTTConnectionReturnCode code) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            if (self.observers.count > 0) {
//                for (id observer in self.observers) {
//                    if ([observer respondsToSelector:@selector(didConnected:)]) {
//                        [observer didConnected:code];
//                    }
//                }
//
//            }
            if (weakSelf.delegate) {
                if ([weakSelf.delegate respondsToSelector:@selector(didConnected:)]) {
                    [weakSelf.delegate didConnected:code];
                }
            }
        });
        
        
    }];
    
}

//推送消息
- (void)publishTopic:(NSString*)topic content:(NSString*)content{
    
    CS_Weakify(self, weakSelf);
    [self.client.dms publishString:content toTopic:topic completionHandler:^(int mid) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            if (self.observers.count > 0) {
//                for (id observer in self.observers) {
//                    if ([observer respondsToSelector:@selector(didSendMsg:result:)]) {
//                        [observer didSendMsg:content result:mid];
//                    }
//                }
//            }
            
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(didSendMsg:result:)]) {
                [weakSelf.delegate didSendMsg:content result:mid];
            }
        });
        
    }];
    
}

//关注话题
- (void)subscribeWithTopic:(NSString*)topic{
    
    [self.client.dms subscribe:topic withCompletionHandler:^(NSArray *grantedQos) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"订阅了:%@",grantedQos);
        });
        
    }];
}

//取消关注话题
- (void)unSubscribeWithTopic:(NSString*)topic{
    
    [self.client.dms subscribe:topic withCompletionHandler:^(NSArray *grantedQos) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    }];
    
}

//断开连接
- (void)disconnect{
    
    [self.client.dms disconnectWithCompletionHandler:^(NSUInteger code) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    }];
    
}


#pragma mark - Properties Method

- (NSMutableArray*)observers{
    if (!_observers) {
        _observers = [NSMutableArray arrayWithCapacity:0];
    }
    return _observers;
}

@end
