//
//  CSNewLiveDefinitionView.m
//  ColorStar
//
//  Created by apple on 2021/1/13.
//  Copyright © 2021 gavin. All rights reserved.
//

#import "CSNewLiveDefinitionView.h"
@interface CSNewLiveDefinitionView()
@property (nonatomic, strong)NSMutableArray         *buttonArray;
@end

@implementation CSNewLiveDefinitionView
- (void)cs_loadView{
    self.buttonArray = [NSMutableArray array];
    UIView  *bottomView = [[UIView alloc] init];
    bottomView.userInteractionEnabled = YES;
    ViewRadius(bottomView, 10);
    bottomView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.2];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.contentView);
        make.height.mas_offset(130 + kTabBarStatusHeight);
    }];
    
    UILabel  *titleLabel = [[UILabel alloc] init];
    titleLabel.text = csnation(@"清晰度");
    titleLabel.textColor = [UIColor colorWithHexString:@"#007AFF"];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment =NSTextAlignmentCenter;
    [bottomView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomView.mas_left).offset(12);
        make.top.mas_equalTo(bottomView.mas_top).offset(12);
    }];
    
    UIView  *lineView = [[UIView alloc] init];
    lineView.backgroundColor =[UIColor colorWithHexString:@"#007AFF"];
    [bottomView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(titleLabel.mas_centerX);
        make.height.mas_offset(2);
        make.width.mas_offset(20);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(12);
    }];
    
    UIView  *bottomlineView = [[UIView alloc] init];
    bottomlineView.backgroundColor =[UIColor colorWithHexString:@"#808080"];
    [bottomView addSubview:bottomlineView];
    
    [bottomlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom);
        make.height.mas_offset(1/[UIScreen mainScreen].scale);
        make.left.right.mas_equalTo(bottomView);
    }];
    NSArray *titleArray = @[csnation(@"标清"),csnation(@"高清"),csnation(@"超清"),csnation(@"蓝光")];
    for (NSInteger i = 0; i < 4; i ++) {
        UIButton  *button = [[UIButton alloc] init];
        ViewRadius(button, 24);
        button.tag = 100+i;
        if (i==1) {
            button.selected = YES;
            ViewBorder(button, [UIColor colorWithHexString:@"#007AFF"], 1);
        }else{
            button.selected = NO;
        }
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.backgroundColor = [UIColor colorWithHexString:@"#B0B0B0" alpha:0.8];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:button];
        button.frame = CGRectMake(12 + i *(16+48), 60, 48, 48);
        [self.buttonArray addObject:button];
    }
    
    UIButton  *tapButton = [[UIButton alloc] init];
    tapButton.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.0];
    [tapButton addTarget:self action:@selector(tapButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:tapButton];
    [tapButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(bottomView.mas_top);
    }];
}
-(void)tapButtonClick{
    [self cs_doDismiss];
}
- (void)buttonclick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(CSNewLiveDefinitionViewSelectDefinition:)]) {
        [self.delegate CSNewLiveDefinitionViewSelectDefinition:btn.tag-100];
    }
}
- (void)show{
    [self getMaskConfig].maskColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    [super show];
}

- (void)refreshDefinitionView:(NSInteger)index{
    for (UIButton  *btn in self.buttonArray) {
        if (index == btn.tag-100) {
            ViewBorder(btn, [UIColor colorWithHexString:@"#007AFF"], 1);
        }else{
            ViewBorder(btn, [UIColor colorWithHexString:@"#007AFF"], 0);
        }
    }
}

@end
