//
//  CSLiveUserInputView.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorLiveSurfaceBottomView.h"
#import "UIColor+CS.h"
#import "CSColorStar.h"
#import <Masonry/Masonry.h>
#import "UIView+CS.h"
#import "CSTutorLiveManager.h"

@interface CSTutorLiveSurfaceBottomView ()

@property (nonatomic, strong)UIView * inputView;

@property (nonatomic, strong)UILabel * inputLabel;

@property (nonatomic, strong)UIButton * giftBtn;

@property (nonatomic, strong)UIButton * likeBtn;

@property (nonatomic, strong)UIButton * shareBtn;

@end

@implementation CSTutorLiveSurfaceBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self addSubview:self.inputView];
    [self addSubview:self.inputLabel];
    [self addSubview:self.giftBtn];
    [self addSubview:self.likeBtn];
    [self addSubview:self.shareBtn];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(160);
    }];
    
    [self.inputLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.inputView).offset(12);
    }];
    
    [self.giftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.inputView.mas_right).offset(30);
        make.centerY.mas_equalTo(self.inputView);
        make.size.mas_equalTo(CGSizeMake(28, 28));
    }];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.giftBtn.mas_right).offset(24);
        make.centerY.mas_equalTo(self.inputView);
        make.size.mas_equalTo(CGSizeMake(28, 28));
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.likeBtn.mas_right).offset(24);
        make.centerY.mas_equalTo(self.inputView);
        make.size.mas_equalTo(CGSizeMake(28, 28));
    }];
        
    
}

- (void)giftClick{
    if (self.clickBlock) {
        self.clickBlock(CSTutorLiveSurfaceBottomTypeGift, nil);
    }
}

- (void)attentClick{
    if (self.clickBlock) {
        self.clickBlock(CSTutorLiveSurfaceBottomTypeAttention, @(self.likeBtn.isSelected));
    }
    self.likeBtn.selected = YES;
    [self showTheApplauseInView:self belowView:self.likeBtn];
    
}

- (void)shareClick{
    if (self.clickBlock) {
        self.clickBlock(CSTutorLiveSurfaceBottomTypeShare, nil);
    }
}


//鼓掌动画
- (void)showTheApplauseInView:(UIView *)view belowView:(UIButton *)v{

    UIImageView *applauseView = [[UIImageView alloc]initWithFrame:CGRectMake(v.left, v.top - 40, 40, 40)];//增大y值可隐藏弹出动画
    [view insertSubview:applauseView belowSubview:v];
    applauseView.image = LoadImage(@"cs_tutor_new_course_unlike");
    
    CGFloat AnimH = 300; //动画路径高度,
    applauseView.transform = CGAffineTransformMakeScale(0, 0);
    applauseView.alpha = 0;
    
    //弹出动画
    [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
        applauseView.transform = CGAffineTransformIdentity;
        applauseView.alpha = 0.9;
    } completion:NULL];
    
    //随机偏转角度
    NSInteger i = arc4random_uniform(2);
    NSInteger rotationDirection = 1- (2*i);// -1 OR 1,随机方向
    NSInteger rotationFraction = arc4random_uniform(10); //随机角度
    //图片在上升过程中旋转
    [UIView animateWithDuration:4 animations:^{
        applauseView.transform = CGAffineTransformMakeRotation(rotationDirection * M_PI/(4 + rotationFraction*0.2));
    } completion:NULL];
    
    //动画路径
    UIBezierPath *heartTravelPath = [UIBezierPath bezierPath];
    [heartTravelPath moveToPoint:applauseView.center];
    
    //随机终点
    CGFloat ViewX = applauseView.center.x;
    CGFloat ViewY = applauseView.center.y;
    CGPoint endPoint = CGPointMake(ViewX + rotationDirection*10, ViewY - AnimH);
    
    //随机control点
    NSInteger j = arc4random_uniform(2);
    NSInteger travelDirection = 1- (2*j);//随机放向 -1 OR 1
    
    NSInteger m1 = ViewX + travelDirection*(arc4random_uniform(20) + 50);
    NSInteger n1 = ViewY - 60 + travelDirection*arc4random_uniform(20);
    NSInteger m2 = ViewX - travelDirection*(arc4random_uniform(20) + 50);
    NSInteger n2 = ViewY - 90 + travelDirection*arc4random_uniform(20);
    CGPoint controlPoint1 = CGPointMake(m1, n1);//control根据自己动画想要的效果做灵活的调整
    CGPoint controlPoint2 = CGPointMake(m2, n2);
    //根据贝塞尔曲线添加动画
    [heartTravelPath addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    
    //关键帧动画,实现整体图片位移
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.path = heartTravelPath.CGPath;
    keyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    keyFrameAnimation.duration = 3 ;//往上飘动画时长,可控制速度
    [applauseView.layer addAnimation:keyFrameAnimation forKey:@"positionOnPath"];
    
    //消失动画
    [UIView animateWithDuration:3 animations:^{
        applauseView.alpha = 0.0;
    } completion:^(BOOL finished) {
//        if (applauseView) {
//            [applauseView removeFromSuperview];
//        }
    }];
}

#pragma mark Properties Method

- (UIView*)inputView{
    if (!_inputView) {
        CS_Weakify(self, weakSelf);
        _inputView = [[UIView alloc]initWithFrame:CGRectZero];
        _inputView.backgroundColor = [UIColor colorWithHexString:@"#7C7F82" alpha:0.5];
        _inputView.layer.masksToBounds = YES;
        _inputView.layer.cornerRadius = 17.0f;
        [_inputView setTapActionWithBlock:^{
            if (weakSelf.clickBlock) {
                weakSelf.clickBlock(CSTutorLiveSurfaceBottomTypeKeyBoard, nil);
            }
        }];
    }
    return _inputView;
}

- (UILabel*)inputLabel{
    if (!_inputLabel) {
        _inputLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _inputLabel.textColor = [UIColor whiteColor];
        _inputLabel.font = kFont(12.0f);
        _inputLabel.text = csnation(@"说点什么吧…");
    }
    return _inputLabel;
}

- (UIButton*)giftBtn{
    if (!_giftBtn) {
        _giftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_giftBtn setImage:LoadImage(@"cs_tutor_live_surface_bottom_gift") forState:UIControlStateNormal];
        [_giftBtn addTarget:self action:@selector(giftClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _giftBtn;
}

- (UIButton*)likeBtn{
    if (!_likeBtn) {
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeBtn setImage:LoadImage(@"cs_tutor_new_course_like") forState:UIControlStateNormal];
        [_likeBtn setImage:LoadImage(@"cs_tutor_new_course_unlike") forState:UIControlStateHighlighted];
        [_likeBtn setImage:LoadImage(@"cs_tutor_new_course_unlike") forState:UIControlStateSelected];
        [_likeBtn addTarget:self action:@selector(attentClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}

- (UIButton*)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:LoadImage(@"cs_tutor_new_course_share") forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}


@end
