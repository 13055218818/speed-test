//
//  CSIMGiftModel.m
//  ColorStar
//
//  Created by gavin on 2020/10/13.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSIMGiftModel.h"
#import <YYModel/YYModel.h>
#import <YYText/YYText.h>

@implementation CSIMGiftModel

- (instancetype)init{
    if (self = [super init]) {
        _type = @"live_reward";
    }
    return self;
}

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"giftId":@"id"};
}

-(CSChatModel*)transformChatModelWithGiftImage:(UIImage*)giftImage{
    
    CSChatModel * model = [[CSChatModel alloc]init];
    model.messageType = CSMessageTypeSendToMe;
    
    model.iconName = self.user_avatar;
    model.sendName = self.username;
//    model.text = self.message;
    NSMutableAttributedString * text = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"赠送给主播%@",self.live_gift_name] attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:16.0f]}];
    UIImageView * imageView = [[UIImageView alloc]initWithImage:giftImage];
    imageView.frame = CGRectMake(0, 0, 16, 16);
    NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:imageView.frame.size alignToFont:[UIFont systemFontOfSize:16] alignment:YYTextVerticalAlignmentBottom];
    [text appendAttributedString:attachText];
    NSMutableAttributedString * count = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"X%@",self.live_gift_num] attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:16.0f]}];
    [text appendAttributedString:count];
    model.attributeString = text;
    return model;
    
}

@end
