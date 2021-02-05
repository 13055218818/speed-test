//
//  CSCourseTopicModel.m
//  ColorStar
//
//  Created by gavin on 2020/8/8.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSCourseTopicModel.h"
#import <YYModel.h>

@implementation CSCourseTopicModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"topicId":@"id"};
}

- (NSString*)thumbnail{
    return self.image;
}

- (NSString*)subject{
    return self.subject_name;
}

- (NSString*)price{
    if ([self.money isEqualToString:@"0.00"]) {
        return @"免费";
    }
    return self.money;
}

- (NSString*)course{
    return [NSString stringWithFormat:@"共%@节",self.count];
}

- (NSString*)studies{
    return [NSString stringWithFormat:@"%@人已学习",self.browse_count];
}

@end
