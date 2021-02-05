//
//  CSHomePressCell.m
//  ColorStar
//
//  Created by gavin on 2020/8/4.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomePressCell.h"
#import "SDCycleScrollView.h"
#import "UIColor+CS.h"
#import <Masonry.h>

@interface CSHomePressCell ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong)UIView    * containerView;

@property (nonatomic, strong)UILabel   * titleLabel;

@property (nonatomic, strong)UIView    * separtLine;

@property (nonatomic, strong)SDCycleScrollView  * cycleView;

@property (nonatomic, strong)NSArray   * presses;

@end

@implementation CSHomePressCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.separtLine];
    [self.containerView addSubview:self.cycleView];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerView).offset(15);
        make.centerY.mas_equalTo(self.containerView);
    }];
    
    [self.separtLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(8);
        make.top.bottom.mas_equalTo(self.titleLabel);
        make.width.mas_equalTo(1);
    }];
    
    [self.cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.separtLine).offset(10);
        make.right.mas_equalTo(self.containerView).offset(-10);
        make.centerY.mas_equalTo(self.separtLine);
        make.height.mas_equalTo(25);
    }];
    
    
}

- (void)loadMockData{
    
}

- (void)configPresses:(NSArray*)presses{
    
    self.presses = presses;
    NSMutableArray * titles = [NSMutableArray arrayWithCapacity:0];
    for (CSHomePressModel * model in self.presses) {
        [titles addObject:model.title];
    }
    
    self.cycleView.titlesGroup = titles;
    
}

#pragma mark - SDCycleScrollViewDelegate Method
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    if (index < self.presses.count) {
        if (self.pressClick) {
            self.pressClick(self.presses[index]);
        }
    }
    
}
#pragma mark Properties Method

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _containerView;
}

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#BB86FC"];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        _titleLabel.text = NSLocalizedString(@"新闻简报", nil);
    }
    return _titleLabel;
}

- (UIView*)separtLine{
    if (!_separtLine) {
        _separtLine = [[UIView alloc]initWithFrame:CGRectZero];
        _separtLine.backgroundColor = [UIColor colorWithHexString:@"#BB86FC"];
    }
    return _separtLine;
}

- (SDCycleScrollView*)cycleView{
    if (!_cycleView) {
        _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        _cycleView.scrollDirection = UICollectionViewScrollDirectionVertical;
        _cycleView.onlyDisplayText = YES;
        _cycleView.titleLabelTextFont = [UIFont systemFontOfSize:12.0];
        _cycleView.titleLabelTextColor = [UIColor whiteColor];
    }
    return _cycleView;
}

@end
