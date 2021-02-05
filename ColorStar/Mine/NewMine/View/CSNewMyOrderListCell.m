//
//  CSNewMyOrderListCell.m
//  ColorStar
//
//  Created by apple on 2020/12/19.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewMyOrderListCell.h"
@interface CSNewMyOrderListCell()
@property (nonatomic, strong) UIView            *bgView;
@property (nonatomic, strong)UILabel            *topTitleLabel;
@property (nonatomic, strong)UIButton            *topStatusButton;
@property (nonatomic, strong)UIImageView        *goodImage;
@property (nonatomic, strong)UILabel            *goodTitleLabel;
@property (nonatomic, strong)UILabel            *goodSizeLabel;
@property (nonatomic, strong)UILabel            *goodPriceLabel;
@property (nonatomic, strong)UILabel            *numLabel;
@property (nonatomic, strong)UILabel            *returnLabel;
@property (nonatomic, strong)UILabel            *deleteLabel;
@property (nonatomic, strong)UILabel            *checkLabel;
@property (nonatomic, strong)NSString           *goodId;
@property (nonatomic, strong)CSNewMineOrderModel *currentModel;

@end
@implementation CSNewMyOrderListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
        self.currentModel = [[CSNewMineOrderModel alloc] init];
        [self makeUI];
    }
    return self;
}

- (void)makeUI{
    self.bgView= [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.06];
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15*widthScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15*widthScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(5*heightScale);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5*heightScale);
    }];
    
    self.topTitleLabel = [[UILabel alloc] init];
    //self.goodTitleLabel.text = self.orderModel.store_name;
    //self.goodTitleLabel.text = NSLocalizedString(@"韩版棒球帽潮鸭舌帽户外运动嘻哈帽时尚情侣遮阳帽街柠...",nil);
    self.topTitleLabel.font = kFont(15);
    self.topTitleLabel.numberOfLines = 1;
    self.topTitleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.topTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.bgView addSubview:self.topTitleLabel];
    [self.topTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(15*widthScale);
        make.height.mas_offset(@(50*heightScale));
    }];
    
    self.topStatusButton = [[UIButton alloc] init];
    self.topStatusButton.titleLabel.font = kFont(9);
    [self.bgView addSubview:self.topStatusButton];
    [self.topStatusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView.mas_right).offset(-15*widthScale);
        make.centerY.mas_equalTo(self.topTitleLabel.mas_centerY);
        make.width.mas_offset(@(60));
        make.height.mas_offset(@(15*heightScale));
    }];
    
    self.goodImage = [[UIImageView alloc] init];
    ViewRadius(self.goodImage, 5);
    self.goodImage.clipsToBounds = YES;
    self.goodImage.contentMode = UIViewContentModeScaleAspectFill;
    self.goodImage .image = [UIImage imageNamed:@"CSLoginAgreeUnSelect.png"];
//    [self.goodImage sd_setImageWithURL:[NSURL URLWithString:self.orderModel.image] placeholderImage:[UIImage imageNamed:@"CSNewHeadplaceholderImage.png"]];
    [self.bgView addSubview:self.goodImage ];
    [self.goodImage  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(15*widthScale);
        make.top.mas_equalTo(self.bgView.mas_top).offset(50*heightScale);
        make.width.height.mas_offset(@(80*heightScale));
    }];
    
    self.goodTitleLabel = [[UILabel alloc] init];
    //self.goodTitleLabel.text = self.orderModel.store_name;
    //self.goodTitleLabel.text = NSLocalizedString(@"韩版棒球帽潮鸭舌帽户外运动嘻哈帽时尚情侣遮阳帽街柠...",nil);
    self.goodTitleLabel.font = kFont(12);
    self.goodTitleLabel.numberOfLines = 2;
    self.goodTitleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.goodTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.bgView addSubview:self.goodTitleLabel];
    [self.goodTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodImage.mas_right).offset(15*widthScale);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-15*widthScale);
        make.top.mas_equalTo(self.goodImage.mas_top);
    }];
    
    self.goodSizeLabel = [[UILabel alloc] init];
    self.goodSizeLabel.hidden = YES;
    self.goodSizeLabel.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.06];
    self.goodSizeLabel.text = NSLocalizedString(@"黄色+均码",nil);
    self.goodSizeLabel.font = kFont(10);
    self.goodSizeLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.5];
    self.goodSizeLabel.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview:self.goodSizeLabel];
    [self.goodSizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodImage.mas_right).offset(15*widthScale);
        make.top.mas_equalTo(self.goodTitleLabel.mas_bottom).offset(11*heightScale);
        make.width.mas_offset(@(80*widthScale));
        make.height.mas_offset(@(18*heightScale));
    }];
    
    ViewRadius(self.goodSizeLabel, 9*heightScale);
    
    
    self.goodPriceLabel = [[UILabel alloc] init];
    //self.goodPriceLabel.text = self.orderModel.price;
    //self.goodPriceLabel.text = NSLocalizedString(@"￥198.80",nil);
    self.goodPriceLabel.font = kFont(18);
    self.goodPriceLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.goodPriceLabel.textAlignment = NSTextAlignmentLeft;
    [self.bgView addSubview:self.goodPriceLabel];
    [self.goodPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodImage.mas_right).offset(15*widthScale);
        make.bottom.mas_equalTo(self.goodImage.mas_bottom);
    }];
    
    self.numLabel = [[UILabel alloc] init];
    //self.goodPriceLabel.text = self.orderModel.price;
    //self.goodPriceLabel.text = NSLocalizedString(@"￥198.80",nil);
    self.numLabel.font = kFont(10);
    self.numLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.numLabel.textAlignment = NSTextAlignmentLeft;
    [self.bgView addSubview:self.numLabel];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodPriceLabel.mas_right).offset(5*widthScale);
        make.centerY.mas_equalTo(self.goodPriceLabel.mas_centerY);
    }];
    
    self.checkLabel = [[UILabel alloc] init];
    ViewBorder(self.checkLabel, [UIColor colorWithHexString:@"#FFFFFF" alpha:0.5], 1/[UIScreen mainScreen].scale);
    ViewRadius(self.checkLabel, 13*heightScale);
    self.checkLabel.font = kFont(10);
    self.checkLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.5];
    self.checkLabel.textAlignment = NSTextAlignmentCenter;
    NSString *checkString = NSLocalizedString(@"查看物流", nil);
    [self.checkLabel setTapActionWithBlock:^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:csnation(@"提示") message:csnation(@"售后问题请联系客服") preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:csnation(@"确定") style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [[CSTotalTool getCurrentShowViewController] presentViewController:alert animated:YES completion:nil];
    }];
    self.checkLabel.text =checkString;
    CGFloat  checkWidth = [[CSTotalTool sharedInstance] getButtonWidth:checkString WithFont:10 WithLefAndeRightMargin:10];
    [self.bgView addSubview:self.checkLabel];
    [self.checkLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(@(26*heightScale));
        make.width.mas_offset(@(checkWidth));
        make.top.mas_equalTo(self.goodPriceLabel.mas_bottom).offset(15*heightScale);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-15*heightScale);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-15*widthScale);
    }];
    
    
    self.deleteLabel = [[UILabel alloc] init];
    ViewBorder(self.deleteLabel, [UIColor colorWithHexString:@"#FFFFFF" alpha:0.5], 1/[UIScreen mainScreen].scale);
    ViewRadius(self.deleteLabel, 13*heightScale);
    self.deleteLabel.font = kFont(10);
    self.deleteLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.5];
    self.deleteLabel.textAlignment = NSTextAlignmentCenter;
    NSString *deleteString = NSLocalizedString(@"删除订单", nil);
    self.deleteLabel.text =deleteString;
    CS_Weakify(self, weakSelf);
    [self.deleteLabel setTapActionWithBlock:^{
        if (weakSelf.clickBlock) {
            weakSelf.clickBlock(weakSelf.currentModel);
        }
    }];
    CGFloat  deleteWidth = [[CSTotalTool sharedInstance] getButtonWidth:deleteString WithFont:10 WithLefAndeRightMargin:10];
    [self.bgView addSubview:self.deleteLabel];
    [self.deleteLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(@(26*heightScale));
        make.width.mas_offset(@(checkWidth));
        make.top.mas_equalTo(self.goodPriceLabel.mas_bottom).offset(15*heightScale);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-15*heightScale);
        make.right.mas_equalTo(self.checkLabel.mas_left).offset(-15*widthScale);
    }];
    
    self.returnLabel = [[UILabel alloc] init];
    ViewBorder(self.returnLabel, [UIColor colorWithHexString:@"#FFFFFF" alpha:0.5], 1/[UIScreen mainScreen].scale);
    ViewRadius(self.returnLabel, 13*heightScale);
    self.returnLabel.font = kFont(10);
    self.returnLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.5];
    self.returnLabel.textAlignment = NSTextAlignmentCenter;
    NSString *retunString = NSLocalizedString(@"退货", nil);
    [self.returnLabel setTapActionWithBlock:^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:csnation(@"提示") message:csnation(@"售后问题请联系客服") preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:csnation(@"确定") style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [[CSTotalTool getCurrentShowViewController] presentViewController:alert animated:YES completion:nil];
    }];
    self.returnLabel.text = retunString;
    CGFloat  retunWidth = [[CSTotalTool sharedInstance] getButtonWidth:retunString WithFont:10 WithLefAndeRightMargin:10];
    [self.bgView addSubview:self.returnLabel];
    [self.returnLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(@(26*heightScale));
        make.width.mas_offset(@(checkWidth));
        make.top.mas_equalTo(self.goodPriceLabel.mas_bottom).offset(15*heightScale);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-15*heightScale);
        make.right.mas_equalTo(self.deleteLabel.mas_left).offset(-15*widthScale);
    }];

}

- (void)setModel:(CSNewMineOrderModel *)model
{
    _model = model;
    self.currentModel = model;
    NSDictionary  *goodsInfo = model.goodsInfo;
    NSDictionary  *_status = model._status;
    NSString *statusTitle = _status[@"_title"];
    NSString *statusType = [_status[@"_type"] stringValue];
    CGFloat statusWidth = [[CSTotalTool sharedInstance] getButtonWidth:statusTitle WithFont:9 WithLefAndeRightMargin:8];
    [self.topStatusButton setTitle:statusTitle forState:UIControlStateNormal];
    [self.topStatusButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView.mas_right).offset(-15*widthScale);
        make.centerY.mas_equalTo(self.topTitleLabel.mas_centerY);
        make.width.mas_offset(@(statusWidth));
        make.height.mas_offset(@(15*heightScale));
    }];
    if ([statusType isEqualToString:@"1"]) {//已付款
        [self.topStatusButton setBackgroundImage:[UIImage imageNamed:@"CSMyOrderPayed.png"] forState:UIControlStateNormal];
    }else if ([statusType isEqualToString:@"2"]){//已发货
        [self.topStatusButton setBackgroundImage:[UIImage imageNamed:@"CSMyOrderSended.png"] forState:UIControlStateNormal];
    }else if ([statusType isEqualToString:@"4"]){//已完成
        [self.topStatusButton setBackgroundImage:[UIImage imageNamed:@"CSMyOrderCompleted.png"] forState:UIControlStateNormal];
    }else{
        [self.topStatusButton setBackgroundImage:[UIImage imageNamed:@"CSMyOrderCompleted.png"] forState:UIControlStateNormal];
    }
    
    [self.goodImage sd_setImageWithURL:[NSURL URLWithString:goodsInfo[@"image"]] placeholderImage:[UIImage imageNamed:@"CSNewListBgDefaault.png"]];
    self.goodId = goodsInfo[@"id"];
    self.goodPriceLabel.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"¥", nil),model.total_price];
    self.numLabel.text = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"共", nil),model.total_num,NSLocalizedString(@"件", nil)];
    self.goodTitleLabel.text = goodsInfo[@"store_name"];
    NSString *deleteString = NSLocalizedString(@"删除订单", nil);
    self.deleteLabel.text = deleteString;
    CGFloat  deleteWidth = [[CSTotalTool sharedInstance] getButtonWidth:deleteString WithFont:10 WithLefAndeRightMargin:10];
    if ([model.type isEqualToString:@"0"]) {//课程订单
        self.topTitleLabel.text = @"彩色世界导师课程";
        self.deleteLabel.hidden = NO;
        self.checkLabel.hidden = YES;
        self.returnLabel.hidden = YES;
        [self.deleteLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(@(26*heightScale));
            make.width.mas_offset(@(deleteWidth));
            make.top.mas_equalTo(self.goodPriceLabel.mas_bottom).offset(15*heightScale);
            make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-15*heightScale);
            make.right.mas_equalTo(self.bgView.mas_right).offset(-15*widthScale);
        }];
    }else if([model.type isEqualToString:@"1"]){//会员订单
        self.topTitleLabel.text = @"彩色世界";
        self.deleteLabel.hidden = NO;
        self.checkLabel.hidden = YES;
        self.returnLabel.hidden = YES;
        [self.deleteLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(@(26*heightScale));
            make.width.mas_offset(@(deleteWidth));
            make.top.mas_equalTo(self.goodPriceLabel.mas_bottom).offset(15*heightScale);
            make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-15*heightScale);
            make.right.mas_equalTo(self.bgView.mas_right).offset(-15*widthScale);
        }];
    }else if([model.type isEqualToString:@"2"]){//商品订单
        self.topTitleLabel.text = @"";
        self.deleteLabel.hidden = NO;
        self.checkLabel.hidden = NO;
        self.returnLabel.hidden = NO;
        
    }
}

@end
