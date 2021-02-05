//
//  CSHomeRecommendInterestingCell.m
//  ColorStar
//
//  Created by apple on 2020/11/10.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeRecommendInterestingCell.h"
#import "WMZBannerView.h"
#import "CSHomeRecommendInterestingBannerCell.h"
@interface CSHomeRecommendInterestingCell()<UIScrollViewDelegate,CSHomeRecommendInterestingBannerCellDelegate>
@property (nonatomic, strong)UIScrollView      *mainScrollerView;
@property (nonatomic, strong)WMZBannerParam     *param;
@property (nonatomic, strong)WMZBannerView      *bannerView;
@property (nonatomic, strong)NSMutableArray     *dataArray;
@end
@implementation CSHomeRecommendInterestingCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier with:(NSMutableArray *)array
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
        self.dataArray = [NSMutableArray array];
        self.dataArray = array;
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    UIImageView  *leftImage = [[UIImageView alloc] init];
    leftImage.image = [UIImage imageNamed:@"CSHomeRecommendEveryDayLeftImage.png"];
    [self.contentView addSubview:leftImage];
    [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(12*widthScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(18*heightScale);
        make.width.mas_offset(@(4*widthScale));
        make.height.mas_offset(@(15*heightScale));
    }];
    
    UILabel  *lefTitleLabel = [[UILabel alloc] init];
    lefTitleLabel.text = NSLocalizedString(@"你可能感兴趣的明星",nil);
    lefTitleLabel.font = kFont(16);
    lefTitleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    lefTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:lefTitleLabel];
    [lefTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftImage.mas_right).offset(6*widthScale);
        make.centerY.mas_equalTo(leftImage.mas_centerY);
    }];
    [self makeBanner];
}

- (void)makeBanner{
    self.param =
    BannerParam()
    //自定义视图必传
    .wMyCellClassNameSet(@"CSHomeRecommendInterestingBannerCell")
    .wMyCellSet(^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collectionView, CSNewHomeRecommendInterstingModel *model, UIImageView *bgImageView,NSArray*dataArr) {
               //自定义视图
        CSHomeRecommendInterestingBannerCell *cell = (CSHomeRecommendInterestingBannerCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CSHomeRecommendInterestingBannerCell class]) forIndexPath:indexPath];
        cell.delegate = self;
        cell.model = model;
        return cell;
    })
    
    .wFrameSet(CGRectMake(0, 52*heightScale, ScreenW, 177*heightScale))
    .wDataSet(self.dataArray)
    .wEventClickSet(^(id anyID, NSInteger index) {
        CSNewHomeRecommendInterstingModel *model = self.dataArray[index];
        CSTutorDetailViewController *vc = [CSTutorDetailViewController new];
        vc.tutorId = model.subject_id;
        [[CSTotalTool getCurrentShowViewController].navigationController pushViewController:vc animated:YES ];

    })
    //关闭pageControl
    .wHideBannerControlSet(YES)
    //开启缩放
    .wScaleSet(NO)
    //自定义item的大小
    .wItemSizeSet(CGSizeMake(131*widthScale, 177*heightScale))
    //固定移动的距离
    .wContentOffsetXSet(0.5)
    //循环
    .wRepeatSet(NO)
    //中间cell层级最上面
    .wZindexSet(YES)
    //整体左右间距  设置为size.width的一半 让最后一个可以居中
    .wSectionInsetSet(UIEdgeInsetsMake(0,10, 0, 10))
    //间距
    .wLineSpacingSet(12*heightScale)
    //开启背景毛玻璃
    .wEffectSet(NO)
    //点击左右居中
    .wClickCenterSet(YES)
    //自动滚动
    .wAutoScrollSet(NO)
    ;
    self.bannerView = [[WMZBannerView alloc]initConfigureWithModel:self.param];
    [self.contentView addSubview:self.bannerView];
}

- (void)deleteCellWith:(CSNewHomeRecommendInterstingModel *)model{
    [self.bannerView removeFromSuperview];
    NSMutableArray *changeArray = [NSMutableArray array];
    for (CSNewHomeRecommendInterstingModel *noeModel in self.dataArray) {
        if (![model.subject_id isEqual:noeModel.subject_id]) {
            [changeArray addObject:noeModel];
        }
    }
    [self.dataArray removeAllObjects];
    self.dataArray = changeArray;
    [self makeBanner];
}

@end
