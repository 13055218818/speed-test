//
//  CSNewShopAddressEditeViewController.m
//  ColorStar
//
//  Created by apple on 2020/11/20.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewShopAddressEditeViewController.h"
#import "CSTotalTool.h"
#import "DLAddressAlertController.h"
#import "DLBaseAnimation.h"
#import "DLAddressAnimation.h"
#import "UIViewController+DLPresent.h"
#import "CSNewCourseCategoryView.h"
#import "CSNewCourseModel.h"
#import "CSNewShopNetManage.h"

@interface CSNewShopAddressEditeViewController ()<UITextFieldDelegate>
{
    NSString *province;
    NSString *city;
    NSString *district;
    NSString *is_default;
}
@property(nonatomic, strong)UIView             *navView;
@property(nonatomic, strong)UILabel            *deleteButton;
@property(nonatomic, strong)UIView             *bottomView;
@property(nonatomic, strong)UIView             *centerView;
@property(nonatomic, strong)UILabel            *leftNameLabel;
@property(nonatomic, strong)UILabel            *leftPhoneLabel;
@property(nonatomic, strong)UILabel            *leftAddressLabel;
@property(nonatomic, strong)UILabel            *leftDetailAddressLabel;
@property(nonatomic, strong)UILabel            *phoneAreLabel;
@property(nonatomic, strong)UIButton           *phoneAreButton;
@property(nonatomic, strong)UITextField        *nameTexeField;
@property(nonatomic, strong)UITextField        *phoneTexeField;
@property(nonatomic, strong)UITextField        *addressTexeField;
@property(nonatomic, strong)UITextField        *addressDetailTexeField;
@property(nonatomic, strong)UIView             *lineView1;
@property(nonatomic, strong)UIView             *lineView2;
@property(nonatomic, strong)UIView             *lineView3;
@property(nonatomic, strong)UIView             *lineView4;

@property(nonatomic, strong)UILabel            *arePhoneNum;
@property(nonatomic, strong)UIButton            *arePhoneNumRightButton;
@property(nonatomic, strong)UIButton            *addressSelectButton;
@property (nonatomic, strong)CSNewCourseCategoryView    *courseCategorySelectView;
@property(nonatomic, strong)NSMutableArray      *areaListArray;
@property(nonatomic, strong) NSMutableArray * countryArray;

@property(nonatomic, strong)UISwitch        *addressSwitch;

@end

@implementation CSNewShopAddressEditeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    self.areaListArray = [NSMutableArray array];
    self.countryArray = [NSMutableArray array];
    [self loadCountryData];
    [self makeNavUI];
    [self makeCenterView];
    [self makeBottomView];
    if (self.currentModel) {
        self.nameTexeField.text = self.currentModel.real_name;
        self.phoneTexeField.text = self.currentModel.phone;
        
        self.addressDetailTexeField.text = self.currentModel.detail;
        if ([self.currentModel.is_default isEqualToString:@"0"]) {
            self.addressSwitch.on = NO;
            
        }else{
            self.addressSwitch.on = YES;
        }
        is_default = self.currentModel.is_default;
        province = self.currentModel.province;
        city= self.currentModel.city;
        district = self.currentModel.district;
        self.addressTexeField.text = [NSString stringWithFormat:@"%@%@%@",province,city,district];
        self.arePhoneNum.text =self.currentModel.area_code;
    }
    
    
}
//获取省市区数据
- (id)getDataFromPathName:(NSString *)pathName {
    NSString *path = [[NSBundle mainBundle] pathForResource:pathName ofType:@"json"];
    if (path == nil) {
        NSLog(@"路径解析出现错误");
        return nil;
    } else {
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSError *error = nil;
        id temp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (error) {
            NSLog(@"%@",error);
        }
        return temp;
    }
}

- (void)loadCountryData{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self getDataFromPathName:@"country"]];
    NSMutableArray *codeArray = [NSMutableArray array];
    for (NSInteger i=0; i<array.count; i ++) {
        NSDictionary  *dict = array[i];
        NSString  *str=dict[@"phoneCode"];
        if ([str isEqualToString:@"(null)"]) {
            str = @"00";
        }
        [codeArray addObject:str];
    }
    NSMutableArray  *noSameArray = [NSMutableArray array];
    for (NSString *str in codeArray) {
           if (![noSameArray containsObject:str]) {
               [noSameArray addObject:str];
           }
    }
        
        for (NSInteger i=0; i<noSameArray.count; i ++) {
            CSNewCourseCategoryModel *model = [[CSNewCourseCategoryModel alloc] init];
            model.name=[NSString stringWithFormat:@"+%@",noSameArray[i]];
            model.categoryId = model.name;
            model.isSelect = NO;
            [self.countryArray addObject:model];
        }

    
}

- (void)addAndEditAddress:(NSDictionary  *)dict{
    [[CSNewShopNetManage sharedManager] getShopAddressAddAndEdit:dict Complete:^(CSNetResponseModel * _Nonnull response) {
        if (response.code==200) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failureComplete:^(NSError * _Nonnull error) {
        
    }];
}
- (NSMutableArray *)countryArray {
    if (!_countryArray) {
        _countryArray = [NSMutableArray array];
    }
    return _countryArray;
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
    titleLabel.text = NSLocalizedString(@"地址列表",nil);
    titleLabel.font = kFont(18);
    titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.navView.mas_centerX);
        make.centerY.mas_equalTo(backButton.mas_centerY);
    }];
    
    UIImageView  *topImage = [[UIImageView alloc] init];
    topImage.image = [UIImage imageNamed:@"CSNewShopAddressListTopImage.png"];
    [self.view addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(15*widthScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-15*widthScale);
        make.top.mas_equalTo(self.navView.mas_bottom).offset(20*heightScale);
        make.height.mas_offset(@(2.5));
    }];
    
    self.deleteButton = [[UILabel alloc] init];
    if (self.currentModel) {
        self.deleteButton.hidden = NO;
    }else{
        self.deleteButton.hidden = YES;
    }
    self.deleteButton.text = NSLocalizedString(@"删除",nil);
    self.deleteButton.font = kFont(15);
    self.deleteButton.textColor = [UIColor colorWithHexString:@"#C8AE99"];
    self.deleteButton.textAlignment = NSTextAlignmentRight;
    CS_Weakify(self, weakSelf);
    [self.deleteButton setTapActionWithBlock:^{
        [[CSNewShopNetManage sharedManager] getShopAddressDelete:weakSelf.currentModel.addressId Complete:^(CSNetResponseModel * _Nonnull response) {
            if (response.code == 200) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        } failureComplete:^(NSError * _Nonnull error) {
                
        }];
        
    }];
    [self.navView addSubview:self.deleteButton];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleLabel.mas_centerY);
        make.right.mas_equalTo(self.navView.mas_right).offset(-15*heightScale);
    }];
    
}

- (void)makeCenterView{
    self.centerView = [[UIView alloc] init];
    ViewRadius(self.centerView, 5);
    self.centerView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.06];
    [self.view addSubview:self.centerView];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(15*widthScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-15*widthScale);
        make.top.mas_equalTo(self.navView.mas_bottom).offset(43*heightScale);
        make.height.mas_offset(@(190*heightScale));
    }];
    
    self.leftNameLabel = [[UILabel alloc] init];
    self.leftNameLabel.text = NSLocalizedString(@"收货人:",nil);
    self.leftNameLabel.font = kFont(12);
    self.leftNameLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.leftNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.centerView addSubview:self.leftNameLabel];
    [self.leftNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.centerView.mas_top).offset(21*heightScale);
        make.left.mas_equalTo(self.centerView.mas_left).offset(15*heightScale);
    }];
    [self.leftNameLabel layoutIfNeeded];
    
    self.nameTexeField = [[UITextField alloc] init];
    self.nameTexeField.delegate = self;
    self.nameTexeField.placeholder = NSLocalizedString(@"请输入姓名",nil);
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"请输入姓名",nil) attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FFFFFF" alpha:0.5],NSFontAttributeName:kFont(12)}];
   self.nameTexeField.attributedPlaceholder = attrString;
    self.nameTexeField.borderStyle = UITextBorderStyleNone;
    self.nameTexeField.font = [UIFont boldSystemFontOfSize:12];
    self.nameTexeField.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [self.centerView addSubview:self.nameTexeField];
    [self.nameTexeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftNameLabel.mas_right).offset(14*widthScale);
        make.centerY.mas_equalTo(self.leftNameLabel.mas_centerY);
        make.right.mas_equalTo(self.centerView.mas_right).offset(-15*widthScale);
        make.height.mas_offset(@(24*heightScale));
    }];
    
    self.lineView1 = [[UIView alloc] init];
    self.lineView1.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.06];
    [self.centerView addSubview:self.lineView1];
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.nameTexeField);
        make.top.mas_equalTo(self.nameTexeField.mas_bottom);
        make.height.mas_offset(@(1/[UIScreen mainScreen].scale));
    }];
    

    
    self.leftPhoneLabel = [[UILabel alloc] init];
    self.leftPhoneLabel.text = NSLocalizedString(@"联系电话:",nil);
    self.leftPhoneLabel.font = kFont(12);
    self.leftPhoneLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.leftPhoneLabel.textAlignment = NSTextAlignmentLeft;
    [self.centerView addSubview:self.leftPhoneLabel];
    [self.leftPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.leftNameLabel.mas_bottom).offset(33*heightScale);
        make.left.mas_equalTo(self.centerView.mas_left).offset(15*heightScale);
    }];
    
    self.arePhoneNum = [[UILabel alloc] init];
    self.arePhoneNum.text =@"+86";
    self.arePhoneNum.font = kFont(12);
    self.arePhoneNum.textColor = [UIColor colorWithHexString:@"#C8AE99"];
    self.arePhoneNum.textAlignment = NSTextAlignmentLeft;
    CS_Weakify(self, weakSelf);
    [weakSelf.arePhoneNum setTapActionWithBlock:^{
        weakSelf.courseCategorySelectView= [[CSNewCourseCategoryView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        weakSelf.courseCategorySelectView.clickBlock = ^(CSNewCourseCategoryModel * _Nonnull model) {
            weakSelf.arePhoneNum.text = model.name;
            
        };
        [weakSelf.courseCategorySelectView refreshUIWith:weakSelf.countryArray];
        [weakSelf.courseCategorySelectView showView];
    }];
    [self.centerView addSubview:self.arePhoneNum];
    [self.arePhoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftPhoneLabel.mas_right).offset(14*widthScale);
        make.centerY.mas_equalTo(self.leftPhoneLabel.mas_centerY);
        make.height.mas_offset(@(24*heightScale));
    }];
    
    self.arePhoneNumRightButton = [[UIButton alloc] init];
    [self.arePhoneNumRightButton setImage:[UIImage imageNamed:@"cs_tutor_new_course_checkmore"] forState:UIControlStateNormal];
    [self.centerView addSubview:self.arePhoneNumRightButton];
    [self.arePhoneNumRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.arePhoneNum.mas_right).offset(5);
        make.centerY.mas_equalTo(self.arePhoneNum.mas_centerY);
        make.width.height.mas_offset(10);
    }];
    
    
    self.phoneTexeField = [[UITextField alloc] init];
    self.phoneTexeField.delegate = self;
    self.phoneTexeField.placeholder = NSLocalizedString(@"请输入手机号码",nil);
    NSAttributedString *attrStringPhone = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"请输入手机号码",nil) attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FFFFFF" alpha:0.5],NSFontAttributeName:kFont(12)}];
   self.phoneTexeField.attributedPlaceholder = attrStringPhone;
    self.phoneTexeField.borderStyle = UITextBorderStyleNone;
    self.phoneTexeField.font = [UIFont boldSystemFontOfSize:12];
    self.phoneTexeField.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [self.centerView addSubview:self.phoneTexeField];
    [self.phoneTexeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.arePhoneNumRightButton.mas_right).offset(8*widthScale);
        make.centerY.mas_equalTo(self.leftPhoneLabel.mas_centerY);
        make.right.mas_equalTo(self.centerView.mas_right).offset(-15*widthScale);
        make.height.mas_offset(@(24*heightScale));
    }];
    
    self.lineView2 = [[UIView alloc] init];
    self.lineView2.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.06];
    [self.centerView addSubview:self.lineView2];
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.phoneTexeField);
        make.top.mas_equalTo(self.phoneTexeField.mas_bottom);
        make.height.mas_offset(@(1/[UIScreen mainScreen].scale));
    }];
    [self.leftPhoneLabel layoutIfNeeded];
    //
    self.leftAddressLabel = [[UILabel alloc] init];
    self.leftAddressLabel.text = NSLocalizedString(@"所在地区:",nil);
    self.leftAddressLabel.font = kFont(12);
    self.leftAddressLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.leftAddressLabel.textAlignment = NSTextAlignmentLeft;
    [self.centerView addSubview:self.leftAddressLabel];
    [self.leftAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.leftPhoneLabel.mas_bottom).offset(33*heightScale);
        make.left.mas_equalTo(self.centerView.mas_left).offset(15*heightScale);
    }];
//    [self.leftAddressLabel layoutIfNeeded];
    self.addressTexeField = [[UITextField alloc] init];
    self.addressTexeField.delegate = self;
    self.addressTexeField.placeholder = NSLocalizedString(@"选择地址",nil);
    NSAttributedString *attrStringAddress = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"选择地址",nil) attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FFFFFF" alpha:0.5],NSFontAttributeName:kFont(12)}];
   self.addressTexeField.attributedPlaceholder = attrStringAddress;
    self.addressTexeField.borderStyle = UITextBorderStyleNone;
    self.addressTexeField.font = [UIFont boldSystemFontOfSize:12];
    self.addressTexeField.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [self.centerView addSubview:self.addressTexeField];
    [self.addressTexeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftAddressLabel.mas_right).offset(14*widthScale);
        make.centerY.mas_equalTo(self.leftAddressLabel.mas_centerY);
        make.right.mas_equalTo(self.centerView.mas_right).offset(-55*widthScale);
        make.height.mas_offset(@(24*heightScale));
    }];
    
    self.addressSelectButton = [[UIButton alloc] init];
    if ([[CSAPPConfigManager sharedConfig] languageType]==CSAPPLanuageTypeCN) {
        self.addressSelectButton.hidden = NO;
        self.addressTexeField.enabled = NO;
    }else{
        self.addressSelectButton.hidden = YES;
        self.addressTexeField.enabled = YES;
    }
    [self.addressSelectButton setImage:[UIImage imageNamed:@"shopAddressLocation"] forState:UIControlStateNormal];
    [self.addressSelectButton addTarget:self action:@selector(addressCitySelectButton) forControlEvents:UIControlEventTouchUpInside];
    self.addressSelectButton.titleLabel.font = kFont(13);
    [self.addressSelectButton setTitleColor:[UIColor colorWithHexString:@"#C8AE99"] forState:UIControlStateNormal];
    [self.addressSelectButton setTitle:NSLocalizedString(@"定位",nil) forState:UIControlStateNormal];
    [self.centerView addSubview:self.addressSelectButton];
    
    CGFloat addressSelectButtonWidth = [[CSTotalTool sharedInstance] getButtonWidth:NSLocalizedString(@"定位",nil) WithFont:13 WithLefAndeRightMargin:15];
    [self.addressSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.addressTexeField.mas_centerY);
        make.right.mas_equalTo(self.centerView);
        make.width.mas_offset(@(addressSelectButtonWidth));
        make.height.mas_offset(@(20));
    }];

    self.lineView3 = [[UIView alloc] init];
    self.lineView3.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.06];
    [self.centerView addSubview:self.lineView3];
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.addressTexeField);
        make.top.mas_equalTo(self.addressTexeField.mas_bottom);
        make.height.mas_offset(@(1/[UIScreen mainScreen].scale));
    }];
//
    self.leftDetailAddressLabel = [[UILabel alloc] init];
    self.leftDetailAddressLabel.text = NSLocalizedString(@"详细地址:",nil);
    self.leftDetailAddressLabel.font = kFont(12);
    self.leftDetailAddressLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.leftDetailAddressLabel.textAlignment = NSTextAlignmentLeft;
    [self.centerView addSubview:self.leftDetailAddressLabel];
    [self.leftDetailAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.leftAddressLabel.mas_bottom).offset(33*heightScale);
        make.left.mas_equalTo(self.centerView.mas_left).offset(15*heightScale);
    }];
//
    self.addressDetailTexeField = [[UITextField alloc] init];
    self.addressDetailTexeField.delegate = self;
    self.addressDetailTexeField.placeholder = NSLocalizedString(@"请输入具体地址",nil);
    NSAttributedString *attrStringAddressDetail = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"请输入具体地址",nil) attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FFFFFF" alpha:0.5],NSFontAttributeName:kFont(12)}];
   self.addressDetailTexeField.attributedPlaceholder = attrStringAddressDetail;
    self.addressDetailTexeField.borderStyle = UITextBorderStyleNone;
    self.addressDetailTexeField.font = [UIFont boldSystemFontOfSize:12];
    self.addressDetailTexeField.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [self.centerView addSubview:self.addressDetailTexeField];
    [self.addressDetailTexeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftDetailAddressLabel.mas_right).offset(14*widthScale);
        make.centerY.mas_equalTo(self.leftDetailAddressLabel.mas_centerY);
        make.right.mas_equalTo(self.centerView.mas_right).offset(-15*widthScale);
        make.height.mas_offset(@(24*heightScale));
    }];
//
    self.lineView4 = [[UIView alloc] init];
    self.lineView4.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.06];
    [self.centerView addSubview:self.lineView4];
    [self.lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.addressDetailTexeField);
        make.top.mas_equalTo(self.addressDetailTexeField.mas_bottom);
        make.height.mas_offset(@(1/[UIScreen mainScreen].scale));
    }];
    
    UIView *switchView = [[UIView alloc] init];
    ViewRadius(self.centerView, 5);
    switchView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.06];
    [self.view addSubview:switchView];
   
    [switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(15*widthScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-15*widthScale);
        make.top.mas_equalTo(self.centerView.mas_bottom).offset(5*heightScale);
        make.height.mas_offset(@(55*heightScale));
    }];
    
    UILabel *leftDefaultLabel = [[UILabel alloc] init];
    leftDefaultLabel.text = NSLocalizedString(@"设置为默认地址",nil);
    leftDefaultLabel.font = kFont(12);
    leftDefaultLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    leftDefaultLabel.textAlignment = NSTextAlignmentLeft;
    [switchView addSubview:leftDefaultLabel];
    [leftDefaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(switchView.centerY);
        make.left.mas_equalTo(switchView.mas_left).offset(15*heightScale);
    }];
    
    self.addressSwitch = [[UISwitch alloc] init];
    self.addressSwitch.on=NO;
    is_default = @"0";
    [self.addressSwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    [switchView addSubview:self.addressSwitch];
    [self.addressSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(switchView.mas_centerY);
        make.right.mas_equalTo(switchView.mas_right).offset(-15*heightScale);
    }];
    
}

- (void)makeBottomView{
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.06];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_offset(@(60*heightScale + kSafeAreaBottomHeight));
        
    }];
    
    UIButton *addAdressButton = [[UIButton alloc] init];
    ViewRadius(addAdressButton, 17*heightScale);
    [addAdressButton setBackgroundColor:[UIColor colorWithHexString:@"#DDB985"]];
    [addAdressButton addTarget:self action:@selector(addAdressButtonButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [addAdressButton setTitle:csnation(@"保存") forState:UIControlStateNormal];
    addAdressButton.titleLabel.font = kFont(15);
    [addAdressButton setTitleColor:[UIColor colorWithHexString:@"#181F30"] forState:UIControlStateNormal];
    [self.bottomView addSubview:addAdressButton];
    [addAdressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomView.mas_top).offset(13*heightScale);
        make.left.mas_equalTo(self.view.mas_left).offset(20*widthScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-20*widthScale);
        make.height.mas_offset(@(34));
    }];
    
}

- (void)addAdressButtonButtonClick:(UIButton *)btn{
    
    
    if (self.nameTexeField.text.length >0 && self.arePhoneNum.text.length>0 && self.phoneTexeField.text.length>0&&self.addressTexeField.text.length>0&&self.addressDetailTexeField.text.length >0) {
        NSString *addid=@"";
        if (self.currentModel) {
            addid = self.currentModel.addressId;
        }
        if ([CSAPPConfigManager sharedConfig].languageType != CSAPPLanuageTypeCN) {
            province = @"";
            city = @"";
            district = @"";
        }
        NSDictionary  *dict = @{@"id":addid,
                                @"real_name":self.nameTexeField.text,
                                @"phone":self.phoneTexeField.text,
                                @"province":province,
                                @"city":city,
                                @"district":district,
                                @"detail":self.addressDetailTexeField.text,
                                @"is_default":is_default,
                                @"area_code":self.arePhoneNum.text,
                                @"token":[CSAPPConfigManager sharedConfig].sessionKey
        };
        [self addAndEditAddress:dict];
    }

    
    
}
- (void)addressCitySelectButton{
    DLBaseAnimation *animation = nil;
    DLAddressAlertController *addressAlertC = [[DLAddressAlertController alloc] init];
    animation= [[DLAddressAnimation alloc] init];
    //[self presentViewController:addressAlertC animated:animation completion:nil];
    [self presentViewController:addressAlertC animation:animation completion:nil];
    CS_Weakify(self, weakSelf);
    addressAlertC.selectValues = ^(NSArray * _Nonnull addressArray) {
        NSLog(@"%@",addressArray);
        for (NSInteger i=0; i<addressArray.count; i ++) {
            NSDictionary *dict=addressArray[i];
            if (i ==0) {
                self->province = dict[@"name"];
                }else if (i ==1) {
                    self->city = dict[@"name"];
            }else if (i ==2) {
                self->district = dict[@"name"];
            }
        }
        if (![self->province isEqualToString:self->city]) {
            self->province = @"";
            weakSelf.addressTexeField.text = [NSString stringWithFormat:@"%@%@%@",self->province,self->city,self->district];
        }else{
            weakSelf.addressTexeField.text = [NSString stringWithFormat:@"%@%@",self->city,self->district];
        }
        
    };
}

-(void)switchChange:(id)sender{
   UISwitch* openbutton = (UISwitch*)sender;
   BOOL ison = openbutton.isOn;
    if(ison){
        NSLog(@"打开了");
        is_default = @"1";
    }else{
        NSLog(@"关闭了");
        is_default = @"0";
    }
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
