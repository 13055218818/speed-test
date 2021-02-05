//
//  CSLiveClassContainerView.m
//  ColorStar
//
//  Created by gavin on 2020/10/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSLiveClassContainerView.h"
#import <Masonry/Masonry.h>
#import "CSColorStar.h"
#import "UIColor+CS.h"

@implementation CSLiveClassContainerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#121212"];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.image = LoadImage(@"cs_empty_data");
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(80);
    }];
    
    UILabel * label = [[UILabel alloc]init];
    label.text = @"暂无数据";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView);
        make.top.mas_equalTo(imageView.mas_bottom);
    }];
    
    
}

@end
