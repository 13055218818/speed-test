//
//  CSHomeTopicBaseModel.m
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeTopicBaseModel.h"
#import <YYModel.h>
#import "NSString+CS.h"

@implementation CSHomeTopicBaseModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"topicId":@"id"};
}

- (NSString*)author{
    return self.subject_name;
}

- (NSString*)thumbnail{
    return self.image;
}

- (NSString*)price{
    if ([self.money isEqualToString:@"0.00"]) {
        return @"免费";
    }
    return self.money;
}

- (NSString*)courses{
    return [NSString stringWithFormat:@"共%@节",self.count];
}

- (NSString*)studies{
    return [NSString stringWithFormat:@"共%@学习",self.browse_count];
}

- (CSHomeTopicBaseModelType)topicType{
    switch (self.special_type) {
        case 1:
             return CSHomeTopicBaseModelTypeImage;
            break;
        case 2:
             return CSHomeTopicBaseModelTypeAudio;
            break;
        case 3:
             return CSHomeTopicBaseModelTypeVideo;
            break;
        case 4:
             return CSHomeTopicBaseModelTypeLive;
            break;
    }
    return CSHomeTopicBaseModelTypeNone;
}

- (BOOL)showVideo{
    return ![NSString isNilOrEmpty:self.video];
}

@end
