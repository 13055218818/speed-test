



//
//  MyCell.m
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "CSHomeRecommendEveryDayBannerCell.h"

@implementation CSHomeRecommendEveryDayBannerCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.icon = [UIImageView new];
        self.icon.clipsToBounds = YES;
        self.icon.contentMode = UIViewContentModeScaleAspectFill;
        self.icon.layer.masksToBounds = YES;
        [self.contentView addSubview:self.icon];
        self.icon.frame = self.contentView.bounds;
        self.rightStatu = [UIImageView new];
        //self.rightStatu.image = [UIImage imageNamed:@"CSHomeRecommendEveryDayRightStatu.png"];
        [self.icon addSubview:self.rightStatu];
        
        self.rightStatu.frame = CGRectMake(self.contentView.frame.size.width-45*widthScale, 120*heightScale, 37, 17);
        
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = kFont(14);
        self.titleLabel.textColor = [UIColor colorWithHexString:@"#202020"];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(20);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
            make.top.mas_equalTo(self.contentView.mas_top).offset(12);
        }];
        self.detailLabel = [[UILabel alloc] init];
        self.detailLabel.font = kFont(10);
        self.detailLabel.textColor = [UIColor colorWithHexString:@"#202020"];
        self.detailLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.detailLabel];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(20);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(2);
            
        }];
    }
    return self;
}
@end
