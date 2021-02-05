//
//  CSMineTopView.m
//  ColorStar
//
//  Created by gavin on 2020/8/10.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSMineTopView.h"
#import "CSMineTopItemView.h"
#import "CSColorStar.h"
#import <Masonry.h>
#import "NSString+CS.h"
#import "UIColor+CS.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+CSAlert.h"

@interface CSMineTopView ()

@property (nonatomic, strong)CSMineTopViewModel * model;

@property (nonatomic, strong)UIImageView * portraitView;

@property (nonatomic, strong)UILabel     * userNameLabel;

@property (nonatomic, strong)UIView      * memberView;

@property (nonatomic, strong)UIImageView * memberIconImageView;

@property (nonatomic, strong)UILabel     * memberTipsLabel;

//@property (nonatomic, strong)UIControl   * settingControl;
//
//@property (nonatomic, strong)UIImageView * settingIconImageView;
//
//@property (nonatomic, strong)UILabel     * settingTipsLabel;

//@property (nonatomic, strong)UIView      * openMemberView;
//
//@property (nonatomic, strong)UIImageView * openMemberIconView;
//
//@property (nonatomic, strong)UILabel     * openMemberLabel;
//
//@property (nonatomic, strong)UIButton    * openMemberBtn;

//@property (nonatomic, strong)CSMineTopItemView  * courseView;
//
//@property (nonatomic, strong)CSMineTopItemView  * recordView;
//
//@property (nonatomic, strong)CSMineTopItemView  * favoriteView;

@end

@implementation CSMineTopView

- (instancetype)initWithTopViewModel:(CSMineTopViewModel*)model{
    if (self = [super init]) {
        _model = model;
        [self setupViews];
    }
    return self;
}


- (void)setupViews{
    
    [self addSubview:self.portraitView];
    [self addSubview:self.userNameLabel];
    [self addSubview:self.memberView];
    
    [self.memberView addSubview:self.memberIconImageView];
    [self.memberView addSubview:self.memberTipsLabel];
    
//    [self addSubview:self.settingControl];
//    [self.settingControl addSubview:self.settingIconImageView];
//    [self.settingControl addSubview:self.settingTipsLabel];
    
//    [self addSubview:self.openMemberView];
//    [self.openMemberView addSubview:self.openMemberIconView];
//    [self.openMemberView addSubview:self.openMemberLabel];
//    [self.openMemberView addSubview:self.openMemberBtn];
    
//    [self addSubview:self.courseView];
//    [self addSubview:self.recordView];
//    [self addSubview:self.favoriteView];
    
    if (!self.model.userInfo) {
        [self mockData];
    }else{
        self.userNameLabel.text = self.model.userInfo.nickname;
//        self.memberTipsLabel.text = self.model.userInfo.isMember ? NSLocalizedString(@"已开通会员", nil) : NSLocalizedString(@"未开通会员", nil);
//        NSString * imageName = self.model.userInfo.isMember ? @"cs_mine_diamond_color" : @"cs_mine_diamond_white";
//        self.memberIconImageView.image = [UIImage imageNamed:imageName];
        
        [self.portraitView sd_setImageWithURL:[NSURL URLWithString:self.model.userInfo.avatar] placeholderImage:[UIImage imageNamed:@"cs_login_icon"]];
    }
    
}

- (void)mockData{
    
//    self.userNameLabel.text = @"天蝎蝴蝶";
//    self.memberTipsLabel.text = @"未开通会员";
    
}

- (void)reloadData{
    
//    [self.favoriteView reloadData];
//    [self.recordView reloadData];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.portraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(14);
        make.top.mas_equalTo(self).offset(20);
        make.size.mas_equalTo(CGSizeMake(75, 75));
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.portraitView.mas_right).offset(14);
        make.top.mas_equalTo(self.portraitView).offset(15);
    }];
    
    
    CGSize memberSize = [self.memberTipsLabel.text textSizeWithHeight:20 withFont:[UIFont systemFontOfSize:12.0f]];
    
    [self.memberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userNameLabel);
        make.top.mas_equalTo(self.userNameLabel.mas_bottom).offset(7.5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(memberSize.width + 30);
    }];
    
//    [self.memberIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.memberView).offset(5);
//        make.centerY.mas_equalTo(self.memberView);
//        make.size.mas_equalTo(CGSizeMake(14, 14));
//    }];
//    
//    [self.memberTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.memberView).offset(-5);
//        make.centerY.mas_equalTo(self.memberIconImageView);
//    }];
    
//    CGSize settingSize = [self.settingTipsLabel.text textSizeWithHeight:20 withFont:[UIFont systemFontOfSize:12.0f]];
//
//    [self.settingControl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.portraitView);
//        make.right.mas_equalTo(self).offset(-14);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(settingSize.width + 30);
//    }];
//
//    [self.settingIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.settingControl).offset(5);
//        make.centerY.mas_equalTo(self.settingControl);
//        make.size.mas_equalTo(CGSizeMake(15, 15));
//    }];
//
//    [self.settingTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.settingIconImageView);
//        make.right.mas_equalTo(self.settingControl).offset(-5);
//    }];
    
//    [self.openMemberView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self).offset(15);
//        make.right.mas_equalTo(self).offset(-15);
//        make.top.mas_equalTo(self.portraitView.mas_bottom).offset(20);
//        make.height.mas_equalTo(self.model.userInfo.isMember ? 0.01 : 66);
//    }];
//
//    [self.openMemberIconView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.openMemberView).offset(12);
//        make.centerY.mas_equalTo(self.openMemberView);
//        make.height.width.mas_equalTo(24);
//    }];
//
//    [self.openMemberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.openMemberIconView.mas_right).offset(5);
//        make.centerY.mas_equalTo(self.openMemberIconView);
//    }];
//
//    [self.openMemberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self).offset(-12);
//        make.centerY.mas_equalTo(self.openMemberLabel);
//        make.height.mas_equalTo(30);
//        make.width.mas_equalTo(100);
//    }];
    
//    [self.courseView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.portraitView.mas_bottom).offset(20);
//        make.centerX.mas_equalTo(self.mas_left).offset(ScreenW/4 - 20);
//        make.width.mas_equalTo(80);
//        make.height.mas_equalTo(80);
//    }];
//    
//    [self.recordView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.portraitView.mas_bottom).offset(20);
//        make.centerX.mas_equalTo(self.mas_left).offset(ScreenW/2);
//        make.width.mas_equalTo(80);
//        make.height.mas_equalTo(80);
//    }];
//    
//    [self.favoriteView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.portraitView.mas_bottom).offset(20);
//        make.centerX.mas_equalTo(self.mas_right).offset(-ScreenW/4 + 20);
//        make.width.mas_equalTo(80);
//        make.height.mas_equalTo(80);
//    }];
    
}




- (void)itemClick:(CSMineTopItemView*)item{
    
    if (self.click) {
        self.click(item.configModel);
    }
    
}

- (void)settingClick{
    
    [NSLocalizedString(@"功能暂未开通，敬请期待", nil) showAlert];
    return;
    if (self.setting) {
        self.setting();
    }
    
}

- (void)openMemberClick{
//    [NSLocalizedString(@"功能暂未开通，敬请期待", nil) showAlert];
    if (self.memberClick) {
        self.memberClick();
    }
}

#pragma mark - Properties Method

- (UIImageView*)portraitView{
    if (!_portraitView) {
        _portraitView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _portraitView.layer.masksToBounds = YES;
        _portraitView.layer.cornerRadius = 37.5;
        _portraitView.backgroundColor = [UIColor whiteColor];
    }
    return _portraitView;
}

- (UILabel*)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _userNameLabel.textColor = [UIColor whiteColor];
        _userNameLabel.font = [UIFont systemFontOfSize:18.0f];
    }
    return _userNameLabel;
}

- (UIView*)memberView{
    if (!_memberView) {
        _memberView = [[UIView alloc]initWithFrame:CGRectZero];
        _memberView.layer.masksToBounds = YES;
        _memberView.layer.cornerRadius = 4.0f;
        _memberView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        _memberView.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.12].CGColor;
    }
    return _memberView;
}

- (UIImageView*)memberIconImageView{
    if (!_memberIconImageView) {
        _memberIconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _memberIconImageView.image = [UIImage imageNamed:@"cs_mine_diamond_white"];
    }
    return _memberIconImageView;
}

- (UILabel*)memberTipsLabel{
    if (!_memberTipsLabel) {
        _memberTipsLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _memberTipsLabel.textColor = [UIColor colorWithWhite:1.0f alpha:0.38];
        _memberTipsLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _memberTipsLabel;
}

//- (UIControl*)settingControl{
//    if (!_settingControl) {
//        _settingControl = [[UIControl alloc]initWithFrame:CGRectZero];
//        _settingControl.layer.masksToBounds = YES;
//        _settingControl.layer.cornerRadius = 4.0f;
//        _settingControl.layer.borderWidth = 1/[UIScreen mainScreen].scale;
//        _settingControl.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.12].CGColor;
//        [_settingControl addTarget:self action:@selector(settingClick) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _settingControl;
//}
//
//- (UIImageView*)settingIconImageView{
//    if (!_settingIconImageView) {
//        _settingIconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
//        _settingIconImageView.image = [UIImage imageNamed:@"cs_mine_setting"];
//    }
//    return _settingIconImageView;
//}
//
//- (UILabel*)settingTipsLabel{
//    if (!_settingTipsLabel) {
//        _settingTipsLabel = [[UILabel alloc]initWithFrame:CGRectZero];
//        _settingTipsLabel.text = NSLocalizedString(@"设置", nil);
//        _settingTipsLabel.font = [UIFont systemFontOfSize:12.0f];
//        _settingTipsLabel.textColor = [UIColor colorWithWhite:1.0f alpha:0.38];
//    }
//    return _settingTipsLabel;
//}

//- (UIView*)openMemberView{
//    if (!_openMemberView) {
//        _openMemberView = [[UIView alloc]initWithFrame:CGRectZero];
//        CGSize size = CGSizeMake(ScreenW - 30, 66);
//        CAGradientLayer *layer = [CAGradientLayer new];
//        //colors存放渐变的颜色的数组
//        layer.colors=@[(__bridge id)[UIColor colorWithHexString:@"#D5B3FD" alpha:0.12].CGColor,(__bridge id)[UIColor colorWithHexString:@"#BB85FB" alpha:0.12].CGColor];
//        layer.startPoint = CGPointMake(0, 0);
//        layer.endPoint = CGPointMake(1, 1);
//        layer.frame = CGRectMake(0, 0, size.width, size.height);
//        [_openMemberView.layer addSublayer:layer];
//        CGFloat radius = 20; // 圆角大小
//        UIRectCorner corner = UIRectCornerTopLeft | UIRectCornerTopRight;
//        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//        maskLayer.frame = CGRectMake(0, 0, size.width, size.height);;
//        maskLayer.path = path.CGPath;
//        _openMemberView.layer.mask = maskLayer;
//    }
//    return _openMemberView;
//}
//
//- (UIImageView*)openMemberIconView{
//    if (!_openMemberIconView) {
//        _openMemberIconView = [[UIImageView alloc]initWithFrame:CGRectZero];
//        _openMemberIconView.image = [UIImage imageNamed:@"cs_mine_diamond_color"];
//    }
//    return _openMemberIconView;
//}
//
//- (UILabel*)openMemberLabel{
//    if (!_openMemberLabel) {
//        _openMemberLabel = [[UILabel alloc]initWithFrame:CGRectZero];
//        _openMemberLabel.text = NSLocalizedString(@"会员可享多项课程特权", nil);
//        _openMemberLabel.font = [UIFont systemFontOfSize:15.0f];
//        _openMemberLabel.textColor = [UIColor whiteColor];
//    }
//    return _openMemberLabel;
//}
//
//- (UIButton*)openMemberBtn{
//    if (!_openMemberBtn) {
//        _openMemberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_openMemberBtn setTitle:NSLocalizedString(@"立即激活", nil) forState:UIControlStateNormal];
//        [_openMemberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_openMemberBtn addTarget:self action:@selector(openMemberClick) forControlEvents:UIControlEventTouchUpInside];
//        _openMemberBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
//        _openMemberBtn.layer.masksToBounds = YES;
//        _openMemberBtn.layer.cornerRadius = 15;
//        _openMemberBtn.backgroundColor = [UIColor colorWithHexString:@"#4D1DBB"];
//    }
//    return _openMemberBtn;
//}

//- (CSMineTopItemView*)courseView{
//    if (!_courseView) {
//        _courseView = [[CSMineTopItemView alloc]initWithConfigModel:self.model.configs[0]];
//        [_courseView addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _courseView;
//}
//
//- (CSMineTopItemView*)recordView{
//    if (!_recordView) {
//        _recordView = [[CSMineTopItemView alloc]initWithConfigModel:self.model.configs[1]];
//        [_recordView addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _recordView;
//}
//
//- (CSMineTopItemView*)favoriteView{
//    if (!_favoriteView) {
//        _favoriteView = [[CSMineTopItemView alloc]initWithConfigModel:self.model.configs[2]];
//        [_favoriteView addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _favoriteView;
//}



@end
