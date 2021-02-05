//
//  CSAvtorImageView.m
//  ColorStar
//
//  Created by gavin on 2020/11/21.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSAvtorImageView.h"

@interface CSAvtorImageView ()

@property (nonatomic, strong)UIImageView * avtorRadiousImageView;

@property (nonatomic, strong)UIImageView * avtorImageView;

@end

@implementation CSAvtorImageView

- (instancetype)init{
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self addSubview:self.avtorRadiousImageView];
    [self addSubview:self.avtorImageView];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.avtorRadiousImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.avtorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(2);
        make.right.bottom.mas_equalTo(-2);
    }];
    
}

- (void)setImage:(UIImage *)image{
    self.avtorImageView.image = image;
}

- (void)sd_setImage:(NSString*)imageString{
    if (![NSString isNilOrEmpty:imageString]) {
        if ([imageString hasPrefix:@"http"]) {
            [self.avtorImageView sd_setImageWithURL:[NSURL URLWithString:imageString]];
        }else{
            NSString *urlString = [NSString stringWithFormat:@"%@%@",[CSAPPConfigManager sharedConfig].baseURL,imageString];
            [self.avtorImageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
        }
        
    }
}

- (void)setBackColor:(UIColor *)backColor{
    self.avtorImageView.backgroundColor = backColor;
}

- (void)setInnerWH:(CGFloat)innerWH{
    _avtorImageView.layer.cornerRadius = (innerWH-4)/2;
}

#pragma mark - Properties Method

- (UIImageView*)avtorRadiousImageView{
    if (!_avtorRadiousImageView) {
        _avtorRadiousImageView = [[UIImageView alloc]init];
        _avtorRadiousImageView.image = LoadImage(@"CS_home_recomendArtisheadRaiduImage");
    }
    return _avtorRadiousImageView;
}

- (UIImageView*)avtorImageView{
    if (!_avtorImageView) {
        _avtorImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _avtorImageView.layer.masksToBounds = YES;
    }
    return _avtorImageView;
}

@end
