//
//  CSNewArtorCourseCell.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/10.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorCourseListCell.h"
#import "CSBaseCollectionCell.h"
#import <Masonry/Masonry.h>
#import "CSTutorDetailModel.h"

@interface CSNewArtorCourseInnerCell : CSBaseCollectionCell

@property (nonatomic, strong)UIView  * containerView;

@property (nonatomic, strong)UIImageView  * backImageView;

@property(nonatomic, strong)UILabel  * briefLabel;

@property(nonatomic, strong)UIImageView * timeImageView;
@property(nonatomic, strong)UILabel  * timeLabel;

@property (nonatomic, strong)CSTutorCourseModel  * course;

@end


@implementation CSNewArtorCourseInnerCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = LoadColor(@"#181F30");
        [self setupViews];
    }
    return self;
    
}

- (void)setupViews{
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.backImageView];
    [self.containerView addSubview:self.briefLabel];
    [self.containerView addSubview:self.timeImageView];
    [self.containerView addSubview:self.timeLabel];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.containerView);
    }];
    
    [self.briefLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.containerView).offset(-10);
        make.left.mas_equalTo(self.containerView).offset(16);
        make.right.mas_equalTo(self.containerView).offset(-65);
        
    }];
    
    [self.timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.briefLabel);
        make.right.mas_equalTo(self.containerView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(40, 15));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.timeImageView);
    }];
}

- (void)mockData{
    self.backImageView.backgroundColor = [UIColor redColor];
    self.briefLabel.text = @"第一节：《电影电视画面》快速...";
    self.timeLabel.text = @"09:46";
    
}

- (void)configModel:(id)model{
    if (![model isKindOfClass:[CSTutorCourseModel class]]) {
        return;
    }
    self.course = (CSTutorCourseModel*)model;
    
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:self.course.image] placeholderImage:LoadImage(@"")];
    self.briefLabel.text = self.course.title;
    self.timeLabel.text = self.course.play_count;
}

#pragma mark - properties

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.cornerRadius = 5;
    }
    return _containerView;
}

- (UIImageView*)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    }
    return _backImageView;
}

- (UILabel*)briefLabel{
    if (!_briefLabel) {
        _briefLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _briefLabel.textColor = [UIColor whiteColor];
        _briefLabel.font = [UIFont systemFontOfSize:13.0f];
    }
    return _briefLabel;
}

- (UIImageView*)timeImageView{
    if (!_timeImageView) {
        _timeImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _timeImageView.image = LoadImage(@"cs_artor_new_time_back");
        
    }
    return _timeImageView;
}

- (UILabel*)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _timeLabel.textColor = LoadColor(@"#181F30");
        _timeLabel.font = [UIFont systemFontOfSize:9.0f];
    }
    return _timeLabel;
}

@end



@interface CSTutorCourseListCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UIView   * iconView;

@property (nonatomic, strong)UILabel  * courseLabel;

@property (nonatomic, strong)UICollectionView  * collectionView;

@property (nonatomic, strong)NSArray * data;


@end

@implementation CSTutorCourseListCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = LoadColor(@"#181F30");
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.courseLabel];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(15, 0, 0, 0);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = LoadColor(@"#181F30");
    [self.collectionView registerClass:[CSNewArtorCourseInnerCell class] forCellWithReuseIdentifier:[CSNewArtorCourseInnerCell reuserIndentifier]];
    [self.contentView addSubview:self.collectionView];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
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
    
    self.data = (NSArray*)model;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView Method

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CSNewArtorCourseInnerCell * innerCell = [collectionView dequeueReusableCellWithReuseIdentifier:[CSNewArtorCourseInnerCell reuserIndentifier] forIndexPath:indexPath];
    CSTutorCourseModel * course = self.data[indexPath.row];
    [innerCell configModel:course];
    return innerCell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = ScreenW*3/4;
    return CGSizeMake(width, width*(165.0/270.0));
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CSTutorCourseModel * course = self.data[indexPath.row];

    if (self.cellBlock) {
        self.cellBlock(course);
    }
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
        _courseLabel.text = csnation(@"导师课程");

    }
    return _courseLabel;
}

@end
