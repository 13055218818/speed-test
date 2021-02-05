//
//  CSHomeActorIconCell.m
//  ColorStar
//
//  Created by gavin on 2020/8/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeActorIconCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry.h>
#import "NSString+CS.h"
#import "UIView+CS.h"

NSString * const CSHomeActorIconItemCellReuseIdentifier = @"CSHomeActorIconItemCellReuseIdentifier";

@interface CSHomeActorIconItemCell : UICollectionViewCell

@property (nonatomic, strong)UIView   * containerView;

@property (nonatomic, strong)UIImageView  * imageView;

@property (nonatomic, strong)UILabel      * actorLabel;

@property (nonatomic, strong)CSHomeActorIconModel  * iconModel;

@end

@implementation CSHomeActorIconItemCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)configModel:(CSHomeActorIconModel*)model{
    self.iconModel = model;
    
    if (![NSString isNilOrEmpty:self.iconModel.pic]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.iconModel.pic] placeholderImage:[UIImage imageNamed:@""]];
    }
    self.actorLabel.text = self.iconModel.title;
    
}

- (void)setupViews{
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.imageView];
    [self.containerView addSubview:self.actorLabel];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.containerView);
        make.width.mas_equalTo(self.containerView);
        make.height.mas_equalTo(self.imageView.mas_width).multipliedBy(416.0/285.0);
    }];
    
    [self.actorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView);
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(10);
    }];
    
}

#pragma mark - Properties Method

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.cornerRadius = 5;
    }
    return _containerView;
}

- (UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView.image = [UIImage imageNamed:@"cs_home_banner"];
    }
    return _imageView;
}

- (UILabel*)actorLabel{
    if (!_actorLabel) {
        _actorLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _actorLabel.textColor = [UIColor whiteColor];
        _actorLabel.font = [UIFont systemFontOfSize:18.0f];
    }
    return _actorLabel;
}

@end

@interface CSHomeActorIconCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView  * collectionView;

@property (nonatomic, strong)NSArray           * models;

@end

@implementation CSHomeActorIconCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.contentView.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[CSHomeActorIconItemCell class] forCellWithReuseIdentifier:CSHomeActorIconItemCellReuseIdentifier];
    [self.contentView addSubview:self.collectionView];
    
}

- (void)configModels:(NSArray*)models{
    self.models = models;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView Method

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CSHomeActorIconItemCell * itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:CSHomeActorIconItemCellReuseIdentifier forIndexPath:indexPath];
    CSHomeActorIconModel * model = self.models[indexPath.row];
    [itemCell configModel:model];
    return itemCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(142, self.contentView.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 0, 0, 0);
}

//285x416
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
     CSHomeActorIconModel * model = self.models[indexPath.row];
    if (self.itemClick) {
        self.itemClick(model);
    }
    
}



@end
