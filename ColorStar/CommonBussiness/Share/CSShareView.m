//
//  CSShareView.m
//  ColorStar
//
//  Created by gavin on 2020/12/19.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSShareView.h"
#import "CSBaseCollectionCell.h"
#import "CSShareModel.h"
#import "CSShareManager.h"
@interface CSShareViewItemView : CSBaseCollectionCell

@property (nonatomic, strong)UIImageView  * imageView;

@property (nonatomic, strong)UILabel      * titleLabel;

@property (nonatomic, strong)CSShareModel * model;

@end

@implementation CSShareViewItemView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupView];
    }
    return self;
}

- (void)setupView{
    
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.titleLabel];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(50);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.imageView);
        make.bottom.mas_equalTo(self.contentView);
    }];
    
}

- (void)configModel:(id)model{
    if (![model isKindOfClass:[CSShareModel class]]) {
        return;
    }
    self.model = model;
    self.imageView.image = self.model.icon;
    self.titleLabel.text = self.model.text;
    
}

- (UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    }
    return _imageView;
}

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = kFont(14);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end

@interface CSShareView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UIView            * containerView;

@property (nonatomic, strong)UICollectionView  * collectionView;

@property (nonatomic, strong)UIButton          * cancelBtn;

@property (nonatomic, strong)NSMutableArray    * shareList;

@end

@implementation CSShareView


- (void)cs_loadView{
    
    self.containerView = [[UIView alloc]initWithFrame:CGRectZero];
    self.containerView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(200);
    }];
    
    [self setupShareList];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(ScreenW/4, 100);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[CSShareViewItemView class] forCellWithReuseIdentifier:[CSShareViewItemView reuserIndentifier]];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.containerView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.containerView);
        make.height.mas_equalTo(100);
    }];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:self.cancelBtn];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.containerView);
        make.bottom.mas_offset(-30);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
}

- (void)show{
    [self getMaskConfig].maskColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    [super show];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.shareList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CSShareViewItemView * itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:[CSShareViewItemView reuserIndentifier] forIndexPath:indexPath];
    CSShareModel * model = self.shareList[indexPath.row];
    [itemCell configModel:model];
    return itemCell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CSShareModel * model = self.shareList[indexPath.row];

    [[CSShareManager shared] shareMessage:model];
}

- (void)cancelClick{
    [self cs_doDismiss];
}

- (void)setupShareList{
    CSShareModel * model1 = [[CSShareModel alloc] init];
    model1.icon = LoadImage(@"cs_share_circle");
    model1.text = @"微信朋友圈";
    model1.shareType = CSShareTypeWXCircle;
    
    CSShareModel * model2 = [[CSShareModel alloc] init];
    model2.icon = LoadImage(@"cs_share_weichat");
    model2.text = @"微信好友";
    model2.shareType = CSShareTypeWXChat;
    
    CSShareModel * model3 = [[CSShareModel alloc] init];
    model3.icon = LoadImage(@"cs_share_fb");
    model3.text = @"FaceBook";
    model3.shareType = CSShareTypeFB;
    
    [self.shareList addObject:model1];
    [self.shareList addObject:model2];
    [self.shareList addObject:model3];
}

- (NSMutableArray*)shareList{
    if (!_shareList) {
        _shareList = [NSMutableArray arrayWithCapacity:0];
    }
    return _shareList;
}

@end
