//
//  CSHomeRecommendEveryDayCell.m
//  ColorStar
//
//  Created by apple on 2020/11/10.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeRecommendEveryDayCell.h"
#import "WMZBannerView.h"
#import "CSHomeRecommendEveryDayBannerCell.h"
#import "CSNewHomeRecommendModel.h"
#import "AppDelegate.h"
#import "CSBaseTabBarController.h"
@interface CSHomeRecommendEveryDayCell()
@property(nonatomic, strong)NSMutableArray   *dataArray;
@property(nonatomic, strong)UIView           *mainView;
@property(nonatomic, strong)WMZBannerView *bannerView;
@end

@implementation CSHomeRecommendEveryDayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier with:(NSMutableArray *)array;
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
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
        make.left.mas_equalTo(self.contentView.mas_left).offset(12);
        make.top.mas_equalTo(self.contentView.mas_top).offset(18*heightScale);
        make.width.mas_offset(@(4*widthScale));
        make.height.mas_offset(@(15*heightScale));
    }];
    
    UILabel  *lefTitleLabel = [[UILabel alloc] init];
    lefTitleLabel.text = NSLocalizedString(@"每日精选",nil);
    lefTitleLabel.font = kFont(16);
    lefTitleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    lefTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:lefTitleLabel];
    [lefTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftImage.mas_right).offset(6);
        make.centerY.mas_equalTo(leftImage.mas_centerY);
    }];
    
    UIButton  *rightButton = [[UIButton alloc] init];
    [rightButton setImage:[UIImage imageNamed:@"CSHomeRecommendEveryDayRight"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonMoreClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(@(20));
        make.height.mas_offset(@(20));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-12);
        make.centerY.mas_equalTo(leftImage.mas_centerY);
    }];
    [self makeBanner];
}

- (void)makeBanner{
    WMZBannerParam *param =
    BannerParam()
    //自定义视图必传
    .wMyCellClassNameSet(@"CSHomeRecommendEveryDayBannerCell")
    .wMyCellSet(^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collectionView, CSNewHomeRecommendDayModel* model, UIImageView *bgImageView,NSArray*dataArr) {
               //自定义视图
        CSHomeRecommendEveryDayBannerCell *cell = (CSHomeRecommendEveryDayBannerCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CSHomeRecommendEveryDayBannerCell class]) forIndexPath:indexPath];
       // cell.leftText.text = model[@"name"];
        cell.detailLabel.text = model.detail;
        cell.titleLabel.text = model.title;
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
        return cell;
    })
    .wFrameSet(CGRectMake(0, 52*heightScale, ScreenW, 144*heightScale))
    .wDataSet(self.dataArray)
    .wEventClickSet(^(id anyID, NSInteger index) {
            CSNewHomeRecommendDayModel *model = self.dataArray[index];
            CSTutorPlayViewController *vc = [CSTutorPlayViewController new];
            vc.videoId = model.dayId;
            [[CSTotalTool getCurrentShowViewController].navigationController pushViewController:vc animated:YES];


    })
    //关闭pageControl
    .wHideBannerControlSet(NO)
    //开启缩放
    .wScaleSet(NO)
    //自定义item的大小
    .wItemSizeSet(CGSizeMake(ScreenW-30*widthScale*2, 144*heightScale))
    //固定移动的距离
    .wContentOffsetXSet(0.5)
    //循环
    .wRepeatSet(YES)
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
    .wAutoScrollSet(YES)
    .wBannerControlSelectColorSet([UIColor colorWithHexString:@"#FFFFFF"])
    //分页按钮的未选中的颜色
    .wBannerControlColorSet([UIColor colorWithHexString:@"#E7E7E7"])
    .wCustomControlSet(^(UIControl *pageControl) {
        CGRect rect = pageControl.frame;
        rect.origin.y =  120*heightScale;
        rect.origin.x = 40*widthScale;
        rect.size.width =30*widthScale;
        pageControl.frame = rect;
    })
    ;
   self.bannerView = [[WMZBannerView alloc]initConfigureWithModel:param];
    [self.contentView addSubview:self.bannerView];
}

- (void)rightButtonMoreClick:(UIButton *)btn{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIViewController *controller = app.window.rootViewController;
    CSBaseTabBarController *rvc = (CSBaseTabBarController *)controller;

    [rvc setSelectedIndex:1];

    [[CSTotalTool getCurrentShowViewController].navigationController popToRootViewControllerAnimated:YES];

}

@end
