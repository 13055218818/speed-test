//
//  CSLivePlayerContainerView.h
//  ColorStar
//
//  Created by gavin on 2020/9/27.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSLivePlayerContainerView;
@protocol CSLivePlayerContainerViewProtocol <NSObject>

- (void)controlViewOnClickQuit:(CSLivePlayerContainerView *)controlView;

- (void)controlViewOnClickPlay:(CSLivePlayerContainerView *)controlView isPlay:(BOOL)isPlay;

- (void)controlViewOnClickSeek:(CSLivePlayerContainerView *)controlView dstTime:(NSTimeInterval)dstTime;

- (void)controlViewOnClickMute:(CSLivePlayerContainerView *)controlView isMute:(BOOL)isMute;

- (void)controlViewOnClickSnap:(CSLivePlayerContainerView *)controlView;

- (void)controlViewOnClickScale:(CSLivePlayerContainerView *)controlView isFill:(BOOL)isFill;

@end

@interface CSLivePlayerContainerView : UIView

@property (nonatomic, assign, readonly) BOOL isDragging; //正在拖拽

@property (nonatomic, assign) NSTimeInterval currentPos; //当前播放时间

@property (nonatomic, assign) NSTimeInterval duration; //视频时长

@property (nonatomic, assign) NSString *fileTitle; //视频标题

@property (nonatomic, assign) BOOL isPlaying; //正在播放

@property (nonatomic, assign) BOOL isBuffing; //正在缓冲

@property (nonatomic, assign) BOOL isAllowSeek; //是否允许seek

@property (nonatomic, weak) id<CSLivePlayerContainerViewProtocol> delegate;

@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *subtitle_ex;
@property (nonatomic, assign) CGSize videoResolution;


@end


