//
//  CSHomeCycleCell.m
//  ColorStar
//
//  Created by gavin on 2020/8/4.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeCycleCell.h"
#import "SDCycleScrollView.h"
#import "UIView+CS.h"
#import <Masonry.h>

@interface CSHomeCycleCell ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong)UIView            * containerView;

@property (nonatomic, strong)SDCycleScrollView * cycleView;

@property (nonatomic, strong)NSArray  * banners;

@end

@implementation CSHomeCycleCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.cycleView];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(10);
        make.bottom.mas_equalTo(self.contentView).offset(-10);
        make.left.mas_equalTo(self.contentView).offset(14);
        make.right.mas_equalTo(self.contentView).offset(-14);
    }];
    
}

- (void)loadMockData{
    
    
    
    
}

- (void)configModels:(NSArray*)models{
    self.banners = models;
    NSMutableArray * images = [NSMutableArray arrayWithCapacity:0];
    for (CSHomeCycleModel * model in self.banners) {
        [images addObject:model.pic];
    }
    self.cycleView.imageURLStringsGroup = images;
}


#pragma mark - SDCycleScrollViewDelegate Method

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    if (index < self.banners.count) {
        CSHomeCycleModel * model = self.banners[index];
        if (self.cycleClick) {
            self.cycleClick(model);
        }
        
    }
    
}

#pragma mark - Properties Method

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.cornerRadius = 8;
    }
    return _containerView;
}

- (SDCycleScrollView*)cycleView{
    if (!_cycleView) {
        _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.width - 28, (self.width - 28)*(160.0/347.0)) delegate:self placeholderImage:[UIImage imageNamed:@"cs_home_banner"]];
    }
    return _cycleView;
}

@end
