//
//  CSNewShopSendOrderViewController.m
//  ColorStar
//
//  Created by apple on 2020/11/20.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewShopSendOrderViewController.h"
#import "CSNewShopAddressListViewController.h"
#import "CSNewShopNetManage.h"
@interface CSNewShopSendOrderViewController ()<UITextViewDelegate>
{
    NSInteger  totalNum;
    NSString  *cart_idStr;
    NSString  *orderKeyStr;
}
@property(nonatomic, strong)UIView          *navView;
@property(nonatomic, strong)UIView          *addressView;
@property(nonatomic, strong)UILabel         *addressSelectLabel;
@property(nonatomic, strong)UILabel         *addressNameLabel;
@property(nonatomic, strong)UILabel         *addressPhoneLabel;
@property(nonatomic, strong)UIImageView     *addressImage;
@property(nonatomic, strong)UILabel         *addressIsFirstLabel;
@property(nonatomic, strong)UILabel         *addressLabel;
@property(nonatomic, strong)UIButton        *addressRightButton;

@property(nonatomic, strong)UIView          *goodView;
@property(nonatomic, strong)UILabel         *goodNameLabel;
@property(nonatomic, strong)UILabel         *goodTitleLabel;
@property(nonatomic, strong)UILabel         *goodSizeLabel;
@property(nonatomic, strong)UILabel         *goodPriceLabel;
@property(nonatomic, strong)UILabel         *goodFreightLeftLabel;
@property(nonatomic, strong)UILabel         *goodFreightRightLabel;
@property(nonatomic, strong)UILabel         *goodRemarkLeftLabel;
@property(nonatomic, strong)UITextView      *goodRemarkRightLabel;
@property(nonatomic, strong)UIImageView     *goodImage;
@property(nonatomic, strong)UIButton        *goodAddButton;
@property(nonatomic, strong)UILabel         *goodNumsLabel;
@property(nonatomic, strong)UIButton        *goodMinuButton;

@property(nonatomic, strong)UIView          *goodBottomView;
@property(nonatomic, strong)UILabel         *goodBottomNumsLabel;
@property(nonatomic, strong)UILabel         *goodBottomPriceLabel;
@property(nonatomic, strong)UIButton        *goodBottomBuyButton;

@property(nonatomic, strong)NSMutableArray  *addressList;
@property(nonatomic, strong)CSNewShopAddressModel  *defautAddressModel;
@end

@implementation CSNewShopSendOrderViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    totalNum = 1;
    self.addressList = [NSMutableArray array];
    self.defautAddressModel = [[CSNewShopAddressModel alloc] init];
    [self makeNavUI];
    [self makeAddressView];
    [self makeShopUI];
    [self makeBottomViuew];
    [self loadCartIdData];
    [self loadAddressList];
}

- (void)loadCartIdData{
    [[CSNewShopNetManage sharedManager] getShopListShopCartIdSuccessWithproductId:self.orderModel.detailProductId Complete:^(CSNetResponseModel * _Nonnull response) {
        if (response.code == 200) {
            NSDictionary  *dict = response.data;
            self->cart_idStr = dict[@"cart_id"];
            [self loadOrderKeyWithCartId:self->cart_idStr];
        }else{
            [WHToast showMessage:response.msg duration:1.0 finishHandler:nil];
        }
        
    } failureComplete:^(NSError * _Nonnull error) {
        [WHToast showMessage:@"请求失败" duration:1.0 finishHandler:nil];
    }];
}

- (void)loadOrderKeyWithCartId:(NSString *)cartId
{
    [[CSNewShopNetManage sharedManager] getShopListShopCartIdSuccessWithcart_id:cartId Complete:^(CSNetResponseModel * _Nonnull response) {
        //        orderKey
        if (response.code==200) {
            NSDictionary  *dict = response.data;
            self->orderKeyStr = dict[@"orderKey"];
        }
        
    } failureComplete:^(NSError * _Nonnull error) {
        
    }];
}
- (void)loadAddressList{
    [[CSNewShopNetManage sharedManager] getShopAddressListShopSuccessComplete:^(CSNetResponseModel * _Nonnull response) {
        NSArray  *array = response.data;
        for (NSDictionary *dict in array) {
            CSNewShopAddressModel *model = [CSNewShopAddressModel yy_modelWithDictionary:dict];
            if ([model.is_default isEqualToString:@"1"]) {
                self.defautAddressModel = model;
                [self refreshUI:model];
            }
            
        }
    } failureComplete:^(NSError * _Nonnull error) {
        
    }];
}
- (void)refreshUI:(CSNewShopAddressModel *)model{
    self.addressSelectLabel.hidden = YES;
    if ([model.is_default isEqualToString:@"1"]) {
        self.addressIsFirstLabel.hidden = NO;
    }else{
        self.addressIsFirstLabel.hidden = YES;
    }
    
    self.addressLabel.text = model.detail;
    self.addressNameLabel.text = model.real_name;
    self.addressPhoneLabel.text = model.phone;
    self.addressImage.hidden = NO;
    [self.addressList addObject:model];
}

#pragma mark--UI--
-(void)makeNavUI{
    self.navView = [[UIView alloc] init];
    self.navView.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_offset(@(kStatusBarHeight + 44.0*heightScale));
    }];
    //
    UIButton  *backButton = [[UIButton alloc] init];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"CSNewShopListBack"] forState:UIControlStateNormal];
    [self.navView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.navView);
        make.bottom.mas_equalTo(self.navView);
        make.width.mas_offset(@(55*heightScale));
        make.height.mas_offset(@(44*heightScale));
    }];
    UILabel  *titleLabel = [[UILabel alloc] init];
    titleLabel.text = NSLocalizedString(@"提交订单",nil);
    titleLabel.font = kFont(18);
    titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.navView.mas_centerX);
        make.centerY.mas_equalTo(backButton.mas_centerY);
    }];
    
}

- (void)makeAddressView{
    self.addressView = [[UIView alloc] init];
    self.addressView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.06];
    [self.view addSubview:self.addressView];
    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(15*widthScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-15*widthScale);
        make.top.mas_equalTo(self.navView.mas_bottom).offset(10*heightScale);
        make.height.mas_offset(@(90*heightScale));
    }];
    
    self.addressSelectLabel = [[UILabel alloc] init];
    self.addressSelectLabel.hidden = NO;
    self.addressSelectLabel.backgroundColor = [UIColor colorWithHexString:@"#181F30" alpha:0.06];
    self.addressSelectLabel.text = NSLocalizedString(@"请选择收货地址",nil);
    self.addressSelectLabel.font = kFont(14);
    self.addressSelectLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.addressSelectLabel.textAlignment = NSTextAlignmentLeft;
    CS_Weakify(self, weakSelf);
    [self.addressSelectLabel setTapActionWithBlock:^{
        CSNewShopAddressListViewController *vc= [CSNewShopAddressListViewController new];
        // vc.listArray = self.addressList;
        vc.addressBlock = ^(CSNewShopAddressModel * _Nonnull model) {
            weakSelf.defautAddressModel = model;
            [weakSelf refreshUI:model];
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [self.addressView addSubview:self.addressSelectLabel];
    [self.addressSelectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.addressView);
        make.right.mas_equalTo(self.addressView.mas_right).offset(-50);
        make.left.mas_equalTo(self.addressView.mas_left).offset(15);
    }];
    
    UIImageView  *addressBgImageView = [[UIImageView alloc] init];
    addressBgImageView.image = [UIImage imageNamed:@"shopAddressBgImageView.png"];
    [self.addressView addSubview:addressBgImageView];
    [addressBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.addressView);
    }];
    
    self.addressNameLabel = [[UILabel alloc] init];
    //self.addressNameLabel.text = NSLocalizedString(@"提交",nil);
    self.addressNameLabel.font = kFont(18);
    self.addressNameLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.addressNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.addressView addSubview:self.addressNameLabel];
    [self.addressNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addressView.mas_left).offset(18*widthScale);
        make.top.mas_equalTo(self.addressView.mas_top).offset(23*heightScale);
    }];
    
    self.addressPhoneLabel = [[UILabel alloc] init];
    //self.addressPhoneLabel.text = NSLocalizedString(@"123121313131",nil);
    self.addressPhoneLabel.font = kFont(12);
    self.addressPhoneLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.5];
    self.addressPhoneLabel.textAlignment = NSTextAlignmentLeft;
    [self.addressView addSubview:self.addressPhoneLabel];
    [self.addressPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addressNameLabel.mas_right).offset(9*widthScale);
        make.centerY.mas_equalTo(self.addressNameLabel.mas_centerY);
    }];
    
    self.addressIsFirstLabel = [[UILabel alloc] init];
    self.addressIsFirstLabel.hidden = YES;
    self.addressIsFirstLabel.backgroundColor = [UIColor colorWithHexString:@"#FA372F"];
    self.addressIsFirstLabel.text = NSLocalizedString(@"默认",nil);
    self.addressIsFirstLabel.font = kFont(9);
    self.addressIsFirstLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    ViewRadius(self.addressIsFirstLabel, 5);
    self.addressIsFirstLabel.textAlignment = NSTextAlignmentCenter;
    [self.addressView addSubview:self.addressIsFirstLabel];
    [self.addressIsFirstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addressPhoneLabel.mas_right).offset(9*widthScale);
        make.centerY.mas_equalTo(self.addressNameLabel.mas_centerY);
        make.width.mas_offset(@(32));
        make.height.mas_offset(@(15));
    }];
    
    self.addressImage = [[UIImageView alloc] init];
    self.addressImage.hidden = YES;
    self.addressImage.image = [UIImage imageNamed:@"shopAddressLocation.png"];
    [self.addressView addSubview:self.addressImage];
    [self.addressImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addressNameLabel.mas_left);
        make.bottom.mas_equalTo(self.addressView.mas_bottom).offset(-20*heightScale);
        make.width.height.mas_offset(@(15*widthScale));
    }];
    
    self.addressLabel = [[UILabel alloc] init];
    //self.addressLabel.text = NSLocalizedString(@"广东省深圳市福田区京基滨河大厦A座1003室",nil);
    self.addressLabel.font = kFont(12);
    self.addressLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.5];
    self.addressLabel.textAlignment = NSTextAlignmentLeft;
    [self.addressView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addressImage.mas_right).offset(5*widthScale);
        make.right.mas_equalTo(self.addressView.mas_right).offset(-10*widthScale);
        make.centerY.mas_equalTo(self.addressImage.mas_centerY);
    }];
    
    self.addressRightButton = [[UIButton alloc] init];
    [self.addressRightButton addTarget:self action:@selector(shopAddressRightClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.addressRightButton setImage:[UIImage imageNamed:@"shopAddressRight.png"] forState:UIControlStateNormal];
    [self.addressView addSubview:self.addressRightButton];
    [self.addressRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.addressView.mas_right);
        make.centerY.mas_equalTo(self.addressView.mas_centerY);
        make.width.mas_offset(@(40*heightScale));
        make.height.mas_offset(@(40*heightScale));
    }];
}

-(void)makeShopUI{
    self.goodView = [[UIView alloc] init];
    self.goodView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.06];
    [self.view addSubview:self.goodView];
    [self.goodView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(15*widthScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-15*widthScale);
        make.top.mas_equalTo(self.addressView.mas_bottom).offset(10*heightScale);
    }];
    
    self.goodNameLabel = [[UILabel alloc] init];
    self.goodNameLabel.hidden = YES;
    self.goodNameLabel.text = NSLocalizedString(@"柠月静苼的店",nil);
    self.goodNameLabel.font = kFont(15);
    self.goodNameLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.goodNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.goodView addSubview:self.goodNameLabel];
    [self.goodNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodView.mas_left).offset(15*widthScale);
        make.top.mas_equalTo(self.goodView.mas_top).offset(20*heightScale);
    }];
    
    self.goodImage = [[UIImageView alloc] init];
    ViewRadius(self.goodImage, 5);
    self.goodImage.clipsToBounds = YES;
    self.goodImage.contentMode = UIViewContentModeScaleAspectFill;
    //self.goodImage .image = [UIImage imageNamed:@"CSLoginAgreeUnSelect.png"];
    [self.goodImage sd_setImageWithURL:[NSURL URLWithString:self.orderModel.image] placeholderImage:[UIImage imageNamed:@"CSNewHeadplaceholderImage.png"]];
    [self.goodView addSubview:self.goodImage ];
    [self.goodImage  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodNameLabel.mas_left);
        make.top.mas_equalTo(self.goodView.mas_top).offset(20*heightScale);
        make.width.height.mas_offset(@(80*heightScale));
    }];
    
    self.goodTitleLabel = [[UILabel alloc] init];
    self.goodTitleLabel.text = self.orderModel.store_name;
    //self.goodTitleLabel.text = NSLocalizedString(@"韩版棒球帽潮鸭舌帽户外运动嘻哈帽时尚情侣遮阳帽街柠...",nil);
    self.goodTitleLabel.font = kFont(12);
    self.goodTitleLabel.numberOfLines = 2;
    self.goodTitleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.goodTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.goodView addSubview:self.goodTitleLabel];
    [self.goodTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodImage.mas_right).offset(15*widthScale);
        make.right.mas_equalTo(self.goodView.mas_right).offset(-15*widthScale);
        make.top.mas_equalTo(self.goodImage.mas_top);
    }];
    
    self.goodSizeLabel = [[UILabel alloc] init];
    self.goodSizeLabel.hidden = YES;
    self.goodSizeLabel.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.06];
    self.goodSizeLabel.text = NSLocalizedString(@"黄色+均码",nil);
    self.goodSizeLabel.font = kFont(10);
    self.goodSizeLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.5];
    self.goodSizeLabel.textAlignment = NSTextAlignmentCenter;
    [self.goodView addSubview:self.goodSizeLabel];
    [self.goodSizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodImage.mas_right).offset(15*widthScale);
        make.top.mas_equalTo(self.goodTitleLabel.mas_bottom).offset(11*heightScale);
        make.width.mas_offset(@(80*widthScale));
        make.height.mas_offset(@(18*heightScale));
    }];
    
    ViewRadius(self.goodSizeLabel, 9*heightScale);
    
    
    self.goodPriceLabel = [[UILabel alloc] init];
    self.goodPriceLabel.text = self.orderModel.price;
    //self.goodPriceLabel.text = NSLocalizedString(@"￥198.80",nil);
    self.goodPriceLabel.font = kFont(18);
    self.goodPriceLabel.textColor = [UIColor colorWithHexString:@"#FA372F"];
    self.goodPriceLabel.textAlignment = NSTextAlignmentLeft;
    [self.goodView addSubview:self.goodPriceLabel];
    [self.goodPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodImage.mas_right).offset(15*widthScale);
        make.bottom.mas_equalTo(self.goodImage.mas_bottom);
    }];
    
    self.goodFreightLeftLabel = [[UILabel alloc] init];
    self.goodFreightLeftLabel.text = NSLocalizedString(@"运费",nil);
    self.goodFreightLeftLabel.font = kFont(12);
    self.goodFreightLeftLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.goodFreightLeftLabel.textAlignment = NSTextAlignmentLeft;
    [self.goodView addSubview:self.goodFreightLeftLabel];
    [self.goodFreightLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodView.mas_left).offset(15*widthScale);
        make.top.mas_equalTo(self.goodImage.mas_bottom).offset(15*heightScale);
    }];
    
    self.goodFreightRightLabel = [[UILabel alloc] init];
    if ([self.orderModel.is_postage isEqualToString:@"0"]) {
        self.goodFreightRightLabel.text = self.orderModel.postage;
    }else{
        self.goodFreightRightLabel.text = NSLocalizedString(@"免运费",nil);
    }
    
    self.goodFreightRightLabel.font = kFont(12);
    self.goodFreightRightLabel.textColor = [UIColor colorWithHexString:@"#C8AE99"];
    self.goodFreightRightLabel.textAlignment = NSTextAlignmentRight;
    [self.goodView addSubview:self.goodFreightRightLabel];
    [self.goodFreightRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.goodView.mas_right).offset(-18*widthScale);
        make.centerY.mas_equalTo(self.goodFreightLeftLabel.mas_centerY);
    }];
    
    self.goodRemarkLeftLabel = [[UILabel alloc] init];
    self.goodRemarkLeftLabel.text = NSLocalizedString(@"订单备注:",nil);
    self.goodRemarkLeftLabel.font = kFont(12);
    self.goodRemarkLeftLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.goodRemarkLeftLabel.textAlignment = NSTextAlignmentLeft;
    [self.goodView addSubview:self.goodRemarkLeftLabel];
    [self.goodRemarkLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodView.mas_left).offset(15*widthScale);
        make.top.mas_equalTo(self.goodFreightLeftLabel.mas_bottom).offset(15*heightScale);
        //make.bottom.mas_equalTo(self.goodView.mas_bottom).offset(-20*heightScale);
    }];
    [self.goodRemarkLeftLabel layoutIfNeeded];
    
    self.goodRemarkRightLabel = [[UITextView alloc] init];
    self.goodRemarkRightLabel.delegate = self;
    self.goodRemarkRightLabel.text = NSLocalizedString(@"和商家协商一致后留言 最多100字",nil);
    self.goodRemarkRightLabel.backgroundColor =[UIColor clearColor];
    self.goodRemarkRightLabel.font = kFont(12);
    //    self.goodRemarkRightLabel.numberOfLines = 0;
    self.goodRemarkRightLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.goodRemarkRightLabel.textAlignment = NSTextAlignmentLeft;
    [self.goodView addSubview:self.goodRemarkRightLabel];
    [self.goodRemarkRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodRemarkLeftLabel.mas_right).offset(5*widthScale);
        make.right.mas_equalTo(self.goodView.mas_right).offset(-18*widthScale);
        make.top.mas_equalTo(self.goodRemarkLeftLabel.mas_top).offset(-8);
        make.height.mas_offset(@(20*heightScale));
        make.bottom.mas_equalTo(self.goodView.mas_bottom).offset(-20*heightScale);
    }];
    
    self.goodAddButton = [[UIButton alloc] init];
    [self.goodAddButton addTarget:self action:@selector(goodAddButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.goodAddButton setImage:[UIImage imageNamed:@"CSShopNumAdd.png"] forState:UIControlStateNormal];
    [self.goodView addSubview:self.goodAddButton];
    [self.goodAddButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.goodView.mas_right).offset(-15*widthScale);
        make.centerY.mas_equalTo(self.goodPriceLabel.mas_centerY);
        make.width.mas_offset(@(17*heightScale));
        make.height.mas_offset(@(17*heightScale));
    }];
    
    self.goodMinuButton = [[UIButton alloc] init];
    [self.goodMinuButton addTarget:self action:@selector(goodMinuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.goodMinuButton setImage:[UIImage imageNamed:@"CSShopNumUnMin.png"] forState:UIControlStateNormal];
    [self.goodView addSubview:self.goodMinuButton];
    [self.goodMinuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.goodAddButton.mas_left).offset(-32*widthScale);
        make.centerY.mas_equalTo(self.goodPriceLabel.mas_centerY);
        make.width.mas_offset(@(17*heightScale));
        make.height.mas_offset(@(17*heightScale));
    }];
    
    self.goodNumsLabel = [[UILabel alloc] init];
    self.goodNumsLabel.text = [NSString stringWithFormat:@"%ld",totalNum];
    self.goodNumsLabel.font = kFont(18);
    self.goodNumsLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.goodNumsLabel.textAlignment = NSTextAlignmentCenter;
    [self.goodView addSubview:self.goodNumsLabel];
    [self.goodNumsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodMinuButton.mas_right);
        make.right.mas_equalTo(self.goodAddButton.mas_left);
        make.centerY.mas_equalTo(self.goodPriceLabel.mas_centerY);
    }];
    
}

- (void)makeBottomViuew{
    self.goodBottomView = [[UIView alloc] init];
    self.goodBottomView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.06];
    [self.view addSubview:self.goodBottomView];
    [self.goodBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_offset(@(60*heightScale + kSafeAreaBottomHeight));
    }];
    
    self.goodBottomNumsLabel = [[UILabel alloc] init];
   // self.goodBottomNumsLabel.text = NSLocalizedString(@"共1件",nil);
    self.goodBottomNumsLabel.font = kFont(15);
    self.goodBottomNumsLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.goodBottomNumsLabel.textAlignment = NSTextAlignmentCenter;
    [self.goodBottomView addSubview:self.goodBottomNumsLabel];
    [self.goodBottomNumsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodBottomView.mas_left).offset(40*widthScale);
        make.top.mas_equalTo(self.goodBottomView.mas_top);
        make.height.mas_offset(@(60*heightScale));
        //make.width.mas_offset(@(120*widthScale));
    }];
    
    UILabel  *allLabel = [[UILabel alloc] init];
    allLabel.text = NSLocalizedString(@"合计:",nil);
    allLabel.font = kFont(15);
    allLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    allLabel.textAlignment = NSTextAlignmentCenter;
    [self.goodBottomView addSubview:allLabel];
    [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodBottomNumsLabel.mas_right).offset(20*widthScale);
        make.centerY.mas_equalTo(self.goodBottomNumsLabel.mas_centerY);
        //make.width.mas_offset(@(50*widthScale));
    }];
    
    self.goodBottomBuyButton = [[UIButton alloc] init];
    ViewRadius(self.goodBottomBuyButton, 17*heightScale);
    [self.goodBottomBuyButton setBackgroundColor:[UIColor colorWithHexString:@"#DDB985"]];
    [self.goodBottomBuyButton addTarget:self action:@selector(goodBottomBuyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.goodBottomBuyButton setTitle:NSLocalizedString(@"立即结算",nil) forState:UIControlStateNormal];
    self.goodBottomBuyButton.titleLabel.font = kFont(15);
    [self.goodBottomBuyButton setTitleColor:[UIColor colorWithHexString:@"#181F30"] forState:UIControlStateNormal];
    [self.goodBottomView addSubview:self.goodBottomBuyButton];
    [self.goodBottomBuyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(@(34*heightScale));
        make.right.mas_equalTo(self.goodBottomView.mas_right).offset(-15*widthScale);
        make.width.mas_offset(@(112*widthScale));
        make.centerY.mas_equalTo(self.goodBottomNumsLabel.mas_centerY);
    }];
    
    self.goodBottomPriceLabel = [[UILabel alloc] init];
    CGFloat tPrice;
    if ([self.orderModel.is_postage isEqualToString:@"0"]) {
        tPrice =  [self.orderModel.price floatValue] *totalNum + [self.orderModel.postage floatValue];
        
    }else{
        tPrice =  [self.orderModel.price floatValue] *totalNum ;
    }
    
    self.goodBottomPriceLabel.text = [NSString stringWithFormat:@"%.2f",tPrice];
    //    self.goodBottomPriceLabel.text = NSLocalizedString(@"198.80",nil);
    self.goodBottomPriceLabel.font = kFont(18);
    self.goodBottomPriceLabel.textColor = [UIColor colorWithHexString:@"#FA372F"];
    self.goodBottomPriceLabel.textAlignment = NSTextAlignmentLeft;
    [self.goodBottomView addSubview:self.goodBottomPriceLabel];
    [self.goodBottomPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(allLabel.mas_right).offset(15*widthScale);
        make.right.mas_equalTo(self.goodBottomBuyButton.mas_left);
        make.centerY.mas_equalTo(self.goodBottomBuyButton.mas_centerY);
    }];
    
    
    
}
- (void)goodBottomBuyButtonClick:(UIButton *)btn{
    
    NSString  *url = [NSString stringWithFormat:@"%@/wap/pay/payInfo?cart_id=%@&special_id=%@&key=%@&mark='%@'&pay_type_num=%@&total_num=%@&token=%@",[CSAPPConfigManager sharedConfig].baseURL,cart_idStr,self.defautAddressModel.addressId,orderKeyStr,[NSString stringWithFormat:@"%@",self.goodRemarkRightLabel.text],@"40",[NSString stringWithFormat:@"%ld",totalNum],[CSAPPConfigManager sharedConfig].sessionKey];
    [[CSWebManager sharedManager] enterWebVCWithURL:url title:@"" withSupVC:[CSTotalTool getCurrentShowViewController]];
    
    
}
- (void)goodMinuButtonClick:(UIButton *)btn{
    
    
    if (totalNum > 1) {
        self.goodNumsLabel.text = [NSString stringWithFormat:@"%ld",totalNum-1];
        totalNum = totalNum-1;
        self.goodBottomNumsLabel.text = [NSString stringWithFormat:@"%@%ld%@",NSLocalizedString(@"共",nil),totalNum,NSLocalizedString(@"件",nil)];//NSLocalizedString(@"共1件",nil);
        CGFloat tPrice;
        if ([self.orderModel.is_postage isEqualToString:@"0"]) {
            tPrice =  [self.orderModel.price floatValue] *totalNum + [self.orderModel.postage floatValue];
            
        }else{
            tPrice =  [self.orderModel.price floatValue] *totalNum ;
        }
        
        self.goodBottomPriceLabel.text = [NSString stringWithFormat:@"%.2f",tPrice];
        [self.goodAddButton setImage:[UIImage imageNamed:@"CSShopNumAdd.png"] forState:UIControlStateNormal];
        if (totalNum >1) {
            [self.goodMinuButton setImage:[UIImage imageNamed:@"CSShopNumMin.png"] forState:UIControlStateNormal];
        }else{
            [self.goodMinuButton setImage:[UIImage imageNamed:@"CSShopNumUnMin.png"] forState:UIControlStateNormal];
        }
    }
    
}
- (void)goodAddButtonClick:(UIButton *)btn{
    if (totalNum < [self.orderModel.stock integerValue]) {
        self.goodNumsLabel.text = [NSString stringWithFormat:@"%ld",totalNum+1];
        totalNum = totalNum+1;
        self.goodBottomNumsLabel.text = [NSString stringWithFormat:@"%@%ld%@",NSLocalizedString(@"共",nil),totalNum,NSLocalizedString(@"件",nil)];
        CGFloat tPrice;
        if ([self.orderModel.is_postage isEqualToString:@"0"]) {
            tPrice =  [self.orderModel.price floatValue] *totalNum + [self.orderModel.postage floatValue];
            
        }else{
            tPrice =  [self.orderModel.price floatValue] *totalNum ;
        }
        
        self.goodBottomPriceLabel.text = [NSString stringWithFormat:@"%.2f",tPrice];
        [self.goodMinuButton setImage:[UIImage imageNamed:@"CSShopNumMin.png"] forState:UIControlStateNormal];
        if (totalNum<[self.orderModel.stock integerValue]) {
            [self.goodAddButton setImage:[UIImage imageNamed:@"CSShopNumAdd.png"] forState:UIControlStateNormal];
        }else{
            [self.goodAddButton setImage:[UIImage imageNamed:@"CSShopNumUnAdd.png"] forState:UIControlStateNormal];
        }
    }
    
    
    
}


- (void)shopAddressRightClick:(UIButton *)btn{
    CS_Weakify(self, weakSelf);
    CSNewShopAddressListViewController *vc= [CSNewShopAddressListViewController new];
    vc.addressBlock = ^(CSNewShopAddressModel * _Nonnull model) {
        weakSelf.defautAddressModel = model;
        [weakSelf refreshUI:model];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)textViewDidChange:(UITextView *)textView{
    //    static CGFloat maxHeight =60.0f;
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height<=frame.size.height) {
        size.height=frame.size.height;
    }else{
        //        if (size.height >= maxHeight)
        //        {
        //            size.height = maxHeight;
        //            textView.scrollEnabled = YES;   // 允许滚动
        //        }
        //        else
        //        {
        textView.scrollEnabled = NO;    // 不允许滚动
        //        }
    }
    textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
    [self.goodRemarkRightLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodRemarkLeftLabel.mas_right).offset(5*widthScale);
        make.right.mas_equalTo(self.goodView.mas_right).offset(-18*widthScale);
        make.top.mas_equalTo(self.goodRemarkLeftLabel.mas_top).offset(-8);
        make.height.mas_offset(@(size.height));
        make.bottom.mas_equalTo(self.goodView.mas_bottom).offset(-20*heightScale);
    }];
}
@end
