//
//  CSNewHomeFindHotCell.m
//  ColorStar
//
//  Created by apple on 2020/11/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewHomeFindHotCell.h"
#import "WMZBannerView.h"
#import "CSNewHomeFindHotBannerCell.h"
#import "CSNewHomeRecommendModel.h"
#import "AppDelegate.h"
#import "CSNewCourseModel.h"
#import "CSBaseNavigationController.h"
@interface CSNewHomeFindHotCell()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView      *mainScrollerView;
@property (nonatomic, strong)WMZBannerParam     *param;
@property (nonatomic, strong)WMZBannerView      *bannerView;
@property (nonatomic, strong)NSMutableArray     *dataArray;

@end
@implementation CSNewHomeFindHotCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withArray:(NSMutableArray *)array
{
    if (self = [super init]) {
        self.dataArray = [NSMutableArray array];
        self.dataArray = array;
        self.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
        [self makeUI];
    }
    return self;
}

- (void)makeUI{
    UILabel  *lefTitleLabel = [[UILabel alloc] init];
    lefTitleLabel.text = NSLocalizedString(@"热门专区",nil);
    lefTitleLabel.font = kFont(14);
    lefTitleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    lefTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:lefTitleLabel];
    [lefTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(12* widthScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(13*heightScale);
    }];
    
    UIButton  *rightButton = [[UIButton alloc] init];
    rightButton.hidden = YES;
    [rightButton setImage:[UIImage imageNamed:@"CSHomeRecommendEveryDayRight"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(attentionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(@(20));
        make.height.mas_offset(@(20));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-12);
        make.centerY.mas_equalTo(lefTitleLabel.mas_centerY);
    }];
    
    [self makeBanner];
    
    UILabel  *bottomitleLabel = [[UILabel alloc] init];
    bottomitleLabel.text = NSLocalizedString(@"大家都在学",nil);
    bottomitleLabel.font = kFont(14);
    bottomitleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    bottomitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:bottomitleLabel];
    [bottomitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(12* widthScale);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10*heightScale);
    }];
    
    UIView *bottomPointView = [[UIView alloc] init];
    bottomPointView.backgroundColor = [UIColor colorWithHexString:@"#D7B393"];
    [self.contentView addSubview:bottomPointView];
    [bottomPointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(@(6));
        make.left.mas_equalTo(bottomitleLabel.mas_right).offset(6);
        make.centerY.mas_equalTo(bottomitleLabel.mas_centerY);
    }];
    
}

- (void)makeBanner{
    self.param =
    BannerParam()
    //自定义视图必传
    .wMyCellClassNameSet(@"CSNewHomeFindHotBannerCell")
    .wMyCellSet(^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collectionView, CSNewHomeFindHotModel *model, UIImageView *bgImageView,NSArray*dataArr) {
               //自定义视图
        CSNewHomeFindHotBannerCell *cell = (CSNewHomeFindHotBannerCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CSNewHomeFindHotBannerCell class]) forIndexPath:indexPath];
        cell.model = self.dataArray[indexPath.row];

        return cell;
    })
    .wFrameSet(CGRectMake(0, 50*heightScale, ScreenW, 100*heightScale))
    .wDataSet(self.dataArray)
    .wEventClickSet(^(id anyID, NSInteger index) {
        CSNewHomeFindHotModel *model = self.dataArray[index];
        
        CSNewCourseCategoryModel *selectModel = [[CSNewCourseCategoryModel alloc] init];
        selectModel.isSelect = YES;
        selectModel.name = model.name;
        selectModel.categoryId = model.hot_id;
        [[NSUserDefaults standardUserDefaults] setValue:model.hot_id forKey:@"hotSelctId"];
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;

        UIViewController *controller = app.window.rootViewController;
        CSBaseTabBarController *rvc = (CSBaseTabBarController *)controller;

        [rvc setSelectedIndex:1];
      
        //[[CSTotalTool getCurrentShowViewController].navigationController popToRootViewControllerAnimated:YES];

    })
    //关闭pageControl
    .wHideBannerControlSet(YES)
    //开启缩放
    .wScaleSet(NO)
    //自定义item的大小
    .wItemSizeSet(CGSizeMake(100*widthScale, 100*heightScale))
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



@end
