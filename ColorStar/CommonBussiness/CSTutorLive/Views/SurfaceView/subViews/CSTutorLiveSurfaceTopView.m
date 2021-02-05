//
//  CSLiveAnchorInfoView.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorLiveSurfaceTopView.h"
#import "CSColorStar.h"
#import "UIColor+CS.h"
#import "CSAvtorImageView.h"
#import "UILabel+CS.h"
//CS_home_recomendArtisheadRaiduImage
@interface CSTutorLiveSurfaceTopView ()

@property (nonatomic, strong)UIView    * liverInfoView;
@property (nonatomic, strong)CSAvtorImageView   * avtorImageView;
@property (nonatomic, strong)UILabel   * liverNameLabel;
@property (nonatomic, strong)UILabel   * likeNumLabel;
@property (nonatomic, strong)UIButton  * followBtn;

@property (nonatomic, strong)UIView  * visitorView;
@property (nonatomic, strong)CSAvtorImageView * firsrAvtor;
@property (nonatomic, strong)CSAvtorImageView * secondAvtor;
@property (nonatomic, strong)CSAvtorImageView * thirdAvtor;
@property (nonatomic, strong)CSAvtorImageView * fourAvtor;

@property (nonatomic, strong)UIView  * moreLiveView;
@property (nonatomic, strong)UIImageView * moreImageView;
@property (nonatomic, strong)UILabel * moreLabel;
@property (nonatomic, strong)UIImageView * moreArrowImageView;

@property (nonatomic, strong)UIButton *backBtn;

@end

@implementation CSTutorLiveSurfaceTopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self addSubview:self.liverInfoView];
    [self.liverInfoView addSubview:self.avtorImageView];
    [self.liverInfoView addSubview:self.liverNameLabel];
    [self.liverInfoView addSubview:self.likeNumLabel];
//    [self.liverInfoView addSubview:self.followBtn];
    [self addSubview:self.backBtn];
    
    [self addSubview:self.visitorView];
    [self.visitorView addSubview: self.firsrAvtor];
    [self.visitorView addSubview: self.secondAvtor];
    [self.visitorView addSubview: self.thirdAvtor];
    [self.visitorView addSubview: self.fourAvtor];
    [self addSubview:self.visitorNumLabel];
    
    [self addSubview:self.moreLiveView];
    [self.moreLiveView addSubview:self.moreImageView];
    [self.moreLiveView addSubview:self.moreLabel];
    [self.moreLiveView addSubview:self.moreArrowImageView];
    
    self.firsrAvtor.hidden = YES;
    self.secondAvtor.hidden = YES;
    self.thirdAvtor.hidden = YES;
    self.fourAvtor.hidden = YES;
}

- (void)layoutSubviews{
    
    [self.liverInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12*widthScale);
        make.top.mas_equalTo(14);
        make.height.mas_equalTo(42);
        make.width.mas_equalTo(140);
    }];
    
    [self.avtorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self.liverInfoView);
        make.width.mas_equalTo(42);
    }];
    
    [self.liverNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avtorImageView.mas_right).offset(6);
        make.top.mas_equalTo(self.liverInfoView).offset(6);
    }];
    
    [self.likeNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.liverNameLabel);
        make.bottom.mas_equalTo(self.liverInfoView).offset(-6);
    }];
    
//    [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.liverInfoView).offset(-10);
//        make.centerY.mas_equalTo(self.avtorImageView);
//        make.size.mas_equalTo(CGSizeMake(40, 18));
//    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.liverInfoView);
        make.right.mas_equalTo(-12);
        make.width.height.mas_equalTo(20);
    }];
    
    
    [self.visitorNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.liverInfoView);
        make.right.mas_equalTo(self.backBtn.mas_left).offset(-4);
    }];
    
    [self.visitorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.liverInfoView.mas_right).offset(12*widthScale);
        make.centerY.mas_equalTo(self.liverInfoView);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(42);
    }];
    
    [self.firsrAvtor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.mas_equalTo(self.visitorView);
        make.width.mas_offset(42);
    }];
    
    [self.secondAvtor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.bottom.top.mas_equalTo(self.firsrAvtor);
        make.left.mas_equalTo(self.firsrAvtor.mas_right).offset(6*widthScale);
    }];
    
    [self.thirdAvtor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.bottom.top.mas_equalTo(self.secondAvtor);
        make.left.mas_equalTo(self.secondAvtor.mas_right).offset(6*widthScale);
    }];
    
    [self.fourAvtor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.bottom.top.mas_equalTo(self.thirdAvtor);
        make.left.mas_equalTo(self.thirdAvtor.mas_right).offset(6*widthScale);
    }];
    
    
    [self.moreLiveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.right.mas_offset(13);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(120);
    }];
    
    [self.moreArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.moreLiveView);
        make.right.mas_equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    [self.moreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.moreArrowImageView);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.moreArrowImageView);
        make.right.mas_equalTo(self.moreArrowImageView.mas_left);
        make.left.mas_equalTo(self.moreImageView.mas_right);
    }];
    
}

- (void)mockData{
    
    self.liverNameLabel.text = @"是袁野夕～";
    self.likeNumLabel.text = @"2083次本场点赞";
    self.visitorNumLabel.text = @"2732";
    
    self.moreLabel.text = @"更多直播";
}

- (void)setLiveModel:(CSTutorLiveModel *)liveModel{
    _liveModel = liveModel;
    
    [self.avtorImageView sd_setImage:liveModel.liveInfo.live_image];
    self.liverNameLabel.text = _liveModel.liveInfo.live_title;
    self.visitorNumLabel.text = _liveModel.UserSum;
    self.likeNumLabel.text = _liveModel.liveInfo.click_count > 0 ? [NSString stringWithFormat:@"%ld%@",_liveModel.liveInfo.click_count,csnation(@"点赞")] : @"";
    [self setVistors:liveModel.liveUser.list];
}

- (void)clickLike{
    self.clickCount += 1;
    self.likeNumLabel.text = [NSString stringWithFormat:@"%ld%@",(self.clickCount + _liveModel.liveInfo.click_count),csnation(@"点赞")];

}

- (void)backClick{
    if (self.topBlock) {
        self.topBlock(CSTutorLiveSurfaceTopViewBlockTypeBack);
    }
}

- (void)followClick{
    if (self.topBlock) {
        self.topBlock(CSTutorLiveSurfaceTopViewBlockTypeFollow);
    }
}

- (void)setVistors:(NSArray *)vistors{
    
    if (vistors.count > 0) {
        if (vistors.count > 0) {
            CSTutorLiveUserModel * first = vistors.firstObject;
            [self.firsrAvtor sd_setImage:first.avatar];
            self.firsrAvtor.hidden = NO;
        }
        
        if (vistors.count > 1) {
            CSTutorLiveUserModel * second = vistors[1];
            [self.secondAvtor sd_setImage:second.avatar];
            self.secondAvtor.hidden = NO;
        }
        
        if (vistors.count > 2) {
            CSTutorLiveUserModel * third = vistors[2];
            [self.thirdAvtor sd_setImage:third.avatar];
            self.thirdAvtor.hidden = NO;
        }

    }
    
    
}



#pragma mark - Properties Method

- (UIView*)liverInfoView{
    if (!_liverInfoView) {
        _liverInfoView = [[UIView alloc]initWithFrame:CGRectZero];
        _liverInfoView.backgroundColor = [UIColor colorWithHexString:@"#7C7F82" alpha:0.5];
        _liverInfoView.layer.masksToBounds = YES;
        _liverInfoView.layer.cornerRadius = 21;
    }
    return _liverInfoView;
}

- (CSAvtorImageView*)avtorImageView{
    if (!_avtorImageView) {
        _avtorImageView = [[CSAvtorImageView alloc]initWithFrame:CGRectZero];
        _avtorImageView.innerWH = 42;
    }
    return _avtorImageView;
}


- (UILabel*)liverNameLabel{
    if (!_liverNameLabel) {
        _liverNameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _liverNameLabel.textColor = [UIColor whiteColor];
        _liverNameLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _liverNameLabel;
}

- (UILabel*)likeNumLabel{
    if (!_likeNumLabel) {
        _likeNumLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _likeNumLabel.textColor = [UIColor whiteColor];
        _likeNumLabel.font = kFont(10.0f);
    }
    return _likeNumLabel;
}

- (UIButton*)followBtn{
    if (!_followBtn) {
        _followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_followBtn setBackgroundImage:LoadImage(@"cs_tutor_live_follow_back") forState:UIControlStateNormal];
        [_followBtn setImage:LoadImage(@"cs_tutor_live_follow_add") forState:UIControlStateNormal];
        [_followBtn setTitle:csnation(@"关注") forState:UIControlStateNormal];
        [_followBtn setTitle:csnation(@"已关注") forState:UIControlStateSelected];
        [_followBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _followBtn.titleLabel.font = kFont(9);
        [_followBtn addTarget:self action:@selector(followClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followBtn;
}

- (UIView*)visitorView{
    if (!_visitorView) {
        _visitorView = [[UIView alloc]initWithFrame:CGRectZero];
        _visitorView.layer.masksToBounds = YES;
    }
    return _visitorView;
}

- (CSAvtorImageView*)firsrAvtor{
    if (!_firsrAvtor) {
        _firsrAvtor = [[CSAvtorImageView alloc]initWithFrame:CGRectZero];
        _firsrAvtor.innerWH = 42;
    }
    return _firsrAvtor;
}

- (CSAvtorImageView*)secondAvtor{
    if (!_secondAvtor) {
        _secondAvtor = [[CSAvtorImageView alloc]initWithFrame:CGRectZero];
        _secondAvtor.innerWH = 42;

    }
    return _secondAvtor;
}

- (CSAvtorImageView*)thirdAvtor{
    if (!_thirdAvtor) {
        _thirdAvtor = [[CSAvtorImageView alloc]initWithFrame:CGRectZero];
        _thirdAvtor.innerWH = 42;

    }
    return _thirdAvtor;
}

- (CSAvtorImageView*)fourAvtor{
    if (!_fourAvtor) {
        _fourAvtor = [[CSAvtorImageView alloc]initWithFrame:CGRectZero];
        _fourAvtor.innerWH = 42;

    }
    return _fourAvtor;
}

- (YYLabel*)visitorNumLabel{
    if (!_visitorNumLabel) {
        _visitorNumLabel = [[YYLabel alloc]initWithFrame:CGRectZero];
        _visitorNumLabel.font = LoadFont(9.0f);
        _visitorNumLabel.textColor = [UIColor whiteColor];
        _visitorNumLabel.backgroundColor = LoadColor(@"#7C7F82");
        _visitorNumLabel.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5);
        _visitorNumLabel.layer.masksToBounds = YES;
        _visitorNumLabel.layer.cornerRadius = 11;
    }
    return _visitorNumLabel;
}

- (UIView*)moreLiveView{
    if (!_moreLiveView) {
        _moreLiveView = [[UIView alloc]initWithFrame:CGRectZero];
        _moreLiveView.backgroundColor = [UIColor colorWithHexString:@"#7C7F82" alpha:0.5];
        _moreLiveView.layer.masksToBounds = YES;
        _moreLiveView.layer.cornerRadius = 13.0f;
        CS_Weakify(self, weakSelf);
        [_moreLiveView setTapActionWithBlock:^{
            [[CSTotalTool getCurrentShowViewController].navigationController popViewControllerAnimated:YES];
//            if (weakSelf.topBlock) {
//                weakSelf.topBlock(CSTutorLiveSurfaceTopViewBlockTypeMore);
//            }
        }];
    }
    return _moreLiveView;
}

- (UIImageView*)moreImageView{
    if (!_moreImageView) {
        _moreImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _moreImageView.image = LoadImage(@"cs_tutor_live_more_live_icon");
    }
    return _moreImageView;
}

- (UIImageView*)moreArrowImageView{
    if (!_moreArrowImageView) {
        _moreArrowImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _moreArrowImageView.image = LoadImage(@"cs_tutor_live_more_live_arrow");
    }
    return _moreArrowImageView;
}

- (UILabel*)moreLabel{
    if (!_moreLabel) {
        _moreLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _moreLabel.textColor = [UIColor whiteColor];
        _moreLabel.font = [UIFont systemFontOfSize:10.0f];
        _moreLabel.textAlignment = NSTextAlignmentCenter;
        _moreLabel.text = csnation(@"更多直播");
    }
    return _moreLabel;
}

- (UIButton*)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:LoadImage(@"cs_tutor_live_back") forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

@end
