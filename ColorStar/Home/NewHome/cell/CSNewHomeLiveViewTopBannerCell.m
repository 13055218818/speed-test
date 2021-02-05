//
//  CSNewHomeLiveViewTopBannerCell.m
//  ColorStar
//
//  Created by apple on 2020/11/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewHomeLiveViewTopBannerCell.h"

@implementation CSNewHomeLiveViewTopBannerCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        ViewRadius(self.contentView, 5);
        ViewRadius(self.icon, 5);
        self.icon = [UIImageView new];
        self.icon.clipsToBounds = YES;
        self.icon.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.icon];
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(self.contentView);
        }];
        
    }
    return self;
}

-(void)setModel:(CSNewShopBannerModel *)model{
    _model = model;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"cs_home_course.png"]];
}

- (void)setLiveModel:(CSNewHomeLiveBannerModel *)liveModel
{
    _liveModel = liveModel;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:liveModel.live_image] placeholderImage:[UIImage imageNamed:@"cs_home_course.png"]];
}
@end
