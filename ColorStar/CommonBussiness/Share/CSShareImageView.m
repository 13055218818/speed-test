//
//  CSShareImageView.m
//  ColorStar
//
//  Created by apple on 2021/1/14.
//  Copyright © 2021 gavin. All rights reserved.
//

#import "CSShareImageView.h"
#import "CSShareView.h"
#import "CSNewMineNetManage.h"
#import "CSShareManager.h"
@interface CSShareImageView()
@property(nonatomic, strong)UIView          *mainView;
@property(nonatomic ,strong)UIImageView     *topImageView;
@property(nonatomic ,strong)UIImageView     *headImageView;
@property(nonatomic ,strong)UIButton        *shareButton;
@property(nonatomic ,strong)UILabel        *detailLabel;
@property(nonatomic ,strong)UIImageView     *iconImageView;
@property(nonatomic ,strong)UIImageView     *codeImageView;
@property(nonatomic ,strong)UILabel        *iconLabel;
@property (nonatomic, strong)CSShareView            *shareView;
@property(nonatomic, strong)UILabel         *cedeLabel;
@end
@implementation CSShareImageView

- (void)cs_loadView{
    self.mainView = [[UIView alloc] init];
    self.mainView.backgroundColor = [UIColor colorWithHexString:@"#25314D"];
    [self.contentView addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(@(550));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.right.mas_equalTo(self.contentView);
    }];
    
    self.topImageView = [[UIImageView alloc] init];
    self.topImageView.layer.masksToBounds = YES;
    ViewRadius(self.topImageView, 10);
    self.topImageView.contentMode = UIViewContentModeScaleAspectFill;
    if ([CSAPPConfigManager sharedConfig].languageType == CSAPPLanuageTypeCN) {
        self.topImageView.image = [UIImage imageNamed:@"shareTopbanner_w.png"];
    }else{
        self.topImageView.image = [UIImage imageNamed:@"shareTopbanner_w_E.png"];
    }
    [self.mainView addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mainView.mas_left).offset(20);
        make.right.mas_equalTo(self.mainView.mas_right).offset(-20);
        make.top.mas_equalTo(self.mainView.mas_top).offset(20);
        make.height.mas_offset(@(175));
    }];
    
    self.headImageView = [[UIImageView alloc] init];
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
    ViewRadius(self.headImageView, 35);
    ViewBorder(self.headImageView, [UIColor colorWithHexString:@"#D7B393"], 1);
    CSNewLoginModel * currentUserInfo =[CSNewLoginUserInfoManager sharedManager].userInfo;
    NSString * headImage = currentUserInfo.avatar;
    if (![currentUserInfo.avatar hasPrefix:@"http"]) {
        headImage = [NSString stringWithFormat:@"%@%@",[CSAPPConfigManager sharedConfig].baseURL,currentUserInfo.avatar];
    }
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:headImage] placeholderImage:[UIImage imageNamed:@"CSNewMyDefultImage.png"]];
    [self.mainView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(70);
        make.centerX.mas_equalTo(self.mainView.mas_centerX);
        make.top.mas_equalTo(self.topImageView.mas_bottom).offset(20);
    }];
    
    self.cedeLabel = [[UILabel alloc] init];
    self.cedeLabel.text = [NSString stringWithFormat:@"%@%@",csnation(@"邀请码："),currentUserInfo.spread_code];
    self.cedeLabel.textColor = [UIColor whiteColor];
    self.cedeLabel.font = [UIFont systemFontOfSize:17];
    self.cedeLabel.textAlignment = NSTextAlignmentCenter;
    [self.mainView addSubview:self.cedeLabel];
    [self.cedeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mainView.mas_centerX);
        make.top.mas_equalTo(self.headImageView.mas_bottom).offset(10);
    }];
    
    self.shareButton = [[UIButton alloc] init];
    ViewRadius(self.shareButton, 18);
    ViewBorder(self.shareButton, [UIColor colorWithHexString:@"#D7B393"], 1);
    self.shareButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.shareButton setTitle:csnation(@"邀请好友") forState:UIControlStateNormal];
    [self.shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:self.shareButton];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mainView.mas_centerX);
        make.width.mas_offset(150);
        make.height.mas_offset(36);
        make.top.mas_equalTo(self.cedeLabel.mas_bottom).offset(15);
    }];
    
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.textColor = [UIColor whiteColor];
    self.detailLabel.font = [UIFont systemFontOfSize:12];
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    [self.mainView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mainView.mas_centerX);
        make.top.mas_equalTo(self.shareButton.mas_bottom).offset(20);
    }];
    
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.image = [UIImage imageNamed:@"shareIcon.png"];
    [self.mainView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mainView.mas_left).offset(20);
        make.bottom.mas_equalTo(self.mainView.mas_bottom).offset(-50);
        make.width.height.mas_offset(@(35));
    }];
    
    UILabel *iconRightLabel= [[UILabel alloc] init];
    iconRightLabel.text = csnation(@"彩色世界");
    iconRightLabel.textColor = [UIColor whiteColor];
    iconRightLabel.font = [UIFont systemFontOfSize:12];
    iconRightLabel.textAlignment = NSTextAlignmentLeft;
    [self.mainView addSubview:iconRightLabel];
    [iconRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconImageView.mas_centerY);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
    }];
    
    self.iconLabel= [[UILabel alloc] init];
    self.iconLabel.numberOfLines = 0;
    self.iconLabel.text = csnation(@"邀请您加入，长按识别二维码");
    self.iconLabel.textColor = [UIColor whiteColor];
    self.iconLabel.font = [UIFont systemFontOfSize:12];
    self.iconLabel.textAlignment = NSTextAlignmentLeft;
    [self.mainView addSubview:self.iconLabel];
    [self.iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.iconImageView);
    }];
    
    self.codeImageView = [[UIImageView alloc] init];
    self.codeImageView.layer.masksToBounds = YES;
    self.codeImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.mainView addSubview:self.codeImageView];
    [self.codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mainView.mas_bottom).offset(-20);
        make.right.mas_equalTo(self.mainView.mas_right).offset(-20);
        make.width.height.mas_offset(80);
    }];
    
    [self makeData];
    
}

- (void)makeData{
    [[CSNewMineNetManage sharedManager] getShareInforComplete:^(CSNetResponseModel * _Nonnull response) {
        if (response.code == 200) {
            NSDictionary  *dict =response.data;
            self.detailLabel.text = dict[@"share_text"];
            NSDictionary *user=dict[@"user"];
            [self.codeImageView sd_setImageWithURL:user[@"spread_qrcode"]];
            
        }
        
    } Complete:^(NSError * _Nonnull error) {
        
    }];
}
- (void)show{
    [self getMaskConfig].maskColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    [super show];
}

- (void)shareButtonClick{
    self.shareView = [[CSShareView alloc]init];
    [self.shareView getMaskConfig].tapToDismiss = YES;
   [self saveqrcodeImage];
    
    
}

-  (void)saveqrcodeImage{
    
    //self.currentModel = [[CSShareModel alloc] init];
//    NSString *urlString = [NSString stringWithFormat:@"%@%@",[CSAPPConfigManager sharedConfig].baseURL,@"/system/images/qrcode.jpeg"];
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:urlString]];
    UIImage *image = [self makeImageWithView:self.mainView withSize:self.mainView.size];// 取得图片
    //self.currentModel.shareImage = image;
    [CSShareManager shared].qcodeImage = image;
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *imageFilePath = [path stringByAppendingPathComponent:@"qrcode"];
    BOOL success = [UIImageJPEGRepresentation(image, 0.5) writeToFile:imageFilePath  atomically:YES];
    if (success){
        NSLog(@"写入本地成功");
        [self.shareView show];
    }
}
- (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size
{
    
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}
@end
