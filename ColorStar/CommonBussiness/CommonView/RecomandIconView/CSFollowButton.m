//
//  CSFollowButton.m
//  ColorStar
//
//  Created by gavin on 2020/12/14.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSFollowButton.h"

@implementation CSFollowButton

+ (CSFollowButton*)creatButton{
    CSFollowButton * btn = [CSFollowButton buttonWithType:UIButtonTypeCustom];
    
    return btn;
}

- (void)setup{
    self.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
    ViewRadius(self, self.viewHeight/2);
}

- (void)setIsFollow:(BOOL)isFollow{
    
    NSString * text = nil;
    if (isFollow) {
        text = csnation(@"已关注");
        [self setTitle:text forState:UIControlStateNormal];
        
        UIColor * backColor = LoadColor(@"#D7B393");
        UIColor * textColor = [UIColor colorWithHexString:@"#000000"];
        if (self.type == CSFollowButtonSearch) {
            
            backColor = LoadColor(@"#9B9B9B");
            textColor = LoadColor(@"#FFFFFF");
        }
        [self setTitleColor:textColor forState:UIControlStateNormal];
        [self setBackgroundColor:backColor];
    }else{
        text = csnation(@"关注");
        [self setTitle:text forState:UIControlStateNormal];

        UIColor * backColor = LoadColor(@"#181F30");
        UIColor * textColor = LoadColor(@"#D7B393");
        UIColor * borderColor = LoadColor(@"#D7B393");
        
        if (self.type == CSFollowButtonVideo) {
            backColor = [UIColor clearColor];
            textColor = [UIColor whiteColor];
            borderColor = [UIColor whiteColor];
        }
        ViewBorder(self, borderColor, 1);
        [self setBackgroundColor:backColor];
        [self setTitleColor:textColor forState:UIControlStateNormal];
    }
    
    CGFloat width= [[CSTotalTool sharedInstance] getButtonWidth:text WithFont:self.fontSize WithLefAndeRightMargin:self.sideMargin];
    
     [self mas_updateConstraints:^(MASConstraintMaker *make) {
         make.width.mas_equalTo(width);
     }];
    
}


@end
