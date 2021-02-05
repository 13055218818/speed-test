//
//  CSPersonModifyViewController.m
//  ColorStar
//
//  Created by gavin on 2020/12/19.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSPersonModifyViewController.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import "AFHTTPSessionManager.h"
#import "CSPersonModifyManager.h"
#import "CSNetResponseModel.h"
#import "CSNewMineNetManage.h"

@interface CSPersonModifyViewController ()<UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong)UIButton  * backBtn;

@property (nonatomic, strong)UILabel   * titleLabel;

@property (nonatomic, strong)UIImageView * portraitImageView;

@property (nonatomic, strong)UIButton   * modifyBtn;

@property (nonatomic, strong)UIView     *firstLine;

@property (nonatomic, strong)UILabel    *nickLabel;

@property (nonatomic, strong)UITextField *nickTextField;

@property (nonatomic, strong)UIImageView * arrowImageView;

@property (nonatomic, strong)UIView     *secondLine;

@property (nonatomic, strong)UILabel     * phoneTitleLabel;

@property (nonatomic, strong)UILabel     * phoneLabel;

@property (nonatomic, strong)UILabel    *codeLabel;

@property (nonatomic, strong)UITextField *codeTextField;
@end

@implementation CSPersonModifyViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
    
}

- (void)setupViews{
    self.portraitImageView.userInteractionEnabled = YES;
    self.codeLabel.hidden = YES;
    self.codeTextField.hidden = YES;
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.portraitImageView];
    [self.view addSubview:self.modifyBtn];
    [self.view addSubview:self.firstLine];
    [self.view addSubview:self.nickLabel];
    [self.view addSubview:self.nickTextField];
    [self.view addSubview:self.arrowImageView];
    [self.view addSubview:self.secondLine];
    [self.view addSubview:self.phoneTitleLabel];
    [self.view addSubview:self.phoneLabel];
    [self.view addSubview:self.codeLabel];
    [self.view addSubview:self.codeTextField];
    [self updateUIConstraints];
    
    CSNewLoginModel * userInfo = [CSNewLoginUserInfoManager sharedManager].userInfo;
    if ([userInfo.spread_uid isEqualToString:@"0"]) {
        self.codeLabel.hidden = NO;
        self.codeTextField.hidden = NO;
    }else{
        self.codeLabel.hidden = YES;
        self.codeTextField.hidden = YES;
    }
    if (userInfo) {
        if (![NSString isNilOrEmpty:userInfo.avatar]) {
            NSString *headImage = userInfo.avatar;
            if (![headImage hasPrefix:@"http"]) {
                headImage = [NSString stringWithFormat:@"%@%@",[CSAPPConfigManager sharedConfig].baseURL,userInfo.avatar];
            }
                   
            [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:headImage] placeholderImage:LoadImage(@"CSNewMyDefultImage")];

        }
        
        self.nickTextField.text = userInfo.nickname;
        self.phoneLabel.text = userInfo.phone;
    }
    
    
}

- (void)updateUIConstraints{
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view.mas_top).offset(kStatusBarHeight + 22);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.left.mas_equalTo(self.view);
        make.width.height.mas_equalTo(26);
    }];
    
    [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.view).offset(kNavigationHeight + 22);
        make.width.height.mas_equalTo(82);
    }];
    
    [self.modifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.portraitImageView.mas_bottom).offset(14);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.modifyBtn.mas_bottom).offset(30);
        make.left.mas_equalTo(12);
        make.width.mas_equalTo(60);
    }];
    
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.codeLabel);
        make.left.mas_equalTo(self.codeLabel.mas_right).offset(5);
        make.right.mas_equalTo(-60);
        make.height.mas_equalTo(30);
    }];
    
    [self.firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(self.codeTextField.mas_bottom);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
    }];
    
    [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.firstLine).offset(14);
        make.left.mas_equalTo(12);
        make.width.mas_equalTo(60);
    }];
    
    [self.nickTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nickLabel);
        make.left.mas_equalTo(self.nickLabel.mas_right).offset(5);
        make.right.mas_equalTo(-60);
        make.height.mas_equalTo(30);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nickTextField);
        make.right.mas_equalTo(-12);
        make.width.height.mas_equalTo(20);
    }];
    
    [self.secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(self.nickLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
    }];
    
    [self.phoneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.secondLine).offset(15);
        make.left.mas_equalTo(12);
        
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.phoneTitleLabel);
        make.right.mas_equalTo(-12);
    }];
    
    
}

- (void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//更换头像
- (void)changeUserIconAction{
    //底部弹出来个actionSheet来选择拍照或者相册选择
    UIAlertController *userIconActionSheet = [UIAlertController alertControllerWithTitle:csnation(@"请选择上传类型") message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //相册选择
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:csnation(@"手机相册选择") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        //这里加一个判断，是否是来自图片库
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.delegate = self;            //协议
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }];
    //系统相机拍照
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:csnation(@"相机") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       // WKLog(@"相机选择");
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
               UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:csnation(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //取消
       // WKLog(@"取消");
    }];
    [userIconActionSheet addAction:albumAction];
    [userIconActionSheet addAction:photoAction];
    [userIconActionSheet addAction:cancelAction];
    [self presentViewController:userIconActionSheet animated:YES completion:nil];
}

- (void)modifyClick{
    [self changeUserIconAction];
    
}

#pragma mark - UITextFieldDelegate Method

- (void)textFieldDidEndEditing:(UITextField *)textField{
    CS_Weakify(self, weakSelf);
    if (textField == self.codeTextField) {
        [self showProgressHUD];
        [[CSNewLoginNetManager sharedManager] getUserInviteCodeWith:textField.text Complete:^(CSNetResponseModel * _Nonnull response) {
            [weakSelf hideProgressHUD];
            if (response.code == 200) {
                [csnation(@"绑定成功") showAlert];
            }
        } failureComplete:^(NSError * _Nonnull error) {
            
        }];
    }else if(textField == self.nickTextField){
        [self showProgressHUD];
        [[CSPersonModifyManager shared] modifyName:textField.text complete:^(CSNetResponseModel *response, NSError *error) {
            [weakSelf hideProgressHUD];
            if (response.code == 200) {
                [CSNewLoginUserInfoManager sharedManager].userInfo.nickname = textField.text;
                [csnation(@"修改成功") showAlert];
            }
                
        }];
    }


    
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return textField.text.length > 0;
}

#pragma mark - getter method

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = kFont(16.0f);
        _titleLabel.text = csnation(@"编辑信息");
    }
    return _titleLabel;
}

- (UIButton*)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:LoadImage(@"cs_tutor_player_icon_back") forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIImageView*)portraitImageView{
    if (!_portraitImageView) {
        _portraitImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _portraitImageView.contentMode = UIViewContentModeScaleAspectFill;
        _portraitImageView.layer.masksToBounds = YES;
        _portraitImageView.layer.cornerRadius = 41;
        
        //头像
        UITapGestureRecognizer *changeUserIconTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeUserIconAction)];
        [_portraitImageView addGestureRecognizer:changeUserIconTap];
    }
    return _portraitImageView;
}

- (UIButton*)modifyBtn{
    if (!_modifyBtn) {
        _modifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_modifyBtn setTitle:csnation(@"更改头像") forState:UIControlStateNormal];
        [_modifyBtn setTitleColor:LoadColor(@"#D7B393") forState:UIControlStateNormal];
        [_modifyBtn addTarget:self action:@selector(modifyClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _modifyBtn;
}

- (UIView*)firstLine{
    if (!_firstLine) {
        _firstLine = [[UIView alloc]initWithFrame:CGRectZero];
        _firstLine.backgroundColor = LoadColor(@"#324267");
    }
    return _firstLine;
}

- (UILabel*)nickLabel{
    if (!_nickLabel) {
        _nickLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _nickLabel.textColor = LoadColor(@"#B6B6B6");
        _nickLabel.font = kFont(13.0f);
        _nickLabel.text = csnation(@"昵称：");
    }
    return _nickLabel;
}

- (UITextField*)nickTextField{
    if (!_nickTextField) {
        _nickTextField = [[UITextField alloc]initWithFrame:CGRectZero];
        _nickTextField.delegate = self;
        _nickTextField.font = LoadFont(13.0f);
        _nickTextField.textColor = [UIColor whiteColor];
    }
    return _nickTextField;
}

- (UILabel*)codeLabel{
    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _codeLabel.textColor = LoadColor(@"#B6B6B6");
        _codeLabel.font = kFont(13.0f);
        _codeLabel.text = csnation(@"邀请码：");
    }
    return _codeLabel;
}

- (UITextField*)codeTextField{
    if (!_codeTextField) {
        _codeTextField = [[UITextField alloc]initWithFrame:CGRectZero];
        _codeTextField.delegate = self;
        _codeTextField.font = LoadFont(13.0f);
        _codeTextField.textColor = [UIColor whiteColor];
        _codeTextField.placeholder = csnation(@"请输入邀请码");
    }
    return _codeTextField;
}

- (UIImageView*)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
        _arrowImageView.image = LoadImage(@"cs_home_arrow_right");
    }
    return _arrowImageView;
}



- (UIView*)secondLine{
    if (!_secondLine) {
        _secondLine = [[UIView alloc]initWithFrame:CGRectZero];
        _secondLine.backgroundColor = LoadColor(@"#324267");
    }
    return _secondLine;
}

- (UILabel*)phoneTitleLabel{
    if (!_phoneTitleLabel) {
        _phoneTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _phoneTitleLabel.textColor = LoadColor(@"#B6B6B6");
        _phoneTitleLabel.font = kFont(13.0f);
        _phoneTitleLabel.text = csnation(@"手机号");
    }
    return _phoneTitleLabel;
}

- (UILabel*)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _phoneLabel.textColor = [UIColor whiteColor];
        _phoneLabel.font = kFont(13.0f);
    }
    return _phoneLabel;
}

#pragma mark 调用系统相册及拍照功能实现方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];//获取到所选择的照片
    self.portraitImageView.image = img;
    UIImage *compressImg = [self imageWithImageSimple:img scaledToSize:CGSizeMake(160, 160)];//对选取的图片进行大小上的压缩
    [self transportImgToServerWithImg:compressImg]; //将裁剪后的图片上传至服务器
   // [self saveWith:compressImg];
    [self dismissViewControllerAnimated:YES completion:nil];

}

//用户取消选取时调用,可以用来做一些事情
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//压缩图片方法
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//上传图片至服务器后台
- (void)transportImgToServerWithImg:(UIImage *)img{
   // img = [UIImage imageNamed:@"直播封面图片备份"];
    NSData *imageData;
    NSString *mimetype;
  //判断下图片是什么格式
    if (UIImagePNGRepresentation(img) != nil) {
        mimetype = @"image/png";
        imageData = UIImagePNGRepresentation(img);
    }else{
        mimetype = @"image/jpeg";
        imageData = UIImageJPEGRepresentation(img, 1.0);
    }
   // NSString *data = [[NSString alloc]initWithData:imageData encoding:NSUTF8StringEncoding];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[CSAPPConfigManager sharedConfig].baseURL,@"/wap/My/jsondata/api/uploadAvatar"];
    NSDictionary *params = @{@"token":[CSAPPConfigManager sharedConfig].sessionKey,@"file":[imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed]};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json", @"text/javascript,multipart/form-data", nil];

    [manager POST:urlString parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *str = @"file";
        NSString *fileName = [[NSString alloc] init];
        if (UIImagePNGRepresentation(img) != nil) {
            fileName = [NSString stringWithFormat:@"%@.png", str];
        }else{
            fileName = [NSString stringWithFormat:@"%@.jpg", str];
        }

        [formData appendPartWithFileData:imageData name:str fileName:fileName mimeType:mimetype];
    } progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //打印看下返回的是什么东西
        NSDictionary  *data = responseObject;
        CSNetResponseModel *model = [CSNetResponseModel yy_modelWithDictionary:data];
        NSDictionary  *dataDict = model.data;
        [CSNewLoginUserInfoManager sharedManager].userInfo.avatar = dataDict[@"url"];
//        NSString *headImage = [NSString stringWithFormat:@"%@%@",[CSAPPConfigManager sharedConfig].baseURL,self.currentUserInfo.avatar];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}


@end
