//
//  CSChatKeyBoard.h
//  ColorStar
//
//  Created by gavin on 2020/10/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSChatAlbumModel.h"

static NSString *ChatKeyboardResign = @"ChatKeyboardShouldResignFirstResponder"; //键盘失去第一响应者

#define CTKEYBOARD_DEFAULTHEIGHT   273
static const CGFloat defaultMsgBarHeight = 49;  //模态输入框容器 49

//普通文本/表情消息发送回调
typedef void(^ChatTextMessageSendBlock)(NSString *text);
//语音消息发送回调
typedef void(^ChatAudioMesssageSendBlock)(CSChatAlbumModel *audio);
//图片消息发送回调
typedef void(^ChatPictureMessageSendBlock)(NSArray<CSChatAlbumModel *>* images);
//视频消息发送回调
typedef void(^ChatVideoMessageSendBlock)(CSChatAlbumModel *videoModel);

typedef void(^CSKeyBoardFrameChangeBlock)(CGRect frame);

@interface CSChatKeyBoard : UIView

@property (nonatomic, assign)CGFloat containerHeight;

//仅声明,消除警告
- (void)systemKeyboardWillShow:(NSNotification *)note;
//发送消息回调
- (void)textCallback:(ChatTextMessageSendBlock)textCallback audioCallback:(ChatAudioMesssageSendBlock)audioCallback picCallback:(ChatPictureMessageSendBlock)picCallback videoCallback:(ChatVideoMessageSendBlock)videoCallback target:(id)target ;

//frame变化回调
- (void)frameChangeCallback:(CSKeyBoardFrameChangeBlock)frameCallback;

@end


