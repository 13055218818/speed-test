//
//  CSHomeRecommendTopBannerCell.m
//  ColorStar
//
//  Created by apple on 2020/11/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeRecommendTopBannerCell.h"
#import "SDCycleScrollView.h"
#import "CSNewHomeRecommendModel.h"

@interface CSHomeRecommendTopBannerCell() <SDCycleScrollViewDelegate>
@property (nonatomic, strong)SDCycleScrollView      *cycleView;
@end
@implementation CSHomeRecommendTopBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
        [self makeUI];
    }
    return self;
}

- (void)makeUI{
    self.cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, 172*heightScale) delegate:self placeholderImage:[UIImage imageNamed:@"cs_home_course.png"]];
    self.cycleView.showPageControl = NO;
    [self.contentView addSubview:self.cycleView];

}

- (void)setBannerArry:(NSMutableArray *)bannerArry
{
    _bannerArry = bannerArry;
    NSMutableArray *groupArray = [NSMutableArray new];
    for (CSNewHomeRecommendBannerModel *model in bannerArry) {
        [groupArray addObject:model.pic];
    }
    self.cycleView.imageURLStringsGroup = groupArray;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    CSNewHomeRecommendBannerModel *model = self.bannerArry[index];
    [[CSWebManager sharedManager] enterWebVCWithURL:model.url title:model.title withSupVC:[CSTotalTool getCurrentShowViewController]];
}
@end
