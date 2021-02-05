//
//  CSNewPunchView.m
//  ColorStar
//
//  Created by apple on 2021/1/12.
//  Copyright © 2021 gavin. All rights reserved.
//

#import "CSNewPunchView.h"

@implementation CSNewPunchView

- (void)cs_loadView{
    UIImageView  *bgImage = [[UIImageView alloc] init];
    bgImage.image = [UIImage imageNamed:@"puanchBg.png"];
    [self.contentView addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.contentView);
        make.height.mas_offset(320*heightScale);
        make.width.mas_offset(290*widthScale);
    }];
    
    UIButton  *surebutton = [[UIButton alloc] init];
    [surebutton setTitle:csnation(@"确认") forState:UIControlStateNormal];
    [surebutton setBackgroundImage:[UIImage imageNamed:@"punchSure.png"] forState:UIControlStateNormal];
    [surebutton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:surebutton];
    [surebutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(bgImage.mas_bottom).offset(-30);
        make.width.mas_offset(160);
        make.centerX.mas_equalTo(self.contentView);
        make.height.mas_offset(@(35));
    }];
    UILabel  *countLabel = [[UILabel alloc] init];
    countLabel.text = [NSString stringWithFormat:@"%@%ld%@",csnation(@"恭喜你获得"),self.count,csnation(@"金币")];
    countLabel.font = kFont(13);
    countLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    countLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:countLabel];
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(bgImage);
        make.bottom.mas_equalTo(surebutton.mas_top).offset(-25);
    }];
    
    UILabel  *titleLabel = [[UILabel alloc] init];
    titleLabel.text = csnation(@"签到成功");
    titleLabel.font = kFont(17);
    titleLabel.textColor = [UIColor colorWithHexString:@"#FF5619"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(bgImage);
        make.bottom.mas_equalTo(countLabel.mas_top).offset(-25);
    }];
}
- (void)show{
    [self getMaskConfig].maskColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    [super show];
}

- (void)cancelClick{
    [self cs_doDismiss];
}

@end
