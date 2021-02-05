//
//  CSNewHomeFindHotBannerCell.m
//  ColorStar
//
//  Created by apple on 2020/11/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewHomeFindHotBannerCell.h"

@implementation CSNewHomeFindHotBannerCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.contentView.backgroundColor = [UIColor whiteColor];
        ViewRadius(self, 6);
        [self makeUI];
    }
    return self;
}

- (void)makeUI{
    self.bgImage = [[UIImageView alloc] init];
    self.bgImage.clipsToBounds = YES;
    self.bgImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.bgImage];
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.contentView);
    }];
    
    self.TextLabel = [[UILabel alloc] init];
    
    self.TextLabel.font = kFont(14);
    self.TextLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.TextLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.TextLabel];
    
    [self.TextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
}

- (void)setModel:(CSNewHomeFindHotModel *)model
{
    _model = model;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"CSNewListBgDefaault.png"]];
    self.TextLabel.text = [NSString stringWithFormat:@"#%@",model.name];
}



@end
