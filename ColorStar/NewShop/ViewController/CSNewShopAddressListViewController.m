//
//  CSNewShopAddressListViewController.m
//  ColorStar
//
//  Created by apple on 2020/11/20.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewShopAddressListViewController.h"
#import "CSNewShopAddressListCell.h"
#import "CSNewShopAddressEditeViewController.h"
#import "DLAddressAlertController.h"
#import "DLBaseAnimation.h"
#import "DLAddressAnimation.h"
#import "UIViewController+DLPresent.h"
#import "CSNewShopNetManage.h"
@interface CSNewShopAddressListViewController ()<UITableViewDelegate,UITableViewDataSource,CSNewShopAddressListCellCellDelegate>
@property(nonatomic, strong)UIView          *navView;
@property(nonatomic, strong)UIView          *bottomView;
@property(nonatomic, strong)UITableView     *tableView;
@property (nonatomic, strong)NSMutableArray   *listArray;
@end

@implementation CSNewShopAddressListViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.listArray = [NSMutableArray array];
    [self loadAddressList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    [self makeNavUI];
    [self makeBottomView];
}
- (void)loadAddressList{
    [[CSNewShopNetManage sharedManager] getShopAddressListShopSuccessComplete:^(CSNetResponseModel * _Nonnull response) {
        if (response.code == 200) {
            NSArray  *array = response.data;
            [self.listArray removeAllObjects];
            for (NSDictionary *dict in array) {
                CSNewShopAddressModel *model = [CSNewShopAddressModel yy_modelWithDictionary:dict];
                [self.listArray addObject:model];
                [self.tableView reloadData];
            }
        }
       
    } failureComplete:^(NSError * _Nonnull error) {
        
    }];
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
    [addAdressButton setImage:[UIImage imageNamed:@"CSShopAddressListBottomAdd.png"] forState:UIControlStateNormal];
    [addAdressButton setTitle:csnation(@"添加新地址") forState:UIControlStateNormal];
    addAdressButton.titleLabel.font = kFont(15);
    [addAdressButton setTitleColor:[UIColor colorWithHexString:@"#181F30"] forState:UIControlStateNormal];
    [self.bottomView addSubview:addAdressButton];
    [addAdressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomView.mas_top).offset(13*heightScale);
        make.left.mas_equalTo(self.view.mas_left).offset(20*widthScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-20*widthScale);
        make.height.mas_offset(@(34));
    }];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 10;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CSNewShopAddressListCell class] forCellReuseIdentifier:@"CSNewShopAddressListCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navView.mas_bottom).offset(33*heightScale);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
}

- (void)addAdressButtonButtonClick:(UIButton *)btn{
    [self.navigationController pushViewController:[CSNewShopAddressEditeViewController new] animated:YES];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark--tableviewDelegate--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSNewShopAddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSNewShopAddressListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    if (self.listArray.count > 0) {
        CSNewShopAddressModel  *model = self.listArray[indexPath.row];
        cell.model = model;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSNewShopAddressModel  *model = self.listArray[indexPath.row];
    if (self.addressBlock) {
        self.addressBlock(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)CSNewShopAddressListCellEditButton:(CSNewShopAddressModel *)model{
    CSNewShopAddressEditeViewController *vc = [CSNewShopAddressEditeViewController new];
    vc.currentModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
