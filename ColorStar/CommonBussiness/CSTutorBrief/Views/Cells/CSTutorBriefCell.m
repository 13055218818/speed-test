//
//  CSNewArtorBriefCell.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorBriefCell.h"
#import "CSTutorDetailModel.h"

@interface CSTutorBriefCell ()

@property (nonatomic, strong)UIView   * containerView;

@property (nonatomic, strong)UILabel  * titleLabel;

@property (nonatomic, strong)UILabel  * detailLabel;

@property (nonatomic, strong)UIButton * expandBtn;

@property (nonatomic, strong)CSTutorDetailModel * detail;

@end

@implementation CSTutorBriefCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = LoadColor(@"#181F30");
        self.contentView.backgroundColor = LoadColor(@"#181F30");
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.detailLabel];
    [self.containerView addSubview:self.expandBtn];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(20);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(15);
        make.right.mas_equalTo(self.containerView).offset(-15);
    }];
    
    [self.expandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailLabel.mas_bottom).offset(5);
        make.right.mas_equalTo(self.detailLabel);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}

- (CGSize)collectionCellSizeForText:(NSString*)text{
    
    CGFloat originHeight = 20 + 14 + 25;
    
    CGSize detailSize = [text boundingRectWithSize:CGSizeMake(ScreenW - 30, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]} context:nil].size;
    
    return CGSizeMake(ScreenW, originHeight + detailSize.height);
}

- (void)mockData{
    self.titleLabel.text = @"导演 / 编剧/ 制片人 ";
    self.detailLabel.text = @"Bobby Roth，是一名导演、编剧、制片人。主要作品有《勇敢新女孩》等!第35届(1985) - 金熊奖偷心人 Heartbreak -ers (1984),现任彩色世界特约导师...";
}

- (void)configModel:(id)model{
    if (![model isKindOfClass:[CSTutorDetailModel class]]) {
        return;
    }
    self.detail = (CSTutorDetailModel*)model;
    self.titleLabel.text = [self.detail.label componentsJoinedByString:@"/"];
    self.detailLabel.text = self.detail.abstract;
    self.expandBtn.selected = self.detail.expanding;
    self.expandBtn.hidden = !self.detail.shouldExpand;
    [self.detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.detail.expanding ? self.detail.textHeight : 50);
    }];
}

- (void)expandClick{
    self.expandBtn.selected = !self.expandBtn.selected;
    self.detail.expanding = !self.detail.expanding;
    if (self.briefBlock) {
        self.briefBlock();
    }
    [self.detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.detail.expanding ? self.detail.textHeight : 50);
    }];
    
}

#pragma mark - Properties Method

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _containerView;
}

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UILabel*)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _detailLabel.font = [UIFont systemFontOfSize:13.0f];
        _detailLabel.textColor = [UIColor whiteColor];
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}

- (UIButton*)expandBtn{
    if (!_expandBtn) {
        _expandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_expandBtn setImage:LoadImage(@"cs_artor_new_expand") forState:UIControlStateNormal];
        [_expandBtn setImage:LoadImage(@"cs_artor_new_pack") forState:UIControlStateSelected];
        [_expandBtn addTarget:self action:@selector(expandClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _expandBtn;
}



@end
