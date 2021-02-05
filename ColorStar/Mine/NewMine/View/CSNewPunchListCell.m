//
//  CSNewPunchListCell.m
//  ColorStar
//
//  Created by apple on 2021/1/14.
//  Copyright © 2021 gavin. All rights reserved.
//

#import "CSNewPunchListCell.h"
@interface CSNewPunchListCell()
@property(nonatomic, strong)UIImageView         *headImage;
@property(nonatomic, strong)UILabel             *nameLabel;
@property(nonatomic, strong)UILabel             *detailLabel;
@property(nonatomic, strong)UILabel             *timeLabel;

@end

@implementation CSNewPunchListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
        self.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    }
    return self;
}

- (void)makeUI{
    self.headImage = [[UIImageView alloc] init];
    ViewRadius(self.headImage, 20);
    self.headImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.headImage];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.height.mas_offset(@(40));
    }];
    
    self.nameLabel = [[UILabel alloc] init];
//    self.nameLabel.text = @"111";
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImage.mas_right).offset(10);
        make.top.mas_equalTo(self.headImage.mas_top);
    }];
    self.detailLabel = [[UILabel alloc] init];
//    self.detailLabel.text = @"111";
    self.detailLabel.textColor = [UIColor whiteColor];
    self.detailLabel.textAlignment = NSTextAlignmentLeft;
    self.detailLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImage.mas_right).offset(10);
        make.bottom.mas_equalTo(self.headImage.mas_bottom);
    }];
    
    self.timeLabel = [[UILabel alloc] init];
//    self.timeLabel.text = @"111";
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.nameLabel.mas_centerY);
    }];
    
}

-(void)setModel:(CSNewPunchListModel *)model
{
    _model = model;
    self.nameLabel.text = model.nickname;
    self.detailLabel.text =[NSString stringWithFormat:@"%@ %@ %@,%@ %@ %@",csnation(@"累计"),model.days,csnation(@"天"),csnation(@"获得"),model.number,csnation(@"金币")];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[CSAPPConfigManager sharedConfig].baseURL,model.avatar]] placeholderImage:[UIImage imageNamed:@"CSNewMyDefultImage.png"]];
    self.timeLabel.text = [self timeWithTimeIntervalString:model.add_time];
}

- (void)setSharmodel:(CSNewShareListModel *)sharmodel
{
    _sharmodel = sharmodel;
    self.nameLabel.text = sharmodel.nickname;
    self.detailLabel.text = sharmodel.account;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:sharmodel.avatar] placeholderImage:[UIImage imageNamed:@"CSNewMyDefultImage.png"]];
    self.timeLabel.text = [self timeWithTimeIntervalString:sharmodel.add_time];
}

- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSTimeInterval time=[timeString doubleValue];//如果是美国则因为时差问题要加8小时 == 28800 sec，这里不需要加
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
//    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString*currentDateStr = [dateFormatter stringFromDate:detaildate];
    
    return currentDateStr;
}
@end
