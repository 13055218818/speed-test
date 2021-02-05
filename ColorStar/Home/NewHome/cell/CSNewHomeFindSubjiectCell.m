//
//  CSNewHomeFindSubjiectCell.m
//  ColorStar
//
//  Created by apple on 2020/11/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewHomeFindSubjiectCell.h"
#import "WMZBannerView.h"
#import "CSNewHomeFindSubjiectBannerCell.h"
#import "AppDelegate.h"
@interface CSNewHomeFindSubjiectCell()
@property (nonatomic, strong)NSMutableArray     *dataArray;
@property (nonatomic, strong)WMZBannerParam     *param;
@property (nonatomic, strong)WMZBannerView      *bannerView;
@end
@implementation CSNewHomeFindSubjiectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withArray:(NSMutableArray *)array
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
    UILabel  *lefTitleLabel = [[UILabel alloc] init];
    lefTitleLabel.text = NSLocalizedString(@"专题",nil);
    lefTitleLabel.font = kFont(16);
    lefTitleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    lefTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:lefTitleLabel];
    [lefTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(12* widthScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(13*heightScale);
    }];
    
    UIButton  *rightButton = [[UIButton alloc] init];
    [rightButton setImage:[UIImage imageNamed:@"CSHomeRecommendEveryDayRight"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(@(20));
        make.height.mas_offset(@(20));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-12);
        make.centerY.mas_equalTo(lefTitleLabel.mas_centerY);
    }];
    [self makeBanner];
   
    
}

- (void)makeBanner{
    CGFloat  viewWidth = (ScreenW-48*widthScale)/3;
    self.param =
    BannerParam()
    //自定义视图必传
    .wMyCellClassNameSet(@"CSNewHomeFindSubjiectBannerCell")
    .wMyCellSet(^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collectionView, CSNewHomeRecommendModel *model, UIImageView *bgImageView,NSArray*dataArr) {
               //自定义视图
        CSNewHomeFindSubjiectBannerCell *cell = (CSNewHomeFindSubjiectBannerCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CSNewHomeFindSubjiectBannerCell class]) forIndexPath:indexPath];
//        cell.delegate = self;
        cell.model = model;
        return cell;
    })
    
    .wFrameSet(CGRectMake(0, 43*heightScale, ScreenW, 132*heightScale))
    .wDataSet(self.dataArray)
    .wEventClickSet(^(id anyID, NSInteger index) {
        CSNewHomeRecommendModel *model = self.dataArray[index];
        CSTutorDetailViewController *vc = [CSTutorDetailViewController new];
        vc.tutorId = model.specialId;
        [[CSTotalTool getCurrentShowViewController].navigationController pushViewController:vc animated:YES ];

    })
    //关闭pageControl
    .wHideBannerControlSet(YES)
    //开启缩放
    .wScaleSet(NO)
    //自定义item的大小
    .wItemSizeSet(CGSizeMake(viewWidth, 132*heightScale))
    //固定移动的距离
    .wContentOffsetXSet(0.5)
    //循环
    .wRepeatSet(NO)
    //中间cell层级最上面
    .wZindexSet(YES)
    //整体左右间距  设置为size.width的一半 让最后一个可以居中
    .wSectionInsetSet(UIEdgeInsetsMake(0,12*widthScale, 0, 12*widthScale))
    //间距
    .wLineSpacingSet(12*widthScale)
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

-(void)rightButtonClick:(UIButton  *)btn{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIViewController *controller = app.window.rootViewController;
    CSBaseTabBarController *rvc = (CSBaseTabBarController *)controller;

    [rvc setSelectedIndex:1];

    [[CSTotalTool getCurrentShowViewController].navigationController popToRootViewControllerAnimated:YES];
}

@end
