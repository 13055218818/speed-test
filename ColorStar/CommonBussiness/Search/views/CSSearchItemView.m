//
//  CSSearchItemView.m
//  ColorStar
//
//  Created by 陶涛 on 2020/8/13.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSSearchItemView.h"
#import "UIView+CS.h"
#import "NSString+CS.h"
#import <Masonry.h>

typedef void(^CSSearchItemDeleteBlock)(UILabel*label);
@interface CSSearchItemLabel : UILabel

@property (nonatomic, strong)UIButton  * deleteBtn;

@property (nonatomic, copy)CSSearchItemDeleteBlock  deleteBlock;

@end

@implementation CSSearchItemLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleteBtn setImage:LoadImage(@"CSHomeRecommendInterestingBannerDelete") forState:UIControlStateNormal];
    [self.deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.deleteBtn];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_right).offset(-7);
        make.top.mas_equalTo(-7);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    
}

- (void)deleteClick{
    
    if (self.deleteBlock) {
        self.deleteBlock(self);
    }
    
}

@end

@interface CSSearchItemView ()

@property (nonatomic, strong)UILabel  * label;

@property (nonatomic, strong)UIImageView * iconImageView;

@property (nonatomic, strong)UIView   * containerView;

@end

@implementation CSSearchItemView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = LoadColor(@"#181F30");
    }
    return self;
}

- (void)reloadViews{
    
    for (UIView * subView in self.subviews) {
        [subView removeFromSuperview];
    }
    
    if (self.list.count > 0) {
        CGFloat topMargin = 16;
        CGFloat leftMargin = 12;
        self.label = [[UILabel alloc]initWithFrame:CGRectZero];
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont systemFontOfSize:12.0f];
        self.label.text = self.title;
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(leftMargin);
            make.top.mas_equalTo(self).offset(topMargin);
        }];
        
        self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.iconImageView.image = LoadImage(@"CS_home_recomendArtisStatu");
        self.iconImageView.hidden = !self.showHotIcon;
        [self addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.label.mas_right).offset(10);
            make.centerY.mas_equalTo(self.label);
            make.size.mas_equalTo(CGSizeMake(13, 13));
        }];
        
        topMargin += 20;
        self.containerView = [[UIView alloc]initWithFrame:CGRectZero];
        CGPoint lastOrigin = CGPointMake(leftMargin - 10, 10);
        for (int i = 0; i < self.list.count; i ++) {
            NSString * text = self.list[i];
            CSSearchItemLabel * label = [[CSSearchItemLabel alloc]initWithFrame:CGRectZero];
            CGSize  size = [text textSizeWithHeight:20 withFont:[UIFont systemFontOfSize:10.0f]];
            CGFloat width = MIN(size.width + 24, self.width/2);
            label.text = text;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:10.0f];
            label.textAlignment = NSTextAlignmentCenter;
            if (lastOrigin.y + width + 10 > self.width) {
                lastOrigin = CGPointMake(leftMargin, lastOrigin.y + 40);
            }
            label.frame = CGRectMake(lastOrigin.x + 10, lastOrigin.y, width, 24);
            lastOrigin = CGPointMake(lastOrigin.x + width + 10, lastOrigin.y);
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = 12;
            label.backgroundColor = LoadColor(@"#2E3955");
            label.deleteBtn.hidden = YES;
            CS_Weakify(self, weakSelf);
            CS_Weakify(label, weakLabel)
            [label setTapActionWithBlock:^{
                [weakSelf click:weakLabel];
            }];
            
            [label setLongPressActionWithBlock:^{
                if (weakSelf.deleteItem) {
                    weakLabel.deleteBtn.hidden = NO;
                }
            }];
            label.deleteBlock = ^(UILabel *label) {
                [weakSelf deleteText:label.text];
            };
            [self.containerView addSubview:label];
            
        }
        self.containerView.frame = CGRectMake(0, topMargin, self.width, lastOrigin.y + 30);
        [self addSubview:self.containerView];
        self.height = self.containerView.bottom;
        
    }else{
        self.height = 0;
    }
    
    
}
//CSHomeRecommendInterestingBannerDelete
- (void)click:(UILabel*)label{
    if (self.searchClick) {
        self.searchClick(label.text);
    }
}

- (void)deleteText:(NSString*)text{
    if (self.deleteClick) {
        self.deleteClick(text);
    }
}

- (void)setList:(NSArray *)list{
    _list = list;
    [self reloadViews];
}

@end
