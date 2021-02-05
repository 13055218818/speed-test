//
//  CSShareModel.h
//  ColorStar
//
//  Created by gavin on 2020/12/19.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseModel.h"

typedef enum : NSUInteger {
    CSShareTypeWXCircle,//微信朋友圈
    CSShareTypeWXChat,//微信聊天
    CSShareTypeFB,//FaceBook
} CSShareType;

@interface CSShareModel : CSBaseModel

@property (nonatomic, strong)UIImage   * shareImage;

@property (nonatomic, strong)UIImage   * icon;

@property (nonatomic, strong)NSString  * text;

@property (nonatomic, assign)CSShareType shareType;

@end


