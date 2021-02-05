//
//  CSTutorLiveMessageModel.m
//  ColorStar
//
//  Created by gavin on 2020/11/21.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorLiveMessageModel.h"

@implementation CSTutorLiveMessageModel

- (NSString*)messageShow{
    if (!_messageShow) {
        _messageShow = [NSString stringWithFormat:@"%@：%@",self.name,self.message];
    }
    return _messageShow;
}

- (NSMutableAttributedString*)attributeMessage{
    
    if (!_attributeMessage) {
        
        _attributeMessage = [[NSMutableAttributedString alloc]initWithString:self.messageShow];
        [_attributeMessage addAttributes:@{NSFontAttributeName:kFont(12.0f)} range:NSMakeRange(0, self.messageShow.length)];
        [_attributeMessage addAttributes:@{NSForegroundColorAttributeName:LoadColor(@"#8DE8FF")} range:NSMakeRange(0, self.name.length + 1)];
        [_attributeMessage addAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(self.name.length, self.message.length)];
    }
    return _attributeMessage;
}


@end
