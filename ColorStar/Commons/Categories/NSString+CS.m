//
//  NSString+CS.m
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "NSString+CS.h"
#import "CSAPPConfigManager.h"

@implementation NSString (CS)

+ (BOOL)isNilOrEmpty:(NSString *)str {
    if (!str || ![str isKindOfClass:[NSString class]] || str.length == 0) {
        return YES;
    }
    return NO;
}

- (CGSize)textSizeWithHeight:(CGFloat)heightValue withFont:(UIFont *)font {
    CGSize size = CGSizeZero;
    if (self) {
        CGRect frame = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, heightValue)
                                          options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{ NSFontAttributeName:font }
                                          context:nil];
        
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size;
}

- (CGSize)textSizeWithWidth:(CGFloat)widthValue
                   withFont:(UIFont *)font{
    CGSize size = CGSizeZero;
    if (self) {
        CGRect frame = [self boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX)
                                          options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{ NSFontAttributeName:font }
                                          context:nil];
        
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size;
    
}

- (NSString*)getPrice{
    if ([self isEqualToString:@"0.00"]) {
        return NSLocalizedString(@"免费", nil);
    }
    return self;
}

- (NSString*)getCourse{
    NSString * course = self;
    if ([CSAPPConfigManager sharedConfig].languageType == CSAPPLanuageTypeCN) {
        course = [NSString stringWithFormat:@"共%@节",self];
    }else{
        course = [NSString stringWithFormat:@"%@ sessions",self];
    }
    return course;
}

- (NSString*)getStudyTimes{
    
   NSString * times = self;
       if ([CSAPPConfigManager sharedConfig].languageType == CSAPPLanuageTypeCN) {
           times = [NSString stringWithFormat:@"%@人已学习",self];
       }else{
           times = [NSString stringWithFormat:@"studying by %@ people",self];
       }
    return times;
}

- (NSString*)getPlayCount{
    NSString * playCount = self;
       if ([CSAPPConfigManager sharedConfig].languageType == CSAPPLanuageTypeCN) {
           playCount = [NSString stringWithFormat:@"已播放%@次",self];
       }else{
           playCount = [NSString stringWithFormat:@"viewed %@ times",self];
       }
    return playCount;
}

#pragma mark - Class Method

/**
 *  校验邮箱格式
 *
 *  @param email 邮箱
 *
 *  @return 格式是否正确
 */
+ (BOOL)cs_isEmail:(NSString *)email {
    static NSString * regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:email];
}

/**
 *  严格校验手机号码格式
 *
 *  @param mobileNum 手机号码
 *
 *  @return 格式是否正确
 */
+ (BOOL)cs_isMobileNumber:(NSString *)mobileNum {
    static NSString * regex = @"^((13[0-9])|(15[0-9])|(17[0-9])|(18[0-9])|(14[4,5,6,7,8,9])|(19[8,9])|(166))\\d{8}$"; //@"^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:mobileNum];
}

+ (NSString*)cs_getMonthEngish:(NSString*)month{
    NSInteger monthN = [month integerValue];
    NSString * monthE = @"";
    if (monthN > 0) {
        if (monthN == 1) {
            monthE = @"January";
        }else if (monthN == 2){
            monthE = @"February";
        }else if (monthN == 3){
            monthE = @"March";
        }else if (monthN == 4){
            monthE = @"April";
        }else if (monthN == 5){
            monthE = @"May";
        }else if (monthN == 6){
            monthE = @"June";
        }else if (monthN == 7){
            monthE = @"July";
        }else if (monthN == 8){
            monthE = @"August";
        }else if (monthN == 9){
            monthE = @"September";
        }else if (monthN == 10){
            monthE = @"October";
        }else if (monthN == 11){
            monthE = @"November";
        }else if (monthN == 12){
            monthE = @"December";
        }
    }
    return monthE;
}

@end
