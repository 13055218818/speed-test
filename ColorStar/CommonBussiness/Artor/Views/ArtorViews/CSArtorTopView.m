//
//  CSArtorTopView.m
//  ColorStar
//
//  Created by gavin on 2020/8/18.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSArtorTopView.h"
#import "SDCycleScrollView.h"
#import "UIView+CS.h"
#import <YYLabel.h>
#import "UIColor+CS.h"
#import <Masonry.h>
#import "NSString+CS.h"
#import "CSNetworkManager.h"
#import "CSColorStar.h"
#import "UIButton+CS.h"

@interface CSArtorTopView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong)CSArtorDetailModel  * detailModel;

@property (nonatomic, strong)SDCycleScrollView * cycleView;

@property (nonatomic, strong)UILabel     * titleLabel;

@property (nonatomic, strong)YYLabel     * typeLabel1;

@property (nonatomic, strong)YYLabel     * typeLabel2;

@property (nonatomic, strong)UILabel     * abstactLabel;

@property (nonatomic, strong)UILabel     * priceLabel;

@property (nonatomic, strong)UIView      * separtLine;

@property (nonatomic, strong)UILabel     * courseLabel;

@property (nonatomic, strong)UIImageView * readIcon;

@property (nonatomic, strong)UILabel     * readLabel;

@property (nonatomic, strong)UIButton    * collectionBtn;

@end

@implementation CSArtorTopView

- (instancetype)initWithModel:(CSArtorDetailModel*)detailModel{
    if (self = [super init]) {
        _detailModel = detailModel;
        self.backgroundColor = [UIColor colorWithHexString:@"#111111"];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    self.cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"cs_home_banner"]];
    [self addSubview:self.cycleView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    
    self.abstactLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.abstactLabel.font = [UIFont systemFontOfSize:10.0f];
    self.abstactLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.87];
    self.abstactLabel.numberOfLines = 2;
    [self addSubview:self.abstactLabel];
    
    self.priceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.priceLabel.textColor = [UIColor colorWithHexString:@"#FCB086"];
    self.priceLabel.font = [UIFont systemFontOfSize:12.0f];
    [self addSubview:self.priceLabel];
    
    self.separtLine = [[UIView alloc]initWithFrame:CGRectZero];
    self.separtLine.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.38];
    [self addSubview:self.separtLine];
    
    self.courseLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.courseLabel.textColor = [UIColor colorWithWhite:1.0f alpha:0.38];
    self.courseLabel.font = [UIFont systemFontOfSize:12.0f];
    [self addSubview:self.courseLabel];
    
    self.readIcon = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.readIcon.image = [UIImage imageNamed:@"cs_artor_read_icon"];
    [self addSubview:self.readIcon];
    
    self.readLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.readLabel.font = [UIFont systemFontOfSize:12.0f];
    self.readLabel.textColor = [UIColor colorWithWhite:1.0f alpha:0.38];
    [self addSubview:self.readLabel];
    
    [self addSubview:self.typeLabel1];
    [self addSubview:self.typeLabel2];
    
    
    self.collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.collectionBtn setTitle:NSLocalizedString(@"收藏", nil) forState:UIControlStateNormal];
    [self.collectionBtn setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateSelected];
    [self.collectionBtn setImage:[UIImage imageNamed:@"cs_artor_unlike"] forState:UIControlStateNormal];
    [self.collectionBtn setImage:[UIImage imageNamed:@"cs_artor_like"] forState:UIControlStateSelected];
    [self.collectionBtn addTarget:self action:@selector(collectClick) forControlEvents:UIControlEventTouchUpInside];
    [self.collectionBtn setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.38] forState:UIControlStateNormal];
    [self.collectionBtn setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.38] forState:UIControlStateSelected];
    self.collectionBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [self addSubview:self.collectionBtn];
    CGSize titleSize = CGSizeMake(25, 15);
    CGSize imageSize = CGSizeMake(24, 20);
//    self.collectionBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left:-imageSize.width, bottom: -imageSize.height - 5, right: 0);
//    self.collectionBtn.imageEdgeInsets = UIEdgeInsets(top: -titleSize.height - 5, left: 0, bottom: 0, right: -titleSize.width);
    self.collectionBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -imageSize.height - 5, 0);
    self.collectionBtn.imageEdgeInsets = UIEdgeInsetsMake(-titleSize.height - 5, 0, 0, -titleSize.width);
    
    self.cycleView.imageURLStringsGroup = self.detailModel.special.swiperlist;
    self.titleLabel.text = self.detailModel.special.special.title;
    self.abstactLabel.text = self.detailModel.special.special.abstract;
    self.priceLabel.text = [self.detailModel.special.special.money getPrice];
    self.courseLabel.text = [self.detailModel.special.special.money getCourse];
    self.readLabel.text = [self.detailModel.special.special.browse_count getStudyTimes];
    self.collectionBtn.selected = self.detailModel.special.special.collect;
    
    if (self.detailModel.special.special.label.count > 0) {
        self.typeLabel1.text = self.detailModel.special.special.label[0];
        self.typeLabel1.hidden = NO;
    }else{
        self.typeLabel1.hidden = YES;
    }
    if (self.detailModel.special.special.label.count > 1) {
        self.typeLabel2.text = self.detailModel.special.special.label[1];
        self.typeLabel2.hidden = NO;
    }else{
        self.typeLabel2.hidden = YES;
    }
    
}
//778 416
- (void)layoutSubviews{
    self.cycleView.frame = CGRectMake(0, 0, self.width, self.width*(208.0/389.0));
    self.collectionBtn.frame = CGRectMake(ScreenW - 60, self.cycleView.bottom + 10, 40, 45);

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(14);
        make.top.mas_equalTo(self.cycleView.mas_bottom).offset(20);
    }];
    
    [self.abstactLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(self).offset(-14);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.abstactLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(self.abstactLabel);
    }];
    
    [self.separtLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.mas_right).offset(6);
        make.width.mas_equalTo(1/[UIScreen mainScreen].scale);
        make.top.bottom.mas_equalTo(self.priceLabel);
    }];
    
    [self.courseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.separtLine).offset(6);
        make.centerY.mas_equalTo(self.separtLine);
    }];
    
    [self.readLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.courseLabel);
        make.right.mas_equalTo(self).offset(-14);
    }];
    
    [self.readIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.readLabel);
        make.right.mas_equalTo(self.readLabel.mas_left).offset(-6);
        make.size.mas_equalTo(CGSizeMake(14, 12));
    }];
    
    [self.typeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.mas_equalTo(self.titleLabel);
           make.left.mas_equalTo(self.titleLabel.mas_right).offset(10);
       }];
       
    [self.typeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.left.mas_equalTo(self.typeLabel1.mas_right).offset(10);
    }];
    
}

- (void)collectClick{
    
    CS_Weakify(self, weakSelf);
    [[CSNetworkManager sharedManager] addOrRemoveFavoriteInfoWithArtorId:self.detailModel.special.special.specialId successComplete:^(CSNetResponseModel *response) {
        if (response.code == 200) {
            weakSelf.collectionBtn.selected = !weakSelf.collectionBtn.selected;
        }
        
    } failureComplete:^(NSError *error) {
        
    }];
}


- (YYLabel*)typeLabel1{
    if (!_typeLabel1) {
        _typeLabel1 = [[YYLabel alloc]initWithFrame:CGRectZero];
        _typeLabel1.textContainerInset = UIEdgeInsetsMake(4, 4, 4, 4);
        _typeLabel1.layer.masksToBounds = YES;
        _typeLabel1.layer.cornerRadius = 2.0f;
        _typeLabel1.layer.borderWidth = 1;
        _typeLabel1.layer.borderColor = [UIColor colorWithHexString:@"#FF584C" alpha:0.6].CGColor;
        _typeLabel1.textColor = [UIColor colorWithHexString:@"#FF584C" alpha:0.6];
        _typeLabel1.font = [UIFont systemFontOfSize:9.0f];
    }
    return _typeLabel1;
}

- (YYLabel*)typeLabel2{
    if (!_typeLabel2) {
        _typeLabel2 = [[YYLabel alloc]initWithFrame:CGRectZero];
        _typeLabel2.textContainerInset = UIEdgeInsetsMake(4, 4, 4, 4);
        _typeLabel2.layer.masksToBounds = YES;
        _typeLabel2.layer.cornerRadius = 2.0f;
        _typeLabel2.layer.borderWidth = 1;
        _typeLabel2.layer.borderColor = [UIColor colorWithHexString:@"#BC86FC" alpha:0.6].CGColor;
        _typeLabel2.textColor = [UIColor colorWithHexString:@"#BC86FC" alpha:0.6];
        _typeLabel2.font = [UIFont systemFontOfSize:9.0f];
    }
    return _typeLabel2;
}

@end
