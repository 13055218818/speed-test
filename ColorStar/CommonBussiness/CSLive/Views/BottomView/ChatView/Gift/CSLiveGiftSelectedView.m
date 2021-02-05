//
//  CSLiveGiftSelectedView.m
//  ColorStar
//
//  Created by gavin on 2020/10/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSLiveGiftSelectedView.h"
#import "CSLiveGiftCell.h"
#import "UIView+CS.h"
#import "UIColor+CS.h"
#import "CSColorStar.h"
#import <Masonry/Masonry.h>
#import "CSLiveGiftCountSelecteView.h"
#import "CSLoginManager.h"
#import "NSString+CSAlert.h"

static NSString  * CSLiveGiftCellReuseIdentifier = @"CSLiveGiftCellReuseIdentifier";

@interface CSLiveGiftSelectedView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, assign)CGFloat             bgHeight;

@property (nonatomic, strong)UIView            * topView;

@property (nonatomic, strong)UIView            * bgView;

@property (nonatomic, strong)UICollectionView  * collectionView;

@property (nonatomic, strong)UIView            * separtLineView;

@property (nonatomic, strong)UIView            * bottomView;

@property (nonatomic, strong)UIView            * bottomLeftView;
@property (nonatomic, strong)UILabel           * amountLabel;

@property (nonatomic, strong)UIView            * bottomRightView;
@property (nonatomic, strong)UILabel           * selecteGiftCountLabel;

@property (nonatomic, strong)NSString          * selecteCount;

@property (nonatomic, strong)CSLiveGiftModel   * currentGiftModel;


@property (nonatomic, strong)NSArray  * giftlist;

@end

@implementation CSLiveGiftSelectedView

- (instancetype)initWithFrame:(CGRect)frame giftlist:(NSArray*)giftlist{
    if (self = [super initWithFrame:frame]) {
        
        _giftlist = giftlist;
        _currentGiftModel = _giftlist.firstObject;
        _selecteCount = _currentGiftModel.live_gift_num.firstObject;
        _bgHeight = 270 + kSafeAreaBottomHeight;
        [self creatSubView];
        [self showAlertView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

//显示
-(void)showAlertView{
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        self.bgView.frame = CGRectMake(0, ScreenH - self.bgHeight, ScreenW, self.bgHeight) ;
    }] ;
}

//隐藏
-(void)removeAlertView{
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0] ;
        self.bgView.frame = CGRectMake(0, ScreenH, ScreenW, self.bgHeight) ;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }] ;
}

- (void)creatSubView{
    
    self.topView = [[UIView alloc]initWithFrame:CGRectZero];
    self.topView.backgroundColor = [UIColor clearColor];
    [self.topView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(readyRemoveAlertView:)]];
    self.topView.frame = CGRectMake(0, 0, ScreenW, ScreenH - self.bgHeight);
    [self addSubview:self.topView];
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenH, ScreenW, self.bgHeight)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0] ;
    [self addSubview:self.bgView];
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake((self.width - 10)/4, 100);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, 220) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.bgView addSubview:self.collectionView];
    [self.collectionView registerClass:[CSLiveGiftCell class] forCellWithReuseIdentifier:CSLiveGiftCellReuseIdentifier];
    
    self.separtLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.collectionView.bottom, self.width, 1)];
    self.separtLineView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [self.bgView addSubview:self.separtLineView];
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.separtLineView.bottom, self.width, 50)];
    [self.bgView addSubview:self.bottomView];
    
    [self setupBottomView];
    
}

- (void)setupBottomView{
    
    self.bottomLeftView = [[UIView alloc]initWithFrame:CGRectMake(10, 15, 200, 20)];
    [self.bottomView addSubview:self.bottomLeftView];
    
    UIImageView * goldImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    goldImageView.image = LoadImage(@"cs_live_gift_gold");
    [self.bottomLeftView addSubview:goldImageView];
    [goldImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomLeftView);
        make.centerY.mas_equalTo(self.bottomLeftView);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    self.amountLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.amountLabel.textColor = [UIColor blackColor];
    self.amountLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.bottomLeftView addSubview:self.amountLabel];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(goldImageView);
        make.left.mas_equalTo(goldImageView.mas_right).offset(6);
    }];
    
    CS_Weakify(self, weakSelf);
    [self.amountLabel setTapActionWithBlock:^{
        if (weakSelf.rechargeClick) {
            weakSelf.rechargeClick();
        }
    }];
    
    
    UIImageView * leftImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    leftImageView.image = LoadImage(@"cs_live_gift_bottom_left_arrow");
    [self.bottomLeftView addSubview:leftImageView];
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.amountLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self.amountLabel);
        make.size.mas_equalTo(CGSizeMake(7, 13));
    }];
    
    
    
    self.bottomRightView = [[UIView alloc]initWithFrame:CGRectMake(self.width - 170, 10, 160, 30)];
    self.bottomRightView.layer.masksToBounds = YES;
    self.bottomRightView.layer.cornerRadius = 15;
    self.bottomRightView.layer.borderWidth = 1;
    self.bottomRightView.layer.borderColor = [UIColor colorWithHexString:@"#549CFC"].CGColor;
    [self.bottomView addSubview:self.bottomRightView];
    
    UIButton * giveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    giveBtn.frame = CGRectMake(80, 0, 80, 30);
    [giveBtn setTitle:@"赠送" forState:UIControlStateNormal];
    giveBtn.backgroundColor = [UIColor colorWithHexString:@"#549CFC"];
    [giveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    giveBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [giveBtn addTarget:self action:@selector(giveClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomRightView addSubview:giveBtn];
    
    UIView * gitfCountView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    [gitfCountView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selecteGiftCount)]];
    [self.bottomRightView addSubview:gitfCountView];
    
    self.selecteGiftCountLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.selecteGiftCountLabel.textColor = [UIColor blackColor];
    self.selecteGiftCountLabel.font = [UIFont systemFontOfSize:15.0f];
    self.selecteGiftCountLabel.text = self.selecteCount;
    [gitfCountView addSubview:self.selecteGiftCountLabel];
    [self.selecteGiftCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomRightView);
        make.right.mas_equalTo(gitfCountView.mas_centerX).offset(-5);
    }];
    
    UIImageView * selecteGiftArrowImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    selecteGiftArrowImageView.image = LoadImage(@"cs_live_gift_bottom_right_arrow");
    [gitfCountView addSubview:selecteGiftArrowImageView];
    [selecteGiftArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.selecteGiftCountLabel);
        make.left.mas_equalTo(gitfCountView.mas_centerX).offset(5);
        make.size.mas_equalTo(CGSizeMake(13, 7));
    }];
    
    
}

- (void)setGoldCount:(NSString *)goldCount{
    _goldCount = goldCount;
    self.amountLabel.text = _goldCount;
}


#pragma mark - UITapGestureRecognizer Method

- (void)readyRemoveAlertView:(UITapGestureRecognizer*)gesture{
//    CGPoint locationPoint = [gesture locationInView:self];
//    locationPoint = [self.bgView.layer convertPoint:locationPoint fromLayer:self.layer];
//    if (![self.bgView.layer containsPoint:locationPoint]) {
//        [self removeAlertView];
//    }
    [self removeAlertView];
}

- (void)selecteGiftCount{
    
    CGPoint point = CGPointMake(self.bottomRightView.origin.x + 40, self.bottomView.origin.y + 10 + self.bgView.origin.y);
    
//    point = [self.bottomRightView convertPoint:point toView:self.window];
    
    [CSLiveGiftCountSelecteView addGiftCountSelecteViewWithPoint:point selectData:self.currentGiftModel.live_gift_num action:^(NSInteger index) {
        NSString * count = self.currentGiftModel.live_gift_num[index];
        self.selecteCount = count;
        self.selecteGiftCountLabel.text = self.selecteCount;
        
    } animated:YES];
    
    
}


- (void)giveClick:(UIButton*)sender{
    
   
    
    
    if (![self.selecteCount isEqualToString:@"0"]) {
        
        NSInteger ammount = [self.goldCount integerValue];
        NSInteger cost = [self.selecteCount integerValue] * [self.currentGiftModel.live_gift_price integerValue];
        if (ammount < cost) {
            
            [WHToast showMessage:csnation(@"金币不够,请充值") duration:1.0 finishHandler:^{
                if (self.rechargeClick) {
                    self.rechargeClick();
                }
            }];
            return;
        }
        
        NSString * giftId = self.currentGiftModel.giftId;
        NSString * giftName = self.currentGiftModel.live_gift_name;
        NSString * giftPrice = self.currentGiftModel.live_gift_price;
        NSString * giftImage = self.currentGiftModel.live_gift_show_img;
        if (self.giveClick) {
            self.giveClick(self.selecteCount, giftId,giftName,giftPrice,giftImage);
        }
    }
    [self removeAlertView];
    
}

- (void)setGiftlist:(NSArray *)giftlist{
    _giftlist = giftlist;
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
}

#pragma mark - UICollectionViewDataSource Method

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.giftlist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CSLiveGiftCell * giftCell = [collectionView dequeueReusableCellWithReuseIdentifier:CSLiveGiftCellReuseIdentifier forIndexPath:indexPath];
    CSLiveGiftModel * model = self.giftlist[indexPath.row];
    giftCell.giftModel = model;
    if ([model isEqual:self.currentGiftModel]) {
        giftCell.containerView.backgroundColor = [UIColor colorWithHexString:@"#549CFC" alpha:0.20];
    }else{
        giftCell.containerView.backgroundColor = [UIColor clearColor];
    }
    return giftCell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CSLiveGiftModel * model = self.giftlist[indexPath.row];
    
    if ([model isEqual:self.currentGiftModel]) {
        return;
    }
    
    self.currentGiftModel = model;
    [self.collectionView reloadData];
    
}

@end
