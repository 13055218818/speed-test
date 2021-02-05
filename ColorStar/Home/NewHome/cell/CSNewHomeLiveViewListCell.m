//
//  CSNewHomeLiveViewListCell.m
//  ColorStar
//
//  Created by apple on 2020/11/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewHomeLiveViewListCell.h"
@interface CSNewHomeLiveViewListCell()
@property (nonatomic, strong)UIImageView        *bgImageView;
@property (nonatomic, strong)UIButton           *statuButton;
@property (nonatomic, strong)UIButton           *numsButton;
@property (nonatomic, strong)UILabel            *titleLabel;
@property (nonatomic, strong)UILabel            *nameLabel;
@property (nonatomic, strong)CSNewHomeLiveListModel  *currentModel;
@end

@implementation CSNewHomeLiveViewListCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
        self.currentModel = [[CSNewHomeLiveListModel alloc] init];
        [self makeUI];
    }
    return self;
}
-(void)makeUI{
    UIView *view = [[UIView alloc] init];
    [self.contentView addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(@(100));
        make.left.right.top.bottom.mas_equalTo(self.contentView);
    }];
    
    self.bgImageView = [UIImageView new];
    ViewRadius(self.bgImageView, 6);
    //self.bgImageView.image = [UIImage imageNamed:@"cs_home_banner"];
    self.bgImageView.clipsToBounds = YES;
    self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [view addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(view);
    }];
    
    self.statuButton = [[UIButton alloc] init];
    self.statuButton.titleLabel.font = kFont(10);
    
    ViewRadius(self.statuButton, 10*heightScale);
    [self.statuButton setImage:[UIImage imageNamed:@"CSNewHomeLiveViewListCellPoint.png"] forState:UIControlStateNormal];
    [self.statuButton setBackgroundColor:[UIColor colorWithHexString:@"#C2C2C2" alpha:0.5]];
    [self.statuButton setTitleColor:[UIColor colorWithHexString:@"#202020"] forState:UIControlStateNormal];
    [self.statuButton addTarget:self action:@selector(attentionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.statuButton];
    
    [self.statuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(@(55*widthScale));
        make.height.mas_offset(@(20*heightScale));
        make.left.mas_equalTo(view.mas_left).offset(12*heightScale);
        make.top.mas_equalTo(view.mas_top).offset(12*heightScale);
    }];
    
    self.numsButton = [[UIButton alloc] init];
    self.numsButton.titleLabel.font = [UIFont systemFontOfSize:8.0];
    
    ViewRadius(self.numsButton, 6*heightScale);
    [self.numsButton setImage:[UIImage imageNamed:@"CSNewHomeLiveViewListCellNum.png"] forState:UIControlStateNormal];
    [self.numsButton setBackgroundColor:[UIColor colorWithHexString:@"#C2C2C2" alpha:0.5]];
    [self.numsButton setTitleColor:[UIColor colorWithHexString:@"#202020"] forState:UIControlStateNormal];
    [view addSubview:self.numsButton];
    CGFloat width2 = [self getButtonWidth:@"1333333" WithFont:8.0];
    [self.numsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(@(width2));
        make.height.mas_offset(@(12*heightScale));
        make.right.mas_equalTo(view.mas_right).offset(-12*heightScale);
        make.centerY.mas_equalTo(self.statuButton.mas_centerY);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    //self.nameLabel.text = NSLocalizedString(@"聚来提·马合木提",nil);
    self.nameLabel.font = kFont(9);
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).offset(12*heightScale);
        make.bottom.mas_equalTo(view.mas_bottom).offset(-16*heightScale);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    //self.titleLabel.text = NSLocalizedString(@"聚来提·马合木提",nil);
    self.titleLabel.font = kFont(13);
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).offset(12*heightScale);
        make.bottom.mas_equalTo(self.nameLabel.mas_top).offset(-6*heightScale);
    }];
    
    
}

- (CGFloat)getButtonWidth:(NSString *)str WithFont:(CGFloat)font{
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]}];
    CGSize statuseStrSize = CGSizeMake(ceilf(size.width), ceilf(size.height));

    CGFloat labWith =statuseStrSize.width +20;
    return labWith;
}
//-(UICollectionViewLayoutAttributes *) preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes { [super preferredLayoutAttributesFittingAttributes:layoutAttributes]; UICollectionViewLayoutAttributes *attributes = [layoutAttributes copy]; attributes.size = CGSizeMake((ScreenW-30*widthScale)/2, 218*heightScale);
//    return attributes;
//}

- (void)setModel:(CSNewHomeLiveListModel *)model{
    _model = model;
    self.currentModel = model;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:self.currentModel.live_image] placeholderImage:[UIImage imageNamed:@"CSNewListBgDefaault.png"]];
    self.nameLabel.text = self.currentModel.name;
    self.titleLabel.text = self.currentModel.live_title;
    if ([self.currentModel.is_play isEqual:@"0"]) {
        [self.statuButton setTitle:NSLocalizedString(@"未直播",nil) forState:UIControlStateNormal];
        CGFloat width = [self getButtonWidth:NSLocalizedString(@"未直播",nil) WithFont:10.0];
        [self.statuButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(@(width));
        }];
    }else{
        [self.statuButton setTitle:NSLocalizedString(@"直播中",nil) forState:UIControlStateNormal];
        CGFloat width = [self getButtonWidth:NSLocalizedString(@"直播中",nil) WithFont:10.0];
        [self.statuButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(@(width));
        }];
    }
    [self.numsButton setTitle:self.currentModel.browse_count forState:UIControlStateNormal];
}

@end
