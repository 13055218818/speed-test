//
//  CSVideoPlayManager.h
//  ColorStar
//
//  Created by 陶涛 on 2020/11/13.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNetResponseModel.h"


typedef void(^CSTutorVideoComplete)(CSNetResponseModel * response, NSError*error);

@interface CSTutorVideoPlayManager : NSObject

+ (instancetype)shared;

- (void)fetchVideoInfo:(NSString*)videoId specialId:(NSString*)specialId complete:(CSTutorVideoComplete)complete;

- (void)commentLike:(NSString*)commentId complete:(CSTutorVideoComplete)complete;

- (void)reply:(NSString*)commentId commenter:(NSString*)commenter videoId:(NSString*)videoId content:(NSString*)content complete:(CSTutorVideoComplete)complete;

- (void)fetchReplyCommentList:(NSString*)commentId videoId:(NSString*)videoId complete:(CSTutorVideoComplete)complete;

- (void)fetchCommentList:(NSString*)videoId page:(NSInteger)page complete:(CSTutorVideoComplete)complete;

//收藏
- (void)collectVideo:(NSString*)videoId complete:(CSTutorVideoComplete)complete;

//点赞
- (void)likeVideo:(NSString*)videoId complete:(CSTutorVideoComplete)complete;
@end


