//
//  CSNewShopAddressListCell.m
//  ColorStar
//
//  Created by apple on 2020/11/20.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewShopAddressListCell.h"
@interface CSNewShopAddressListCell()
@property (nonatomic, strong)UIView    *bgView;
@property (nonatomic, strong)UILabel    *firstLabel;
@property (nonatomic, strong)UILabel    *nameTagLabel;
@property (nonatomic, strong)UILabel    *nameLabel;
@property (nonatomic, strong)UILabel    *phoneLabel;
@property (nonatomic, strong)UILabel    *addressLabel;
@property (nonatomic, strong)UIButton   *editButton;
@property (nonatomic, strong)CSNewShopAddressModel  *currentModel;
@end
@implementation CSNewShopAddressListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
        self.currentModel = [[CSNewShopAddressModel alloc] init];
        [self makeUI];
    }
    return self;;
}

- (void)makeUI{
    self.bgView = [[UIView alloc] init];
    ViewRadius(self.bgView, 3);
    self.bgView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.06];
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15*widthScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15*widthScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10*heightScale);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
    self.firstLabel = [[UILabel alloc] init];
    self.firstLabel.hidden = YES;
    self.firstLabel.backgroundColor = [UIColor colorWithHexString:@"#FA372F"];
    self.firstLabel.text = NSLocalizedString(@"默认",nil);
    self.firstLabel.font = kFont(9);
    self.firstLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.firstLabel.textAlignment = NSTextAlignmentCenter;
    ViewRadius(self.firstLabel, 3);
    [self.contentView addSubview:self.firstLabel];
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(15*widthScale);
        make.top.mas_equalTo(self.bgView.mas_top).offset(15*heightScale);
        make.height.mas_offset(@(15*heightScale));
        make.width.mas_offset(@(32*widthScale));
    }];
    
    self.nameTagLabel = [[UILabel alloc] init];
    self.nameTagLabel.backgroundColor = [UIColor colorWithHexString:@"#5D86FF"];
//    self.nameTagLabel.text = NSLocalizedString(@"半",nil);
    self.nameTagLabel.font = kFont(9);
    self.nameTagLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.nameTagLabel.textAlignment = NSTextAlignmentCenter;
    ViewRadius(self.nameTagLabel, 3);
    [self.contentView addSubview:self.nameTagLabel];
    [self.nameTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.firstLabel.mas_right).offset(7*widthScale);
        make.centerY.mas_equalTo(self.firstLabel.mas_centerY);
        make.height.mas_offset(@(15*heightScale));
        make.width.mas_offset(@(32*widthScale));
    }];
    
    self.nameLabel = [[UILabel alloc] init];
//    self.nameLabel.text = NSLocalizedString(@"b半夏",nil);
    self.nameLabel.font = kFont(12);
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#C8AE99"];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameTagLabel.mas_right).offset(15*widthScale);
        make.centerY.mas_equalTo(self.firstLabel.mas_centerY);
    }];
    
    self.phoneLabel = [[UILabel alloc] init];
//    self.phoneLabel.text = NSLocalizedString(@"12345656789098",nil);
    self.phoneLabel.font = kFont(12);
    self.phoneLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.phoneLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.phoneLabel];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(15*widthScale);
        make.centerY.mas_equalTo(self.firstLabel.mas_centerY);
    }];
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.numberOfLines = 0;
//    self.addressLabel.text = NSLocalizedString(@"广东省深圳市福田区京基滨河大厦A座1003室广东省深圳市福田区京基滨河大厦A座1003室广东省深圳市福田区京基滨河大厦A座1003室广东省深圳市福田区京基滨河大厦A座1003室广东省深圳市福田区京基滨河大厦A座1003室",nil);
    self.addressLabel.font = kFont(12);
    self.addressLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.addressLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(15*widthScale);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-30*widthScale);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(16*widthScale);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-15*heightScale);
    }];
    
    self.editButton = [[UIButton alloc] init];
    [self.editButton addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.editButton setImage:[UIImage imageNamed:@"CSNewShopAddressListCellEdit.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.editButton];
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView);
        make.centerY.mas_equalTo(self.bgView);
        make.width.mas_offset(@(30));
        make.height.mas_offset(@(24));
    }];
}

- (void)setModel:(CSNewShopAddressModel *)model
{
    _model = model;
    self.currentModel = model;
    if ([model.is_default isEqualToString:@"1"]) {
        self.firstLabel.hidden = NO;
        [self.nameTagLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.firstLabel.mas_right).offset(7*widthScale);
            make.centerY.mas_equalTo(self.firstLabel.mas_centerY);
            make.height.mas_offset(@(15*heightScale));
            make.width.mas_offset(@(32*widthScale));
        }];
    }else{
        self.firstLabel.hidden = YES;
        [self.nameTagLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(15*widthScale);
            make.centerY.mas_equalTo(self.firstLabel.mas_centerY);
            make.height.mas_offset(@(15*heightScale));
            make.width.mas_offset(@(32*widthScale));
        }];
    }
    
    self.nameTagLabel.text = [model.real_name substringToIndex:1];
    self.nameLabel.text = model.real_name;
    self.phoneLabel.text = model.phone;
    self.addressLabel.text =[NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.district,model.detail];
}

- (void)editClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(CSNewShopAddressListCellEditButton:)]) {
        [self.delegate CSNewShopAddressListCellEditButton:self.currentModel];
    }
}
@end
