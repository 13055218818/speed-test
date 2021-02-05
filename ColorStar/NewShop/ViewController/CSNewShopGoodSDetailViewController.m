//
//  CSNewShopGoodSDetailViewController.m
//  ColorStar
//
//  Created by apple on 2020/11/19.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewShopGoodSDetailViewController.h"
#import <WebKit/WebKit.h>
#import "CSNewShopSendOrderViewController.h"
#import "CSNewShopNetManage.h"
#import "CSNewShopModel.h"
#import "CSAPPConfigManager.h"
#import "CSTotalTool.h"

@interface CSNewShopGoodSDetailViewController ()<UIScrollViewDelegate,WKNavigationDelegate,SDCycleScrollViewDelegate>
{
    CGFloat scrHeight;
}
@property (nonatomic, strong)UIScrollView       *scrollView;
@property (nonatomic, strong)WKWebView          * webView;
@property (nonatomic, strong)SDCycleScrollView  * cycleView;
@property (nonatomic,strong)UILabel             *numLabel;
@property (nonatomic, strong)UIView             *centerView;
@property (nonatomic,strong)UILabel             *priceLabel;
@property (nonatomic, strong)UIButton           *scButton;
@property (nonatomic,strong)UILabel             *titleLabel;
@property (nonatomic,strong)UILabel             *businessNameLabel;
@property (nonatomic,strong)UIView              *businessBottomView;
@property (nonatomic,strong)UIView               *businessView;
@property (nonatomic,strong)UILabel             *bottomLabel;
@property (nonatomic,strong)UIView              *bottomLabelBgview;
@property (nonatomic,strong)UIView              *buyBgView ;
@property (nonatomic, strong)UIButton           *buyButton;
@property (nonatomic, strong)CSNewListDetailModel           *currentModel;
@end

@implementation CSNewShopGoodSDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    self.currentModel = [[CSNewListDetailModel alloc] init];
    [self makeUI];
    [self loadData];
}

- (void)loadData{
    [[CSTotalTool sharedInstance] showHudInView:self.view hint:@""];
    [[CSNewShopNetManage sharedManager] getShopListDetailSuccessWithCid:self.productId Complete:^(CSNetResponseModel * _Nonnull response) {
        [[CSTotalTool sharedInstance] hidHudInView:self.view];
        if (response.code == 200) {
            NSDictionary  *dict = response.data;
            self.currentModel = [CSNewListDetailModel yy_modelWithDictionary:dict];
            self.cycleView.imageURLStringsGroup = self.currentModel.slider_image;
            self.numLabel.text = [NSString stringWithFormat:@"1/%ld",self.currentModel.slider_image.count];
            self.priceLabel.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"¥",nil),self.currentModel.price];
            self.titleLabel.text = self.currentModel.store_name;
            if ([self.currentModel.isfollow isEqualToString:@"0"]) {
                [self.scButton setImage:[UIImage imageNamed:@"CSNewShoipDetailunsc.png"] forState:UIControlStateNormal];
            }else{
                [self.scButton setImage:[UIImage imageNamed:@"CSNewShoipDetailsc.png"] forState:UIControlStateNormal];
            }
            NSString *url = [NSString stringWithFormat:@"%@%@",[CSAPPConfigManager sharedConfig].baseURL,self.currentModel.h5_url];
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
            
        }else{
            
        }
        
    } failureComplete:^(NSError * _Nonnull error) {
        
    }];
}

-(void)makeUI{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.scrollEnabled=YES;
    self.scrollView.delegate = self;
    self.scrollView.contentSize=CGSizeMake(ScreenW, 3*ScreenH);
    self.scrollView.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    [self.view addSubview:self.scrollView];
    
    self.cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -kStatusBarHeight, ScreenW, 375*heightScale) delegate:self placeholderImage:[UIImage imageNamed:@"cs_home_banner"]];
    self.cycleView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    [self.scrollView addSubview:self.cycleView];
    
    self.numLabel = [[UILabel alloc] init];
    self.numLabel.backgroundColor = [UIColor colorWithHexString:@"#292929" alpha:0.5];
    
    self.numLabel.frame = CGRectMake(ScreenW-58*widthScale, 343*heightScale-kStatusBarHeight, 43*widthScale, 22*heightScale);
    ViewRadius(self.numLabel, 11*heightScale);
    self.numLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.numLabel.font = kFont(10);
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:self.numLabel];
    
    self.centerView = [[UIView alloc] init];
    self.centerView.backgroundColor = [UIColor colorWithHexString:@"#292929"];
    self.centerView.frame = CGRectMake(0, 375*heightScale-kStatusBarHeight, ScreenW, 134*heightScale);
    [self.scrollView addSubview:self.centerView];
    
    self.priceLabel = [[UILabel alloc] init];
   // self.priceLabel.text = @"198";
    self.priceLabel.textColor = [UIColor colorWithHexString:@"#CBA769"];
    self.priceLabel.font = [UIFont systemFontOfSize:30];
    self.priceLabel.textAlignment = NSTextAlignmentLeft;
    [self.centerView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.centerView.mas_top).offset(23*heightScale);
        make.left.mas_equalTo(self.centerView.mas_left).offset(15*widthScale);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    //self.titleLabel.text = @"柠月静苼 帽子男女韩版棒球帽潮鸭舌帽户外运动嘻哈帽时尚情侣遮阳帽街头潮刺绣字母";
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.titleLabel.font = kFont(15);
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.centerView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceLabel.mas_bottom).offset(17*heightScale);
        make.left.mas_equalTo(self.centerView.mas_left).offset(15*widthScale);
        make.right.mas_equalTo(self.centerView.mas_right).offset(-15*widthScale);
    }];
    
    self.businessNameLabel = [[UILabel alloc] init];
    self.businessNameLabel.hidden = YES;
    //self.businessNameLabel.text = @"商品来自-柠月静苼";
    self.businessNameLabel.textColor = [UIColor colorWithHexString:@"#808080"];
    self.businessNameLabel.font = kFont(12);
    self.businessNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.centerView addSubview:self.businessNameLabel];
    [self.businessNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.centerView.mas_bottom).offset(-10*heightScale);
        make.left.mas_equalTo(self.centerView.mas_left).offset(29*widthScale);
    }];
    
    
    UIView  *pointView = [[UIView alloc] init];
    pointView.hidden = YES;
    pointView.backgroundColor = [UIColor colorWithHexString:@"#CBA769"];
    ViewRadius(pointView, 3*widthScale);
    [self.centerView addSubview:pointView];
    [pointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(@(6*heightScale));
        make.left.mas_equalTo(self.centerView.mas_left).offset(15*widthScale);
        make.centerY.mas_equalTo(self.businessNameLabel.mas_centerY);
    }];
    
    self.scButton = [[UIButton alloc] init];
    self.scButton.hidden = YES;
    self.scButton.titleLabel.font = kFont(12);
    [self.scButton setTitle:NSLocalizedString(@"收藏",nil) forState:UIControlStateNormal];
    [self.scButton setTitleColor:[UIColor colorWithHexString:@"#808080"] forState:UIControlStateNormal];
    [self.centerView addSubview:self.scButton];
    
    CGFloat scWidth = [[CSTotalTool sharedInstance] getButtonWidth:NSLocalizedString(@"收藏",nil) WithFont:12 WithLefAndeRightMargin:15];
    [self.scButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.centerView.mas_right).offset(-15*widthScale);
        make.centerY.mas_equalTo(self.priceLabel.mas_centerY);
        make.height.mas_offset(@(16*widthScale));
        make.width.mas_offset(@(scWidth));
    }];
    [self.scButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    
    self.businessView= [[UIView alloc] init];
    self.businessView.frame = CGRectMake(0,510*heightScale-kStatusBarHeight, ScreenW, 80*heightScale);
    [self.scrollView addSubview:self.businessView];
    
    UILabel *businessViewLabel=[[UILabel alloc] init];
    businessViewLabel.text = NSLocalizedString(@"商品介绍",nil);
    businessViewLabel.textColor = [UIColor colorWithHexString:@"#CBA769"];
    businessViewLabel.font = kFont(15);
    businessViewLabel.textAlignment = NSTextAlignmentCenter;
    [self.businessView addSubview:businessViewLabel];
    [businessViewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.businessView);
        make.centerY.mas_equalTo(self.businessView);
    }];
    
    UIView  *businessLeftLine = [[UIView alloc] init];
    businessLeftLine.backgroundColor =[UIColor colorWithHexString:@"#CBA769"];
    [self.businessView addSubview:businessLeftLine];
    [businessLeftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(businessViewLabel.mas_left).offset(-8.5*widthScale);
        make.width.mas_offset(@(24*widthScale));
        make.height.mas_offset(@(1.5*heightScale));
        make.centerY.mas_equalTo(businessViewLabel.mas_centerY);
    }];
    
    UIView  *businessRightLine = [[UIView alloc] init];
    businessRightLine.backgroundColor =[UIColor colorWithHexString:@"#CBA769"];
    [self.businessView addSubview:businessRightLine];
    [businessRightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(businessViewLabel.mas_right).offset(8.5*widthScale);
        make.width.mas_offset(@(24*widthScale));
        make.height.mas_offset(@(1.5*heightScale));
        make.centerY.mas_equalTo(businessViewLabel.mas_centerY);
    }];
    //js脚本 （脚本注入设置网页样式）
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    //注入
    
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
    config.userContentController = wkUController;
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 590*heightScale, ScreenW, ScreenH) configuration:config];
    self.webView.navigationDelegate = self;
    self.webView.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    self.webView.scrollView.backgroundColor =[UIColor colorWithHexString:@"#181F30"];
    [self.scrollView addSubview:self.webView];
    
    //
    self.businessBottomView= [[UIView alloc] init];
    self.businessBottomView.frame = CGRectMake(0,ScreenH, ScreenW, 80*heightScale);
    [self.scrollView addSubview:self.businessBottomView];
    
    UILabel *businessBottomViewLabel=[[UILabel alloc] init];
    businessBottomViewLabel.text = NSLocalizedString(@"购买说明",nil);
    businessBottomViewLabel.textColor = [UIColor colorWithHexString:@"#CBA769"];
    businessBottomViewLabel.font = kFont(15);
    businessBottomViewLabel.textAlignment = NSTextAlignmentCenter;
    [self.businessBottomView addSubview:businessBottomViewLabel];
    [businessBottomViewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.businessBottomView);
        make.centerY.mas_equalTo(self.businessBottomView);
    }];
    
    UIView  *businessBottomLeftLine = [[UIView alloc] init];
    businessBottomLeftLine.backgroundColor =[UIColor colorWithHexString:@"#CBA769"];
    [self.businessBottomView addSubview:businessBottomLeftLine];
    [businessBottomLeftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(businessBottomViewLabel.mas_left).offset(-8.5*widthScale);
        make.width.mas_offset(@(24*widthScale));
        make.height.mas_offset(@(1.5*heightScale));
        make.centerY.mas_equalTo(businessBottomViewLabel.mas_centerY);
    }];
    
    UIView  *businessBottomRightLine = [[UIView alloc] init];
    businessBottomRightLine.backgroundColor =[UIColor colorWithHexString:@"#CBA769"];
    [self.businessBottomView addSubview:businessBottomRightLine];
    [businessBottomRightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(businessBottomViewLabel.mas_right).offset(8.5*widthScale);
        make.width.mas_offset(@(24*widthScale));
        make.height.mas_offset(@(1.5*heightScale));
        make.centerY.mas_equalTo(businessBottomViewLabel.mas_centerY);
    }];
    
    
    self.bottomLabelBgview= [[UIView alloc] init];
    self.bottomLabelBgview.backgroundColor = [UIColor colorWithHexString:@"#292929"];
    [self.scrollView addSubview:self.bottomLabelBgview];

    self.bottomLabel = [[UILabel alloc] init];
    self.bottomLabel .numberOfLines = 0;
    //self.bottomLabel .frame = CGRectMake(0, ScreenH, ScreenW, 140*heightScale);
    self.bottomLabel .text =NSLocalizedString(@"彩色世界上的所有商品信息、客户评价、商品咨询网友讨论等内容，是彩色世界重要的经营资源，未经许可，禁止非法转载使用注：本站商品信息均来自于合作方，其真实性、准确性和合法性由信息拥有者（合作方）负责。本站不提供任何保证，并不承担任何法律责任。",nil);
    self.bottomLabel .textColor = [UIColor colorWithHexString:@"#808080"];
    self.bottomLabel .font = kFont(12);
    self.bottomLabel .textAlignment = NSTextAlignmentLeft;
    self.bottomLabel.backgroundColor = [UIColor colorWithHexString:@"#292929"];
    [self.scrollView addSubview:self.bottomLabel ];

    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
           paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
           paraStyle.alignment = NSTextAlignmentLeft;
           paraStyle.lineSpacing = 15*heightScale; //设置行间距
           paraStyle.hyphenationFactor = 1.0;
           paraStyle.firstLineHeadIndent = 0.0;
           paraStyle.paragraphSpacingBefore = 0.0;
           paraStyle.headIndent = 0;
           paraStyle.tailIndent = 0;
           //设置字间距 NSKernAttributeName:@1.5f
           NSDictionary *dic = @{NSFontAttributeName:kFont(12), NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0f
                                 };
           NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:self.bottomLabel.text attributes:dic];
           self.bottomLabel.attributedText = attributeStr;
    
    self.buyBgView = [[UIView alloc] init];
    self.buyBgView.backgroundColor =[UIColor colorWithHexString:@"#292929"];
    [self.scrollView addSubview:self.buyBgView];

    self.buyButton = [[UIButton alloc] init];
    ViewRadius(self.buyButton, 20*heightScale);
    [self.buyButton addTarget:self action:@selector(buyButtonClick:) forControlEvents:UIControlEventTouchUpInside];;
    self.buyButton.titleLabel.font = kFont(15);
    [self.buyButton setTitle:NSLocalizedString(@"立即购买",nil) forState:UIControlStateNormal];
    [self.buyButton setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [self.buyButton setBackgroundColor:[UIColor colorWithHexString:@"#CBA769"]];
    [self.buyBgView addSubview:self.buyButton];

    [self.buyBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_offset(@(60*heightScale + kTabBarStatusHeight));
    }];
        [self.buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.buyBgView.mas_centerX);
            make.top.mas_equalTo(self.buyBgView.mas_top).offset(10*heightScale);
            make.width.mas_offset(@(300*widthScale));
            make.height.mas_offset(@(40*heightScale));
        }];
}

-(void)buyButtonClick:(UIButton *)btn{
    if ([[CSNewLoginUserInfoManager sharedManager] isLogin]) {
        CSNewShopSendOrderViewController  *vc = [CSNewShopSendOrderViewController new];
        vc.orderModel = self.currentModel;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [[CSNewLoginUserInfoManager sharedManager] goToLogin:^(BOOL success) {
            
        }];
    }
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    self.numLabel.text = [NSString stringWithFormat:@"%ld/%ld",index + 1,self.currentModel.slider_image.count];
}

#pragma mark  - KVO回调
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    //更具内容的高重置webView视图的高度
    NSLog(@"Height is changed! new=%@", [change valueForKey:NSKeyValueChangeNewKey]);
    NSLog(@"tianxia :%@",NSStringFromCGSize(self.webView.scrollView.contentSize));
    CGFloat newHeight = self.webView.scrollView.contentSize.height;
    NSLog(@"%f",newHeight);
    self.scrollView.contentSize=CGSizeMake(ScreenW, 590*heightScale  + newHeight +220*heightScale);
    [self.scrollView layoutIfNeeded];
    self.webView.frame = CGRectMake(0, 590*heightScale - kStatusBarHeight , ScreenW, newHeight);
    [self.webView layoutIfNeeded];
    self.businessBottomView.frame = CGRectMake(0,590*heightScale  + newHeight -kStatusBarHeight, ScreenW, 80*heightScale);
    [self.businessBottomView layoutIfNeeded];
    self.bottomLabel.frame = CGRectMake(15*widthScale, 590*heightScale  + newHeight -kStatusBarHeight +80*heightScale, ScreenW - 30*widthScale, 140*heightScale);
    //[self.bottomLabel layoutIfNeeded];
    self.bottomLabelBgview.frame= CGRectMake(0, 590*heightScale  + newHeight -kStatusBarHeight +80*heightScale, ScreenW , 140*heightScale);
    [self.bottomLabelBgview layoutIfNeeded];
    
    UIButton  *backButton = [[UIButton alloc] init];
    backButton.frame = CGRectMake(10*widthScale, 11*heightScale, 30*widthScale, 30*widthScale);
    [backButton setImage:[UIImage imageNamed:@"CSNewShoipDetailBack.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:backButton];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}
@end
