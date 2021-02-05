//
//  CSNewHomeLiveViewTopCell.m
//  ColorStar
//
//  Created by apple on 2020/11/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewHomeLiveViewTopCell.h"
#import "WMZBannerView.h"
#import "CSNewHomeLiveViewTopBannerCell.h"
#import "CSNewHomeLiveTagsView.h"
#import "CSNewHomeRecommendModel.h"
@interface CSNewHomeLiveViewTopCell()
@property (nonatomic, strong) CSNewHomeLiveTagsView *tagsView;//tagsView
@property (nonatomic, strong)UIView  *mainView;
@property (nonatomic, strong)WMZBannerParam *param;
@property (nonatomic, strong)WMZBannerView *bannerView;
@end
@implementation CSNewHomeLiveViewTopCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
//        self.tagsArray = [NSMutableArray array];
//        self.bannerArray = [NSMutableArray array];
        [self makeUI];
        [self makeBnner];
    }
    return self;
}


- (void)makeUI{
     self.mainView= [[UIView alloc] init];
    
    [self.contentView addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(self.contentView);
        //make.height.mas_offset(@(200));
    }];
    self.tagsView = [[CSNewHomeLiveTagsView alloc] init];
    CS_Weakify(self, weakSelf);
    weakSelf.tagsView.clickBlock = ^(CSNewHomeLiveTagModel * _Nonnull model) {
        if (weakSelf.clickBlock) {
            weakSelf.clickBlock(model);
        }
    };
    [self.mainView addSubview:self.tagsView];
    [self.tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.mainView);
        make.bottom.mas_equalTo(self.mainView.mas_bottom).offset(-20*heightScale);
        make.top.mas_equalTo(196*heightScale);
        make.height.mas_offset(@(30*heightScale));
    }];
    
    
}

- (void)makeBnner{
    self.param=
    BannerParam()
    //自定义视图必传
    .wMyCellClassNameSet(@"CSNewHomeLiveViewTopBannerCell")
    .wMyCellSet(^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collectionView, CSNewHomeLiveBannerModel *model, UIImageView *bgImageView,NSArray*dataArr) {
        //自定义视图
        CSNewHomeLiveViewTopBannerCell *cell = (CSNewHomeLiveViewTopBannerCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CSNewHomeLiveViewTopBannerCell class]) forIndexPath:indexPath];
        cell.liveModel = model;
        // cell.leftText.text = model[@"name"];
        //[cell.icon sd_setImageWithURL:[NSURL URLWithString:model.live_image] placeholderImage:nil];
        return cell;
    })
    .wEventClickSet(^(id anyID, NSInteger index) {
        CSNewHomeLiveBannerModel *model = self.bannerArray[index];
        [[CSWebManager sharedManager] enterWebVCWithURL:model.url title:model.live_title withSupVC:[CSTotalTool getCurrentShowViewController]];

    })
    .wFrameSet(CGRectMake(0, 0, ScreenW, 157*heightScale))
    .wDataSet(self.bannerArray)
    //关闭pageControl
    .wHideBannerControlSet(NO)
    //开启缩放
    .wScaleSet(NO)
    //分页按钮的选中的颜色
    .wBannerControlSelectColorSet([UIColor colorWithHexString:@"#FFC549"])
    //分页按钮的未选中的颜色
    .wBannerControlColorSet([UIColor whiteColor])
//    //分页按钮的未选中的图片
    .wBannerControlImageSet(@"CSNewHomeLiveViewTopBannePageUnSelect")
    //分页按钮的选中的图片
    .wBannerControlSelectImageSet(@"CSNewHomeLiveViewTopBannePageSelect")
    //分页按钮的未选中图片的size
    .wBannerControlImageSizeSet(CGSizeMake(6, 6))
    //分页按钮选中的图片的size
    .wBannerControlSelectImageSizeSet(CGSizeMake(15, 6))
    
//    //分页按钮的圆角
    .wBannerControlImageRadiusSet(3)
    //自定义圆点间距
    .wBannerControlSelectMarginSet(4)
    .wCustomControlSet(^(UIControl *pageControl) {
        CGRect rect = pageControl.frame;
        rect.origin.y =  167*heightScale;
        pageControl.frame = rect;
    })
    //自定义item的大小
    .wItemSizeSet(CGSizeMake(ScreenW-29*widthScale*2, 157*heightScale))
    //固定移动的距离
    .wContentOffsetXSet(0.5)
    //循环
    .wRepeatSet(YES)
    //中间cell层级最上面
    .wZindexSet(YES)
    //整体左右间距  设置为size.width的一半 让最后一个可以居中
    .wSectionInsetSet(UIEdgeInsetsMake(0,17*widthScale, 0, 17*widthScale))
    //间距
    .wLineSpacingSet(12*widthScale)
    //开启背景毛玻璃
    .wEffectSet(NO)
    .wClickCenterSet(YES)
    //自动滚动
    .wAutoScrollSet(YES)
    ;
    self.bannerView = [[WMZBannerView alloc]initConfigureWithModel:self.param];
    self.bannerView.userInteractionEnabled= YES;
    [self.mainView addSubview:self.bannerView];
}

- (void)setBannerArray:(NSMutableArray *)bannerArray
{
    _bannerArray = bannerArray;
    self.param.wDataSet(bannerArray);
    [self.bannerView updateUI];
    
}

- (void)setTagsArray:(NSMutableArray *)tagsArray{
    _tagsArray = tagsArray;
    self.tagsView.array = tagsArray;
}

//-(UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes {
//    [self setNeedsLayout];
//
//    [self layoutIfNeeded];
//
//    CGSize size = [self.contentView systemLayoutSizeFittingSize: layoutAttributes.size];
//
//    CGRect cellFrame = layoutAttributes.frame;
//
//    cellFrame.size.height= size.height;
//
//    layoutAttributes.frame= cellFrame;
//
//    return layoutAttributes;
//
//}
@end
