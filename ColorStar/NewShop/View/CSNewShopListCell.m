//
//  CSNewShopListCell.m
//  ColorStar
//
//  Created by apple on 2020/11/16.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewShopListCell.h"
@interface CSNewShopListCell()
@property (nonatomic, strong)UIImageView        *bgImageView;
@property (nonatomic, strong)UILabel            *titleLabel;
@property (nonatomic, strong)UILabel            *detailLabel;
@property (nonatomic, strong)UILabel            *mooneyLabel;
@property (nonatomic, strong)UIButton           *findButton;
@end
@implementation CSNewShopListCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#292929"];
        ViewRadius(self, 5);
        [self makeUI];
    }
    return self;
}

-(void)makeUI{
    //cellHeight =160*heightScale + arc4random() % 30;
    
    self.mooneyLabel = [[UILabel alloc] init];
    //self.mooneyLabel.backgroundColor = [UIColor colorWithHexString:@"#DDB984"];
//    self.mooneyLabel.text = NSLocalizedString(@"08:10",nil);
    self.mooneyLabel.font = kFont(18);//kFont(18);
    self.mooneyLabel.textColor = [UIColor colorWithHexString:@"#DDB984"];
    self.mooneyLabel.textAlignment = NSTextAlignmentLeft;
//        ViewRadius(self.timeLabel, 3);
    [self.contentView addSubview:self.mooneyLabel];
    [self.mooneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(12*heightScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-50*heightScale);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10*heightScale);
        make.height.mas_offset(@(15*heightScale));
    }];
    
    self.detailLabel = [[UILabel alloc] init];
 //   self.detailLabel.text = @"280升三门电冰箱三开门无霜温小型智能变频...";
   self.detailLabel.numberOfLines = 0;
    self.detailLabel.font = kFont(10);
    self.detailLabel.textColor = [UIColor colorWithHexString:@"#B3B3B3"];
    self.detailLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(12*heightScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-12*heightScale);
        make.bottom.mas_equalTo(self.mooneyLabel.mas_top).offset(-7*heightScale);
        make.height.mas_offset(@(25*heightScale));
    }];
    
    self.titleLabel = [[UILabel alloc] init];
//    self.titleLabel.text = NSLocalizedString(@"三星（SAMSUNG）",nil);
   self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = kFont(12);
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(12*heightScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-12*heightScale);
        make.bottom.mas_equalTo(self.detailLabel.mas_top).offset(-9*heightScale);
        make.height.mas_offset(@(15*heightScale));
    }];
    
    self.bgImageView = [UIImageView new];
    self.bgImageView.clipsToBounds = YES;
    self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
 //   self.bgImageView.image = [UIImage imageNamed:@"cs_home_banner"];
    [self.contentView addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.titleLabel.mas_top).offset(-10*heightScale);
    }];

    
}


- (void)setModel:(CSNewShopModel *)model{
    _model = model;
    self.mooneyLabel.text = [NSString stringWithFormat:@"%@：%@",csnation(@"¥"),model.price];
    self.detailLabel.text = model.store_info;
    self.titleLabel.text = model.store_name;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"CSNewListBgDefaault.png"]];
}



@end
