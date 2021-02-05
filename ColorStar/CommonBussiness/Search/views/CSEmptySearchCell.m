//
//  CSEmptySearchCell.m
//  ColorStar
//
//  Created by gavin on 2020/8/14.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSEmptySearchCell.h"
#import <Masonry.h>
#import "UIColor+CS.h"
#import "UIView+CS.h"

@interface CSEmptySearchCell ()

@property (nonatomic, strong)UIImageView   * emptyImageView;

@property (nonatomic, strong)UILabel       * emptyTitleLabel;

@property (nonatomic, strong)UILabel       * emptySubTitleLabel;

@property (nonatomic, strong)UIButton      * reSearchBtn;


@end

@implementation CSEmptySearchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = LoadColor(@"#181F30");
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self.contentView addSubview:self.emptyImageView];
    [self.contentView addSubview:self.emptyTitleLabel];
    [self.contentView addSubview:self.emptySubTitleLabel];
//    [self.contentView addSubview:self.reSearchBtn];
    
    
}

- (void)layoutSubviews{
    
    CGFloat topMargin = 70.0*(self.contentView.height/657.0);
    CGFloat wh = 230*(self.contentView.width/375.0);
    CGFloat bottomMargin = 120.0*(self.contentView.height/657.0);
    
    [self.emptyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(topMargin);
        make.size.mas_equalTo(CGSizeMake(wh, wh));
    }];
    
    [self.emptyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.emptyImageView);
        make.top.mas_equalTo(self.emptyImageView.mas_bottom).offset(20);
    }];
    
    [self.emptySubTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.emptyTitleLabel);
        make.top.mas_equalTo(self.emptyTitleLabel.mas_bottom).offset(15);
    }];
    
//    [self.reSearchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(self.emptyImageView);
//        make.height.mas_equalTo(40);
//        make.top.mas_equalTo(self.emptySubTitleLabel.mas_bottom).offset(100);
//    }];
}


- (void)reSearchClick{
    
    if (self.reSearchBlock) {
        self.reSearchBlock();
    }
}

#pragma mark - Properties Method

- (UIImageView*)emptyImageView{
    if (!_emptyImageView) {
        _emptyImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _emptyImageView.image = [UIImage imageNamed:@"cs_empty_search"];
    }
    return _emptyImageView;
}

- (UILabel*)emptyTitleLabel{
    if (!_emptyTitleLabel) {
        _emptyTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _emptyTitleLabel.textColor = [UIColor whiteColor];
        _emptyTitleLabel.font = [UIFont systemFontOfSize:16.0f];
        _emptyTitleLabel.text = csnation(@"没找到哟~");
    }
    return _emptyTitleLabel;
}

- (UILabel*)emptySubTitleLabel{
    if (!_emptySubTitleLabel) {
        _emptySubTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _emptySubTitleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.38];
        _emptySubTitleLabel.font = [UIFont systemFontOfSize:14.0];
        _emptySubTitleLabel.text = csnation(@"没有搜索到相关内容");
    }
    return _emptySubTitleLabel;
}

- (UIButton*)reSearchBtn{
    if (!_reSearchBtn) {
        _reSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reSearchBtn setTitle:csnation(@"重新搜索") forState:UIControlStateNormal];
        [_reSearchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _reSearchBtn.layer.masksToBounds = YES;
        _reSearchBtn.layer.cornerRadius = 20;
        _reSearchBtn.backgroundColor = [UIColor colorWithHexString:@"#F8FBFE" alpha:0.12];
        [_reSearchBtn addTarget:self action:@selector(reSearchClick) forControlEvents:UIControlEventTouchDown];
    }
    return _reSearchBtn;
}

@end
