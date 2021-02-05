//
//  CSMyMemberViewController.m
//  ColorStar
//
//  Created by 陶涛 on 2020/8/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSMyMemberViewController.h"
#import <Masonry.h>
#import "CSMemberModel.h"
#import <YYModel/YYModel.h>
#import "CSMemberInterestItemView.h"
#import "UIView+CS.h"

CGFloat portraitWH = 50;
CGFloat sizeMargin = 20;
CGFloat whScale = 0.75;

@interface CSMyMemberViewController ()

@property (nonatomic, strong)CSMemberModel * memberInfo;

@property (nonatomic, strong)UIView   * whiteView;

@property (nonatomic, strong)UIScrollView * containerView;

@property (nonatomic, strong)UIView   * firstView;

@property (nonatomic, strong)UIView   * secondView;

@property (nonatomic, strong)UIView   * thirdView;


@end

@implementation CSMyMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"会员管理", nil);
}

- (void)processNetWorkSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    [[CSNetworkManager sharedManager] quaryMemberInfoSuccessComplete:success failureComplete:failure];
}

- (void)processData:(CSNetResponseModel *)response{
    
    NSDictionary * dict = (NSDictionary*)response.data;
    
    CSMemberModel * model = [CSMemberModel yy_modelWithDictionary:dict];
    self.memberInfo = model;
    [self setupViews];
    
}

- (void)setupViews{
    
    self.whiteView = [[UIView alloc]initWithFrame:CGRectZero];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.whiteView];
    
    self.containerView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.containerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.containerView];
    
    [self setupFirstView];
    
}

- (void)setupFirstView{
    self.firstView = [[UIView alloc]initWithFrame:CGRectZero];
    self.firstView.layer.masksToBounds = YES;
    self.firstView.layer.cornerRadius = 5;
    self.firstView.backgroundColor = [UIColor whiteColor];
    [self.containerView addSubview:self.firstView];
    
    
    UIImageView * backImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    backImageView.image = [UIImage imageNamed:@""];
    [self.firstView addSubview:backImageView];
    
    UIImageView * portraitImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    portraitImageView.layer.masksToBounds = YES;
    portraitImageView.layer.cornerRadius = portraitWH/2;
    [self.firstView addSubview:portraitImageView];
    
    
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont systemFontOfSize:12.0];
    nameLabel.text = self.memberInfo.userInfo.nickname;
    [self.firstView addSubview:nameLabel];
    
    UIButton * openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    openBtn.layer.masksToBounds = YES;
    openBtn.layer.cornerRadius = 5;
    openBtn.layer.borderWidth = 1;
    openBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [self.firstView addSubview:openBtn];
    
    NSString * title = self.memberInfo.userInfo.isMember ? NSLocalizedString(@"续费会员", nil) : NSLocalizedString(@"开通会员", nil);
    [openBtn setTitle:title forState:UIControlStateNormal];
    [openBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    openBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    
    
    NSString * detailText = @"你未开通会员";
    if (self.memberInfo.userInfo.isMember) {
        detailText = [NSString stringWithFormat:@"你的会员还剩%@天",self.memberInfo.freeData.free.vip_day];
    }
    UILabel * detailLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    detailLabel.font = [UIFont systemFontOfSize:12.0f];
    detailLabel.textColor = [UIColor blackColor];
    detailLabel.text = detailText;
    [self.firstView addSubview:detailLabel];
    
    [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerView).offset(sizeMargin);
        make.right.mas_equalTo(self.containerView).offset(sizeMargin);
        make.top.mas_equalTo(self.containerView).offset(sizeMargin);
        make.height.mas_equalTo(self.firstView.mas_width).multipliedBy(whScale);
    }];
    
    [portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.firstView).offset(20);
        make.width.height.mas_equalTo(portraitWH);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(portraitImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(portraitImageView);
    }];
    
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(20);
    }];
    
    [openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(portraitImageView);
        make.right.mas_equalTo(self.firstView).offset(20);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
}

- (void)setupSecondView{
    
    self.secondView = [[UIView alloc]initWithFrame:CGRectZero];
    self.secondView.backgroundColor = [UIColor blackColor];
    [self.containerView addSubview:self.secondView];
    
    UIButton * titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitle:NSLocalizedString(@"会员专享权益", nil) forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.secondView addSubview:titleBtn];
    
    CGFloat topMargin = 40;
    CGFloat itemWith = self.secondView.width/3;
    CGFloat itemHeight = 120;
    if (self.memberInfo.interests.count > 0) {
        
        for (int i = 0; i < self.memberInfo.interests.count; i++) {
            CSMemberInterestModel * model = self.memberInfo.interests[i];
            CSMemberInterestItemView * interestView = [[CSMemberInterestItemView alloc]init];
            interestView.interestModel = model;
            interestView.frame = CGRectMake(itemWith*(i%3), topMargin + itemHeight*(i/3), itemWith, itemHeight);
            [self.secondView addSubview:interestView];
        }
        
    }
    
}

- (void)setupThirdView{
    
    self.thirdView = [[UIView alloc]initWithFrame:CGRectZero];
    self.thirdView.backgroundColor = [UIColor blackColor];
    self.thirdView.layer.masksToBounds = YES;
    self.thirdView.layer.cornerRadius = 5;
    [self.containerView addSubview:self.thirdView];
    
    UIButton * titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitle:NSLocalizedString(@"会员说明", nil) forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.thirdView addSubview:titleBtn];
    
//    CGPoint originPoint = CGPointMake(0, 0);
//    for (int i = 0; i < self.memberInfo.descs.count > 0; i++) {
//        NSString * text = [NSString stringWithFormat:@"%i.%@",(i+1),self.memberInfo.descs[i].text];
//
//        UIFont * textFont = [UIFont systemFontOfSize:12.0f];
//        CGSize size =
//        UILabel * label = [[UILabel alloc]initWithFrame:CGRectZero];
//        label.numberOfLines = 0;
//
//    }
    
}


@end
