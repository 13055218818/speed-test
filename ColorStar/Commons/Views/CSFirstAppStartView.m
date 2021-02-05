//
//  CSFirstAppStartView.m
//  ColorStar
//
//  Created by apple on 2020/12/26.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSFirstAppStartView.h"

@implementation CSFirstAppStartView


- (void)cs_loadView{

    UILabel  *labe = [[UILabel alloc] init];
    labe.font = kFont(17);
    labe.backgroundColor = [UIColor whiteColor];
    labe.numberOfLines = 0;
    labe.text = @"欢迎使用colorWorld！colorWorld是由彩色星空科技有限公司研发和运营的娱乐在线平台，我们通过《隐私政策》和《用户协议》帮助您了解我们收集、使用、存储和共享个人信息，以及您所享有的相关权利。详细的信息您可以通过阅读《隐私政策》和《用户协议》来了解。请点击“确认”";
    [self.contentView addSubview:labe];
    [labe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
    }];

    UIView  *buttonView = [[UIView alloc] init];
    buttonView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:buttonView];
    [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(labe.mas_bottom);
        make.left.right.mas_equalTo(labe);
        make.height.mas_offset(@(50));
    }];
    
    UIButton  *leftButton = [[UIButton alloc] init];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton setTitle:csnation(@"确定") forState:UIControlStateNormal];
    [buttonView addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(buttonView);
        make.width.mas_offset(@((ScreenW-30)/2));
    }];
    
    UIButton  *rightButton = [[UIButton alloc] init];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton setTitle:csnation(@"取消") forState:UIControlStateNormal];
    [buttonView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(buttonView);
        make.width.mas_offset(@((ScreenW-30)/2));
    }];
    
    UILabel  *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.font = kFont(23);
    titleLabel.text = @"用户隐私政策及权限说明";
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(labe);
        make.bottom.mas_equalTo(labe.mas_top);
        make.height.mas_offset(50);
    }];
    

}

- (void)show{
    [self getMaskConfig].maskColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    [self getMaskConfig].superView = [CSTotalTool getCurrentShowViewController].view;
    [super show];
}

- (void)cancelClick{
    [self cs_doDismiss];
}


@end
