//
//  CSVideoDetailCell.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/13.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorVideoDetailCell.h"
#import <YYText/YYText.h>
#import "CSColorStar.h"
#import "UIColor+CS.h"
#import "CSTutorVideoModel.h"

//cs_tutor_new_course_checkmore
@interface CSTutorVideoDetailCell ()

@property (nonatomic, strong)UILabel  * titleLabel;

@property (nonatomic, strong)UILabel  * dateLabel;

@property (nonatomic, strong)YYLabel  * detailLabel;

@property (nonatomic, strong)CSTutorVideoModel * model;

@end

@implementation CSTutorVideoDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
        self.contentView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.detailLabel];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(20);
        make.top.mas_equalTo(self.contentView).offset(14);
        make.right.mas_equalTo(self.contentView).offset(-20);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(4);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dateLabel);
        make.top.mas_equalTo(self.dateLabel.mas_bottom).offset(6);
        make.right.mas_equalTo(self.contentView).offset(-15);
    }];
    
}

- (void)mockData{
    self.titleLabel.text = @"";
    self.dateLabel.text = @"";
    self.detailLabel.text = @"";
}

- (void)configModel:(id)model{
    if (![model isKindOfClass:[CSTutorVideoModel class]]) {
        return;
    }
    self.model = model;
    
    self.titleLabel.text = self.model.taskInfo.title;
    self.dateLabel.text = [NSString stringWithFormat:@"%@ %@%@",self.model.taskInfo.add_time,self.model.taskInfo.play_count,csnation(@"播放")];
    self.detailLabel.text = self.model.taskInfo.content;
    
    
}

#pragma mark - properties method

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textColor = LoadColor(@"#FFFFFF");
        _titleLabel.font = [UIFont boldSystemFontOfSize:19.0f];
    }
    return _titleLabel;
}

- (UILabel*)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _dateLabel.textColor = [UIColor colorWithHexString:@"#B6B6B6" alpha:0.6];
        _dateLabel.font = [UIFont systemFontOfSize:11.0f];
    }
    return _dateLabel;
}

- (YYLabel*)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[YYLabel alloc]initWithFrame:CGRectZero];
        _detailLabel.textColor = [UIColor colorWithHexString:@"#B6B6B6" alpha:0.6];
        _detailLabel.font = [UIFont systemFontOfSize:12.0f];
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}

@end
