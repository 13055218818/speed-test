//
//  CSNewMyCollectionCell.m
//  ColorStar
//
//  Created by apple on 2020/12/19.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewMyCollectionCell.h"
@interface CSNewMyCollectionCell()
@property (nonatomic, strong)UIImageView        *topImage;
@property (nonatomic, strong)UILabel            *titleLabel;
@property (nonatomic, strong)UILabel            *detailLabel;
@property (nonatomic, strong)UIImageView        *collectionImage;
@property (nonatomic, strong)UILabel            *numLabel;

@end
@implementation CSNewMyCollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#1D263D"];
        [self makeUI];
    }
    return self;
}

- (void)makeUI{
    self.topImage = [[UIImageView alloc] init];
    self.topImage.clipsToBounds = YES;
    self.topImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.topImage];
    [self.topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
        make.height.mas_offset(@(130*heightScale));
    }];
    self.numLabel = [[UILabel alloc] init];
    self.numLabel.font = kFont(9);
    self.numLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.numLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.numLabel];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-11*heightScale);
        make.top.mas_equalTo(self.topImage.mas_bottom).offset(15*heightScale);
    }];
    self.collectionImage = [[UIImageView alloc] init];
    self.collectionImage.image = [UIImage imageNamed:@"cs_tutor_new_course_collect.png"];
    [self.contentView addSubview:self.collectionImage];
    [self.collectionImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.numLabel.mas_centerY);
        make.height.width.mas_offset(@(15*heightScale));
        make.right.mas_equalTo(self.numLabel.mas_left).offset(-3);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = kFont(12);
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(8*heightScale);
        make.right.mas_equalTo(self.collectionImage.mas_left).offset(-8*heightScale);
        make.top.mas_equalTo(self.topImage.mas_bottom).offset(8*heightScale);
    }];
    self.detailLabel = [[UILabel alloc] init];
   self.detailLabel.numberOfLines = 0;
    self.detailLabel.font = kFont(10);
    self.detailLabel.textColor = [UIColor colorWithHexString:@"#CACACA"];
    self.detailLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(8*heightScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-12*heightScale);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(8*heightScale);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-8*heightScale);
    }];
    
}
-(void)setModel:(CSNewMineModel *)model
{
    _model = model;
    [self.topImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"CSNewListBgDefaault.png"]];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ #%@",model.detail,model.subject_name]];
     [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#D7B393"] range:NSMakeRange(str.length - model.subject_name.length -1,model.subject_name.length + 1)];
    self.titleLabel.text = model.title;
    self.detailLabel.attributedText = str;
    self.numLabel.text = model.relation_count;
}

@end
