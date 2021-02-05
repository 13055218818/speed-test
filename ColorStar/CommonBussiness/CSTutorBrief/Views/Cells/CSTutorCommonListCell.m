//
//  CSNewArtorCommonCell.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/10.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorCommonListCell.h"
#import "CSBaseCollectionCell.h"
#import "CSTutorCommentModel.h"
#import "CSTutorVideoPlayManager.h"

@interface CSNewArtorCommonInnerCell : CSBaseCollectionCell

@property (nonatomic, strong)UIView  * containerView;

@property (nonatomic, strong)UIImageView  * portraitImageView;

@property (nonatomic, strong)UILabel * nameLabel;

@property (nonatomic, strong)UILabel * numberLabel;

@property (nonatomic, strong)UIImageView  * commonImageView;

@property (nonatomic, strong)UILabel * commonLabel;

@property (nonatomic, strong)UILabel * replyBtn;

@property (nonatomic, strong)UILabel  * dateLabel;

@property (nonatomic, strong)CSTutorCommentModel * comment;
@end

@implementation CSNewArtorCommonInnerCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
        self.contentView.backgroundColor = LoadColor(@"#181F30");
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.portraitImageView];
    [self.containerView addSubview:self.nameLabel];
    [self.containerView addSubview:self.numberLabel];
    [self.containerView addSubview:self.commonImageView];
    [self.containerView addSubview:self.commonLabel];
    [self.containerView addSubview:self.replyBtn];
    [self.containerView addSubview:self.dateLabel];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.portraitImageView);
        make.left.mas_equalTo(self.portraitImageView.mas_right).offset(10);
        
    }];
    
    [self.commonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.portraitImageView);
        make.right.mas_equalTo(-15);
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.portraitImageView);
        make.right.mas_equalTo(self.commonImageView.mas_left).offset(-5);
    }];
    
    
    [self.commonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.portraitImageView);
        make.right.mas_equalTo(self.commonImageView);
        make.top.mas_equalTo(self.portraitImageView.mas_bottom).offset(15);
        make.bottom.mas_lessThanOrEqualTo(self.containerView).offset(-35);
    }];
    
    [self.replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.commonLabel);
        make.bottom.mas_equalTo(self.containerView).offset(-15);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.replyBtn);
        make.right.mas_equalTo(self.commonLabel);
    }];
    
}

- (void)mockData{
    self.portraitImageView.backgroundColor = [UIColor greenColor];
    self.nameLabel.text = @"之所以不说";
    self.numberLabel.text = @"256";
    self.commonImageView.image = LoadImage(@"cs_artor_new_common_normal");
    self.commonLabel.text = @"绝不像攀援的凌霄花，借你的高枝炫耀自己；我如果爱你，绝不学痴情的鸟儿，为绿荫重复单调的歌曲；也不止像泉源，常年送来清凉的慰藉；也不止像险峰，增加你的高度，衬托你的威仪。甚至日光，甚至春雨。";
    self.replyBtn.text = @"回复";
    self.dateLabel.text = @"2020/11/03";
}

- (void)configModel:(id)model{
    if (![model isKindOfClass:[CSTutorCommentModel class]]) {
        return;
    }
    
    self.comment = (CSTutorCommentModel*)model;
    
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:self.comment.avatar] placeholderImage:LoadImage(@"")];
    self.nameLabel.text = self.comment.nickname;
    self.numberLabel.text = self.comment.click_count > 0 ? [@(self.comment.click_count) stringValue] : @"";
    self.commonImageView.image = LoadImage((self.comment.is_click ? @"cs_artor_new_common_selected" : @"cs_artor_new_common_normal"));
    self.commonLabel.text = self.comment.content;
    self.dateLabel.text = self.comment.add_time;
    
}

- (void)commentLike{
    
    if (![CSNewLoginUserInfoManager sharedManager].isLogin) {
        [[CSNewLoginUserInfoManager sharedManager] goToLogin:^(BOOL success) {
                    if (success) {
                        [self doCommentLike];
                    }
                }];
        return;
    }
    
    [self doCommentLike];
}

- (void)doCommentLike{
    
    CS_Weakify(self, weakSelf);
    [[CSTutorVideoPlayManager shared] commentLike:self.comment.commonId complete:^(CSNetResponseModel *response, NSError *error) {
            if (response.code == 200) {
                weakSelf.comment.is_click = !self.comment.is_click;
                weakSelf.commonImageView.image = LoadImage((self.comment.is_click ? @"cs_artor_new_common_selected" : @"cs_artor_new_common_normal"));
            }
        }];
    
}

#pragma mark - properties

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.cornerRadius = 3.5;
        _containerView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.06];
    }
    return _containerView;
}

- (UIImageView*)portraitImageView{
    if (!_portraitImageView) {
        _portraitImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _portraitImageView.layer.masksToBounds = YES;
        _portraitImageView.layer.cornerRadius = 35/2.0;
        _portraitImageView.backgroundColor = LoadColor(@"#E7E8EA");

    }
    return _portraitImageView;
}

- (UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _nameLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

- (UILabel*)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _numberLabel;
}

- (UIImageView*)commonImageView{
    if (!_commonImageView) {
        _commonImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        CS_Weakify(self, weakSelf);
        [_commonImageView setTapActionWithBlock:^{
            [weakSelf commentLike];
        }];
    }
    return _commonImageView;
}

- (UILabel*)commonLabel{
    if (!_commonLabel) {
        _commonLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _commonLabel.textColor = [UIColor whiteColor];
        _commonLabel.font = [UIFont systemFontOfSize:12.0f];
        _commonLabel.numberOfLines = 0;
    }
    return _commonLabel;
}

- (UILabel*)replyBtn{
    if (!_replyBtn) {
        _replyBtn = [[UILabel alloc]initWithFrame:CGRectZero];
        _replyBtn.textColor = [UIColor whiteColor];
        _replyBtn.font = [UIFont systemFontOfSize:12.0f];
        _replyBtn.text = csnation(@"回复");
    }
    return _replyBtn;
}

- (UILabel*)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _dateLabel;
}

@end

@interface CSTutorCommonListCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UIView   * containerView;

@property (nonatomic, strong)UIView   * iconView;

@property (nonatomic, strong)UILabel  * courseLabel;

@property (nonatomic, strong)UICollectionView  * collectionView;

@property (nonatomic, strong)NSArray  * comments;

@end

@implementation CSTutorCommonListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = LoadColor(@"#181F30");
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self.contentView addSubview:self.containerView];
    
    [self.containerView addSubview:self.iconView];
    [self.containerView addSubview:self.courseLabel];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[CSNewArtorCommonInnerCell class] forCellWithReuseIdentifier:[CSNewArtorCommonInnerCell reuserIndentifier]];
    self.collectionView.backgroundColor = LoadColor(@"#181F30");
    [self.containerView addSubview:self.collectionView];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(3, 15));
    }];
    
    [self.courseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconView);
        make.left.mas_equalTo(self.iconView.mas_right).offset(5);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.top.mas_equalTo(50);
    }];
    
}

- (void)mockData{
}

- (void)configModel:(id)model{
    if (![model isKindOfClass:[NSArray class]]) {
        return;
    }
    self.containerView.hidden = ((NSArray*)model).count == 0;
    
    self.comments = (NSArray*)model;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView Method

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.comments.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CSNewArtorCommonInnerCell * innerCell = [collectionView dequeueReusableCellWithReuseIdentifier:[CSNewArtorCommonInnerCell reuserIndentifier] forIndexPath:indexPath];
    CSTutorCommentModel * common = self.comments[indexPath.row];
    [innerCell configModel:common];
    return innerCell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = widthScale*315.0f;
    return CGSizeMake(width, width*(165.0/315.0));
}

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _containerView;
}

- (UIView*)iconView{
    if (!_iconView) {
        _iconView = [[UIView alloc]initWithFrame:CGRectZero];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)LoadColor(@"#A890FF").CGColor, (__bridge id)LoadColor(@"#EC0FE9").CGColor];
        gradientLayer.locations = @[@0.0,@1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 1.0);
        gradientLayer.frame = CGRectMake(0, 0, 3, 15);
        [_iconView.layer addSublayer:gradientLayer];
    }
    return _iconView;
}

- (UILabel*)courseLabel{
    if (!_courseLabel) {
        _courseLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _courseLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        _courseLabel.textColor = [UIColor whiteColor];
        _courseLabel.text = csnation(@"热门评论");
    }
    return _courseLabel;
}

@end
