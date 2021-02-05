//
//  CSNewHomeFindHotStudy.m
//  ColorStar
//
//  Created by apple on 2020/11/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewHomeFindHotStudyCell.h"
@interface CSNewHomeFindHotStudyCell()
@property (nonatomic, strong)UIImageView        *headImage;
@property (nonatomic, strong)UILabel            *nameLabel;
@property (nonatomic, strong)UILabel            *typeLabel;
@property (nonatomic, strong)UILabel            *tagLabel;
@property (nonatomic, strong)UIButton           *rightButton;
@property (nonatomic, strong)CSNewHomeFindstudyModel *currentModel;
@end
@implementation CSNewHomeFindHotStudyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
        [self makeUI];
    }
    return self;
}

- (void)makeUI{
    self.headImage = [[UIImageView alloc] init];
    ViewRadius(self.headImage, 6);
    self.headImage.clipsToBounds = YES;
    [self.contentView addSubview:self.headImage];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(12*widthScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10*heightScale);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10*heightScale);
        make.width.mas_offset(@(130*widthScale));
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    //self.nameLabel.text = NSLocalizedString(@"王文文",nil);
    self.nameLabel.font = kFont(14);
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImage.mas_right).offset(13* widthScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-46* widthScale);
        make.top.mas_equalTo(self.headImage.mas_top).offset(11*heightScale);
    }];
    
    self.typeLabel = [[UILabel alloc] init];
    //self.typeLabel.text = NSLocalizedString(@"美妆老师",nil);
    self.typeLabel.font = kFont(14);
    self.typeLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.typeLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.typeLabel];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImage.mas_right).offset(13* widthScale);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(7*heightScale);
    }];
    
    self.tagLabel = [[UILabel alloc] init];
    //self.tagLabel.text = NSLocalizedString(@"每日美妆知识",nil);
    self.tagLabel.font = kFont(10);
    self.tagLabel.textColor = [UIColor colorWithHexString:@"#D7B393"];
    self.tagLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.tagLabel];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeLabel.mas_right).offset(4* widthScale);
        make.centerY.mas_equalTo(self.typeLabel.mas_centerY);
    }];
    
    self.rightButton = [[UIButton alloc] init];
    [self.rightButton setImage:[UIImage imageNamed:@"CSHomeRecommendEveryDayRight"] forState:UIControlStateNormal];
    CS_Weakify(self, weakSelf);
    [self.rightButton setTapActionWithBlock:^{
            CSTutorPlayViewController *vc = [CSTutorPlayViewController new];
    //        vc.specialId = model;
            vc.videoId = weakSelf.model.study_id;;
            [[CSTotalTool getCurrentShowViewController].navigationController pushViewController:vc animated:YES];

    }];
//    [self.rightButton addTarget:self action:@selector(attentionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.rightButton];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(@(26));
        make.height.mas_offset(@(26));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20*widthScale);
        make.centerY.mas_equalTo(self.headImage.mas_centerY);
    }];
}

- (void)setModel:(CSNewHomeFindstudyModel *)model
{
    _model = model;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"CSNewListBgDefaault.png"]];
    self.nameLabel.text = model.title;
    self.typeLabel.text = model.subjec_name.firstObject;
    self.tagLabel.text = model.label.firstObject;
    self.currentModel = model;
    
}
@end
