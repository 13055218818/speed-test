//
//  CSTutorNewestCommonCell.m
//  ColorStar
//
//  Created by gavin on 2020/11/14.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorNewestCommentCell.h"
#import "CSTouchLabel.h"
#import "CSColorStar.h"
#import "UIColor+CS.h"
#import <Masonry/Masonry.h>
#import "CSTutorCommentModel.h"

@interface CSTutorCommentReplyView : UIView

@property (nonatomic, strong)UIImageView  * avtorImageView;

@property (nonatomic, strong)UILabel      * titleLabel;

@property (nonatomic, strong)UILabel      * contentLabel;

@property (nonatomic, strong)UIView       * line;

@end

@implementation CSTutorCommentReplyView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.line];
    [self addSubview:self.avtorImageView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
    }];
    
    [self.avtorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line);
        make.top.mas_equalTo(self.line).offset(5);
        make.width.height.mas_equalTo(30);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avtorImageView.mas_right).offset(5);
        make.top.mas_equalTo(self.avtorImageView);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
    }];
}


#pragma mark - Getter Method

- (UIImageView*)avtorImageView{
    if (!_avtorImageView) {
        _avtorImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _avtorImageView.layer.masksToBounds = YES;
        _avtorImageView.layer.cornerRadius = 15;
    }
    return _avtorImageView;
}

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = LoadFont(15);
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UILabel*)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _contentLabel.font = LoadFont(12);
        _contentLabel.textColor = [UIColor whiteColor];
    }
    return _contentLabel;
}

- (UIView*)line{
    if (!_line) {
        _line = [[UIView alloc]initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor whiteColor];
    }
    return _line;
}

@end

@interface CSTutorNewestCommentCell ()

@property (nonatomic, strong)UIView  * containerView;

@property (nonatomic, strong)UIImageView  * avtorImageView;

@property (nonatomic, strong)UILabel  * nameLabel;

@property (nonatomic, strong)UILabel  * commentLabel;

@property (nonatomic, strong)CSTouchLabel  * replyBtn;

@property (nonatomic, strong)UIButton  * lovebtn;

@property (nonatomic, strong)UILabel  * loveLabel;

@property (nonatomic, strong)UIView   * bottomLine;

@property (nonatomic, strong)CSTutorCommentModel  * comment;

@property (nonatomic, strong)UIView   * replyContainer;

@end

@implementation CSTutorNewestCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.contentView.backgroundColor = LoadColor(@"#213D53");
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
        self.contentView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.avtorImageView];
    [self.containerView addSubview:self.nameLabel];
    [self.containerView addSubview:self.commentLabel];
    [self.containerView addSubview:self.replyBtn];
    [self.containerView addSubview:self.lovebtn];
    [self.containerView addSubview:self.loveLabel];
    [self.containerView addSubview:self.bottomLine];
    [self.containerView addSubview:self.replyContainer];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.avtorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(12);
        make.size.mas_equalTo(CGSizeMake(48, 48));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avtorImageView).offset(2);
        make.left.mas_equalTo(self.avtorImageView.mas_right).offset(12);
    }];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(4);
        
    }];
    
    [self.replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.commentLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(40);
    }];
    
    
    [self.lovebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.commentLabel);
        make.right.mas_equalTo(self.containerView).offset(-18);
        make.size.mas_equalTo(CGSizeMake(26, 24));
    }];
    
    [self.loveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.commentLabel);
        make.left.mas_equalTo(self.lovebtn.mas_right).offset(5);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(self.containerView);
        make.left.mas_equalTo(self.nameLabel);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
    }];
    
    [self.replyContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.replyBtn.mas_bottom).offset(10);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.bottomLine.mas_top);
    }];
    
}

- (void)mockData{
    
    self.avtorImageView.backgroundColor = [UIColor redColor];
    self.nameLabel.text = @"小丸子";
    self.commentLabel.text = @"教的也太好了吧，好喜欢～";
    self.replyBtn.text = @"回复";
}

- (void)configModel:(id)model{
    
    if (![model isKindOfClass:[CSTutorCommentModel class]]) {
        return;
    }
    
    self.comment = model;
    
    if (![NSString isNilOrEmpty:self.comment.avatar]) {
        [self.avtorImageView sd_setImageWithURL:[NSURL URLWithString:self.comment.avatar] placeholderImage:LoadImage(@"")];
    }else{
        self.avtorImageView.image = LoadImage(@"");
    }
    
    self.lovebtn.selected = self.comment.is_click;
    self.nameLabel.text = self.comment.nickname;
    self.commentLabel.text = self.comment.content;
    self.replyBtn.text = csnation(@"回复");
    self.loveLabel.text = self.comment.click_count > 0 ? [@(self.comment.click_count) stringValue] : @"";
    
    [self.replyContainer removeAllSubviews];
    
    if (self.comment.down_info.count > 0) {
        CGFloat top = 0;
        for (int i = 0; i < self.comment.down_info.count; i++) {
            
            CSTutorCommentModel * replayModel = self.comment.down_info[i];
            CSTutorCommentReplyView * replayView = [[CSTutorCommentReplyView alloc]initWithFrame:CGRectZero];
            [self.replyContainer addSubview:replayView];
            replayView.titleLabel.text = [NSString stringWithFormat:@"%@ %@ %@",replayModel.nickname,csnation(@"回复"),self.comment.nickname];
            replayView.contentLabel.text = replayModel.content;
            
            if (![NSString isNilOrEmpty:replayModel.avatar]) {
                [replayView.avtorImageView sd_setImageWithURL:[NSURL URLWithString:replayModel.avatar]];
            }
            [replayView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.top.mas_equalTo(top);
                make.height.mas_equalTo(50);
            }];
            
            
            
            top += 50;
        }
    }
    
}

- (void)likeAction:(UIButton*)sender{
    
    if (self.commonBlock) {
        self.commonBlock(CSTutorNewestCommentBlockLike,self.comment);
    }
    
}

- (void)replyClick{
    
    if (self.commonBlock) {
        self.commonBlock(CSTutorNewestCommentBlockReply, self.comment);
    }
}

#pragma mark Properties Method

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _containerView;
}

- (UIImageView*)avtorImageView{
    if (!_avtorImageView) {
        _avtorImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _avtorImageView.layer.masksToBounds = YES;
        _avtorImageView.layer.cornerRadius = 24.0f;
        _avtorImageView.backgroundColor = LoadColor(@"#E7E8EA");

    }
    return _avtorImageView;
}

- (UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _nameLabel.textColor = LoadColor(@"#FFFFFF");
        _nameLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    return _nameLabel;
}

- (UILabel*)commentLabel{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _commentLabel.textColor = LoadColor(@"#FFFFFF");
        _commentLabel.font = [UIFont systemFontOfSize:12];
    }
    return _commentLabel;
}

- (CSTouchLabel*)replyBtn{
    if (!_replyBtn) {
        _replyBtn = [[CSTouchLabel alloc]initWithFrame:CGRectZero];
        _replyBtn.textColor = LoadColor(@"#FFFFFF");
        _replyBtn.font = [UIFont boldSystemFontOfSize:14];
        CS_Weakify(self, weakSelf);
        _replyBtn.touch = ^(UIView *obj) {
            [weakSelf replyClick];
        };
    }
    return _replyBtn;
}

- (UIButton*)lovebtn{
    if (!_lovebtn) {
        _lovebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lovebtn setImage:LoadImage(@"cs_tutor_new_course_like") forState:UIControlStateNormal];
        [_lovebtn setImage:LoadImage(@"cs_tutor_new_course_unlike") forState:UIControlStateSelected];
        [_lovebtn addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
        _lovebtn.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _lovebtn;
}

- (UILabel*)loveLabel{
    if (!_loveLabel) {
        _loveLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _loveLabel.textColor = LoadColor(@"#FFFFFF");
        _loveLabel.font = [UIFont boldSystemFontOfSize:12];
    }
    return _loveLabel;
}

- (UIView*)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = LoadColor(@"#4C6E88");
    }
    return _bottomLine;
}

- (UIView*)replyContainer{
    if (!_replyContainer) {
        _replyContainer = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _replyContainer;
}

@end
