//
//  CSHomeCheckCell.m
//  ColorStar
//
//  Created by gavin on 2020/8/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeCheckCell.h"
#import "CSHomeSquareCell.h"

NSString * const CSHomeSquareCellTwoReuseIdentifier = @"CSHomeSquareCellTwoReuseIdentifier";

@interface CSHomeCheckCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView * collectionView;

@property (nonatomic, strong)NSMutableArray   * array;

@end

@implementation CSHomeCheckCell

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
    [self.collectionView registerClass:[CSHomeSquareCell class] forCellWithReuseIdentifier:CSHomeSquareCellTwoReuseIdentifier];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.contentView addSubview:self.collectionView];
    
}

- (void)configModel:(CSHomeTopicSectionModel*)model{
    [self.array removeAllObjects];
    [self.array addObjectsFromArray:model.list];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView Method

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CSHomeSquareCell * squareCell = [collectionView dequeueReusableCellWithReuseIdentifier:CSHomeSquareCellTwoReuseIdentifier forIndexPath:indexPath];
    CSHomeTopicBaseModel * topicModel = self.array[indexPath.row];
    [squareCell configurModel:topicModel];
    return squareCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}


#pragma mark - Properties Method

- (NSMutableArray*)array{
    if (!_array) {
        _array = [NSMutableArray arrayWithCapacity:0];
    }
    return _array;
}



@end
