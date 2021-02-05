//
//  CSLiveModel.m
//  ColorStar
//
//  Created by gavin on 2020/10/10.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSLiveModel.h"
#import <YYModel.h>
#import <YYText/YYText.h>
#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "CSLiveRewardModel.h"

@implementation CSLiveGoldInfoModel


@end

@implementation CSLiveWorkermanModel


@end


@implementation CSLiveOpenCommentDetailModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"commonId":@"id"};
}

- (CSChatModel*)transformChatModel{
    CSChatModel * model = [[CSChatModel alloc]init];
    model.messageType = CSMessageTypeSendToMe;
    model.iconName = self.avatar;
    model.sendName = self.nickname;
    
    NSMutableAttributedString * text = [[NSMutableAttributedString alloc]initWithString:self.content attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:16.0f]}];
    if (self.gift_image.length > 0) {
        
        NSMutableAttributedString * gitfName = [[NSMutableAttributedString alloc]initWithString:self.content attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:16.0f]}];
        [text appendAttributedString:gitfName];
        UIImageView * imageView = [[UIImageView alloc]init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.gift_image]];
        imageView.frame = CGRectMake(0, 0, 16, 16);
        NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:imageView.frame.size alignToFont:[UIFont systemFontOfSize:16] alignment:YYTextVerticalAlignmentBottom];
        [text appendAttributedString:attachText];
        NSMutableAttributedString * count = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"X%@",self.gift_num] attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:16.0f]}];
        [text appendAttributedString:count];
        model.attributeString = text;
        
    }
    model.attributeString = text;
    return model;
}

@end


@implementation CSLiveOpenCommentModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"list" : [CSLiveOpenCommentDetailModel class]};
}

@end

@implementation CSLiveModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"live_gift":[CSLiveGiftModel class]};
}


@end
