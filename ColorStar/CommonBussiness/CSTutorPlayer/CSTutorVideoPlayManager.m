//
//  CSVideoPlayManager.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/13.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorVideoPlayManager.h"
#import "CSNetworkManager.h"

static CSTutorVideoPlayManager * manager;
@implementation CSTutorVideoPlayManager

+ (instancetype)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CSTutorVideoPlayManager alloc]init];
    });
    return manager;
}

- (void)fetchVideoInfo:(NSString*)videoId specialId:(NSString*)specialId complete:(CSTutorVideoComplete)complete{
    NSString * url = @"/wap/special/jsondata/api/taskDetail";
    NSDictionary * dict = @{@"id":videoId,@"specialId":specialId,@"token":[CSNetworkManager sharedManager].sessionKey};
    
    [[CSNetworkManager sharedManager] netGetWithURL:url param:dict successComplete:^(CSNetResponseModel *response) {
        if (response && complete) {
            complete(response,nil);
        }
        } failureComplete:^(NSError *error) {
            if (error) {
                complete(nil,error);
            }
        }];
    
}

- (void)commentLike:(NSString*)commentId complete:(CSTutorVideoComplete)complete{
    
    [[CSNetworkManager sharedManager] baseFetchInfo:@"/wap/Task/jsondata/api/addClick" param:@{@"id":commentId} successComplete:^(CSNetResponseModel *response) {
        if (response && complete) {
            complete(response,nil);
        }
        
        } failureComplete:^(NSError *error) {
            if (error && complete) {
                complete(nil,error);
            }
        }];
}

- (void)reply:(NSString*)commentId commenter:(NSString*)commenter videoId:(NSString*)videoId content:(NSString*)content complete:(CSTutorVideoComplete)complete{
    
    NSString * url = @"/wap/Task/jsondata/api/addDiscuss";
    
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithDictionary:@{@"task_id":videoId,@"content":content}];
    if (![NSString isNilOrEmpty:commentId] && ![NSString isNilOrEmpty:commenter]) {
        NSDictionary * exterParams = @{@"rid":commentId,@"ruid":commenter};
        [params addEntriesFromDictionary:exterParams];
    }
    
    [[CSNetworkManager sharedManager] baseFetchInfo:url param:params successComplete:^(CSNetResponseModel *response) {
        if (response && complete) {
            complete(response,nil);
        }
        } failureComplete:^(NSError *error) {
            if (error && complete) {
                complete(nil,error);
            }
        }];
    
}

- (void)fetchReplyCommentList:(NSString*)commentId videoId:(NSString*)videoId complete:(CSTutorVideoComplete)complete{
    NSString * url = @"/wap/Task/jsondata/api/getTwoDiscussList";
    
    NSDictionary * params = @{@"rid":commentId,@"id":videoId};
    [[CSNetworkManager sharedManager] baseFetchInfo:url param:params successComplete:^(CSNetResponseModel *response) {
            if (response && complete) {
                complete(response,nil);
            }
        } failureComplete:^(NSError *error) {
            if (error && complete) {
                complete(nil,error);
            }
        }];
}

- (void)fetchCommentList:(NSString*)videoId page:(NSInteger)page complete:(CSTutorVideoComplete)complete{
    
    NSString * url = @"/wap/Task/jsondata/api/getDiscussList";
    
    NSDictionary * params = @{@"task_id":videoId,@"page":[@(page) stringValue],@"limit":@"10"};
    [[CSNetworkManager sharedManager] baseFetchInfo:url param:params successComplete:^(CSNetResponseModel *response) {
            if (response && complete) {
                complete(response,nil);
            }
        } failureComplete:^(NSError *error) {
            if (error && complete) {
                complete(nil,error);
            }
        }];
    
}

//收藏
- (void)collectVideo:(NSString*)videoId complete:(CSTutorVideoComplete)complete{
    
    NSString * url = @"/wap/special/jsondata/api/taskClick";
    
    NSDictionary * params = @{@"type":@"1",@"id":videoId};
    [[CSNetworkManager sharedManager] baseFetchInfo:url param:params successComplete:^(CSNetResponseModel *response) {
            if (response && complete) {
                complete(response,nil);
            }
        } failureComplete:^(NSError *error) {
            if (error && complete) {
                complete(nil,error);
            }
        }];
    
}

//点赞
- (void)likeVideo:(NSString*)videoId complete:(CSTutorVideoComplete)complete{
    NSString * url = @"/wap/special/jsondata/api/taskClick";
    
    NSDictionary * params = @{@"type":@"2",@"id":videoId};
    [[CSNetworkManager sharedManager] baseFetchInfo:url param:params successComplete:^(CSNetResponseModel *response) {
            if (response && complete) {
                complete(response,nil);
            }
        } failureComplete:^(NSError *error) {
            if (error && complete) {
                complete(nil,error);
            }
        }];
}

@end
