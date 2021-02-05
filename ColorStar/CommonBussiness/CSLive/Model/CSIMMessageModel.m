//
//  CSIMMessageModel.m
//  ColorStar
//
//  Created by gavin on 2020/10/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSIMMessageModel.h"
#import <YYModel.h>
#import "CSLoginManager.h"
#import <UIKit/UIKit.h>

@implementation CSIMMessageSenderModel

@end

@implementation CSIMMessageModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"messageId":@"id"};
}

- (CSChatModel*)transformChatModel{
    
    if ([self.type isEqual:@"message"]) {
        CSChatModel * model = [[CSChatModel alloc]init];
        model.messageType = CSMessageTypeSendToMe;
        
        model.iconName = self.userInfo.avatar;
        model.sendName = self.userInfo.nickname;
        if (self.message.length > 0) {
            model.attributeString = [[NSMutableAttributedString alloc]initWithString:self.message attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:16.0f]}];
        }
        return model;
    }
    
    return nil;
}

@end
