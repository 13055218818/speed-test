//
//  CSNewLiveFaceView.m
//  ColorStar
//
//  Created by apple on 2021/1/13.
//  Copyright © 2021 gavin. All rights reserved.
//

#import "CSNewLiveFaceView.h"
@interface CSNewLiveFaceView()
@property (nonatomic, strong)NSMutableArray         *buttonArray1;
@property (nonatomic, strong)NSMutableArray         *buttonArray2;

//@property (nonatomic, strong)UILabel                *leftLabel;
//@property (nonatomic, strong)UILabel                *rightLabel;
//@property (nonatomic, strong)UIView                 *bottonButtonView1;
//@property (nonatomic, strong)UIView                 *bottonButtonView2;
//@property (nonatomic, strong)UIView                 *bottomView;
//@property (nonatomic, strong)UIView                 *lineView ;
@end

@implementation CSNewLiveFaceView
- (void)cs_loadView{
     self.buttonArray1 = [NSMutableArray array];
     self.buttonArray2 = [NSMutableArray array];
     self.contentView.userInteractionEnabled = YES;
    
    UIView *bottomView= [[UIView alloc] init];
    bottomView.userInteractionEnabled = YES;
    ViewRadius(bottomView, 10);
    bottomView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.2];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.contentView);
        make.height.mas_offset(130 + kTabBarStatusHeight);
    }];
    
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.text = csnation(@"美颜");

    leftLabel.textColor = [UIColor colorWithHexString:@"#007AFF"];
    leftLabel.font = [UIFont systemFontOfSize:16];
    leftLabel.textAlignment =NSTextAlignmentCenter;
    [bottomView addSubview:leftLabel];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomView.mas_left).offset(12);
        make.top.mas_equalTo(bottomView.mas_top).offset(12);
    }];
    
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.text = csnation(@"滤镜");

     rightLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
     rightLabel.font = [UIFont systemFontOfSize:14];
     rightLabel.textAlignment =NSTextAlignmentCenter;
     [bottomView addSubview: rightLabel];
     [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo( leftLabel.mas_centerY);
        make.left.mas_equalTo( leftLabel.mas_right).offset(18);
    }];
    
    UIView* lineView = [[UIView alloc] init];
     lineView.backgroundColor =[UIColor colorWithHexString:@"#007AFF"];
     [bottomView addSubview: lineView];
    
     [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo( leftLabel.mas_centerX);
        make.height.mas_offset(2);
        make.width.mas_offset(20);
        make.top.mas_equalTo( leftLabel.mas_bottom).offset(12);
    }];
    
    UIView  *bottomlineView = [[UIView alloc] init];
    bottomlineView.backgroundColor =[UIColor colorWithHexString:@"#808080"];
     [bottomView addSubview:bottomlineView];
    
    [bottomlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom);
        make.height.mas_offset(1/[UIScreen mainScreen].scale);
        make.left.right.mas_equalTo(bottomView);
    }];
    UIView*  bottonButtonView1 = [[UIView alloc] init];
     bottonButtonView1.backgroundColor = [UIColor clearColor];
     [bottomView addSubview: bottonButtonView1];
    [bottonButtonView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.contentView);
        make.height.mas_offset(70+ kTabBarStatusHeight);
    }];
    
    self.smoothSlider = [[QiSlider alloc] initWithFrame:CGRectMake(60, ScreenH-200-kTabBarStatusHeight, ScreenW-120, 4)];
    self.smoothSlider.hidden = YES;
    self.smoothSlider.minimumValue = .0;
    self.smoothSlider.maximumValue = 1.0;
    self.smoothSlider.thumbTintColor = [UIColor purpleColor];
    self.smoothSlider.minimumTrackTintColor = [UIColor purpleColor];
    self.smoothSlider.maximumTrackTintColor = [[UIColor lightGrayColor] colorWithAlphaComponent:.5];
    [self.contentView addSubview:self.smoothSlider];
    
    self.WhiteningSlider = [[QiSlider alloc] initWithFrame:CGRectMake(60, ScreenH-200-kTabBarStatusHeight, ScreenW-120, 4)];
    self.WhiteningSlider.hidden = YES;
    self.WhiteningSlider.minimumValue = .0;
    self.WhiteningSlider.maximumValue = 1.0;
    self.WhiteningSlider.thumbTintColor = [UIColor whiteColor];
    self.WhiteningSlider.minimumTrackTintColor = [UIColor colorWithHexString:@"#007AFF"];
    self.WhiteningSlider.maximumTrackTintColor = [[UIColor whiteColor] colorWithAlphaComponent:.5];
    [self.contentView addSubview:self.WhiteningSlider];
    
    self.adjustExposureSlider = [[QiSlider alloc] initWithFrame:CGRectMake(60, ScreenH-200-kTabBarStatusHeight, ScreenW-120, 4)];
    self.adjustExposureSlider.hidden = YES;
    self.adjustExposureSlider.minimumValue = -10.0;
    self.adjustExposureSlider.maximumValue = 10.0;
    self.adjustExposureSlider.thumbTintColor = [UIColor purpleColor];
    self.adjustExposureSlider.minimumTrackTintColor = [UIColor purpleColor];
    self.adjustExposureSlider.maximumTrackTintColor = [[UIColor lightGrayColor] colorWithAlphaComponent:.5];
    [self.contentView addSubview:self.adjustExposureSlider];
    NSArray *titleArray1 = @[@"liveFaceMY_NO.png",@"liveFaceMY_MP.png",@"liveFaceMY_MB.png",@"liveFaceMY_PG.png"];
    for (NSInteger i = 0; i < 4; i ++) {
        UIButton  *button1 = [[UIButton alloc] init];
        button1.userInteractionEnabled = YES;
        ViewRadius(button1, 24);
        button1.tag = 100+i;
        if (i==0) {
            ViewBorder(button1, [UIColor colorWithHexString:@"#007AFF"], 1);
        }
        button1.titleLabel.font = [UIFont systemFontOfSize:12];
        button1.backgroundColor = [UIColor colorWithHexString:@"#B0B0B0" alpha:0.8];
        //[button1 setTitle:titleArray1[i] forState:UIControlStateNormal];
        //[button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button1 setImage:[UIImage imageNamed:titleArray1[i]] forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(button1click:) forControlEvents:UIControlEventTouchUpInside];
        [bottonButtonView1 addSubview:button1];
        button1.frame = CGRectMake(12 + i *(16+48), 0, 48, 48);
        [self.buttonArray1 addObject:button1];
    }


    UIView* bottonButtonView2 = [[UIView alloc] init];
     bottonButtonView2.backgroundColor = [UIColor clearColor];
    [bottomView addSubview:bottonButtonView2];
    [bottonButtonView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.contentView);
        make.height.mas_offset(70+ kTabBarStatusHeight);
    }];
    
    NSArray *titleArray2 = @[@"faceLiveLJ_NO.png",@"faceLiveLJ_ZR.png",@"faceLiveLJ_FN.png",@"faceLiveLJ_HJ.png"];
    for (NSInteger j = 0; j < 4; j ++) {
        UIButton  *button2 = [[UIButton alloc] init];
        button2.userInteractionEnabled = YES;
        ViewRadius(button2, 24);
        button2.tag = 10+j;
        if (j==0) {
            ViewBorder(button2, [UIColor colorWithHexString:@"#007AFF"], 1);
        }
        button2.titleLabel.font = [UIFont systemFontOfSize:12];
        button2.backgroundColor = [UIColor colorWithHexString:@"#B0B0B0" alpha:0.8];
//        [button2 setTitle:titleArray2[j] forState:UIControlStateNormal];
//        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button2 setImage:[UIImage imageNamed:titleArray2[j]] forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(button2click:) forControlEvents:UIControlEventTouchUpInside];
        [bottonButtonView2 addSubview:button2];
        button2.frame = CGRectMake(12 + j *(16+48), 0, 48, 48);
        [self.buttonArray2 addObject:button2];
    }
     bottonButtonView2.hidden = YES;

    UIButton  *tapButton = [[UIButton alloc] init];
    tapButton.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.0];
    [tapButton addTarget:self action:@selector(tapButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:tapButton];
    [tapButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(bottomView.mas_top).offset(-100);
    }];
    [leftLabel setTapActionWithBlock:^{
        leftLabel.textColor = [UIColor colorWithHexString:@"#007AFF"];
        leftLabel.font = [UIFont systemFontOfSize:16];
        rightLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        rightLabel.font = [UIFont systemFontOfSize:14];
        bottonButtonView1.hidden = NO;
        bottonButtonView2.hidden = YES;
        [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo( leftLabel.mas_centerX);
            make.height.mas_offset(2);
            make.width.mas_offset(20);
            make.top.mas_equalTo( leftLabel.mas_bottom).offset(12);
        }];
    }];

    [rightLabel setTapActionWithBlock:^{
        self.smoothSlider.hidden = YES;
        self.WhiteningSlider.hidden = YES;
        self.adjustExposureSlider.hidden = YES;
         rightLabel.textColor = [UIColor colorWithHexString:@"#007AFF"];
         rightLabel.font = [UIFont systemFontOfSize:16];
         leftLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
         leftLabel.font = [UIFont systemFontOfSize:14];
         bottonButtonView1.hidden = YES;
         bottonButtonView2.hidden = NO;
         [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo( rightLabel.mas_centerX);
            make.height.mas_offset(2);
            make.width.mas_offset(20);
            make.top.mas_equalTo(rightLabel.mas_bottom).offset(12);
        }];
    }];

}
-(void)tapButtonClick{
    [self cs_doDismiss];
}
- (void)cs_maskDidDisappear{
    if (self.clickBlock) {
        self.clickBlock(YES);
    }
}
- (void)button1click:(UIButton *)btn{
    switch (btn.tag-100) {
        case 0:
        {
            self.smoothSlider.hidden = YES;
            self.WhiteningSlider.hidden = YES;
            self.adjustExposureSlider.hidden = YES;
        }
            break;
            
        case 1:
        {
            self.smoothSlider.hidden = NO;
            self.WhiteningSlider.hidden = YES;
            self.adjustExposureSlider.hidden = YES;
        }
            break;
            
        case 2:
        {
            self.WhiteningSlider.hidden = NO;
            self.smoothSlider.hidden = YES;
            self.adjustExposureSlider.hidden = YES;
        }
            break;
        case 3:
        {
            self.adjustExposureSlider.hidden = NO;
            self.smoothSlider.hidden = YES;
            self.WhiteningSlider.hidden = YES;
        }
            break;
            
        default:
            break;
    }
    if ([self.delegate respondsToSelector:@selector(CSNewLiveFaceView1SelectDefinition:)]) {
        [self.delegate CSNewLiveFaceView1SelectDefinition:btn.tag-100];
    }
}

- (void)button2click:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(CSNewLiveFaceView2SelectDefinition:)]) {
        [self.delegate CSNewLiveFaceView2SelectDefinition:btn.tag-10];
    }
}
- (void)show{
    [self getMaskConfig].maskColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    [super show];
}

- (void)refreshFaceView1:(NSInteger)index{
    for (UIButton  *btn in self.buttonArray1) {
        if (index == btn.tag-100) {
            ViewBorder(btn, [UIColor colorWithHexString:@"#007AFF"], 1);
        }else{
            ViewBorder(btn, [UIColor colorWithHexString:@"#007AFF"], 0);
        }
    }
}

- (void)refreshFaceView2:(NSInteger)index{
    for (UIButton  *btn in self.buttonArray2) {
        if (index == btn.tag-10) {
            ViewBorder(btn, [UIColor colorWithHexString:@"#007AFF"], 1);
        }else{
            ViewBorder(btn, [UIColor colorWithHexString:@"#007AFF"], 0);
        }
    }
}

@end
