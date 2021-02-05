//
//  CSShareManager.m
//  ColorStar
//
//  Created by gavin on 2020/12/19.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSShareManager.h"
#import "CSShareView.h"
#import <FBSDKShareKit/FBSDKSharePhoto.h>
#import <FBSDKShareKit/FBSDKSharePhotoContent.h>
#import <FBSDKShareKit/FBSDKShareDialog.h>
#import "CSShareImageView.h"

@interface CSShareManager ()<FBSDKSharingDelegate>
@property (nonatomic, strong)CSShareModel           *currentModel;

@property (nonatomic, strong)CSShareImageView            *shareView;
@end

static CSShareManager  * manager = nil;
@implementation CSShareManager

+ (instancetype)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CSShareManager alloc]init];
    });
    return manager;
}

- (void)showShareView{
    if ([[CSNewLoginUserInfoManager sharedManager] isLogin]) {
        self.shareView = [[CSShareImageView alloc]init];
        [self.shareView getMaskConfig].tapToDismiss = YES;
       // [self saveqrcodeImage];
        [self.shareView show];
    }else{
        [[CSNewLoginUserInfoManager sharedManager] goToLogin:^(BOOL success) {
            
        }];
    }


    
}

- (void)shareMessage:(CSShareModel*)shareModel{
    
    if (shareModel.shareType == CSShareTypeWXCircle || shareModel.shareType == CSShareTypeWXChat) {
        [self shareWX:shareModel];
        
    }else if (shareModel.shareType == CSShareTypeFB) {
        
        [self shareFB:shareModel];
    }
    
}
-  (void)saveqrcodeImage{
    self.currentModel = [[CSShareModel alloc] init];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[CSAPPConfigManager sharedConfig].baseURL,@"/system/images/qrcode.jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:urlString]];
    UIImage *image = [UIImage imageWithData:data]; // 取得图片
    self.currentModel.shareImage = image;
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *imageFilePath = [path stringByAppendingPathComponent:@"qrcode"];
    BOOL success = [UIImageJPEGRepresentation(image, 0.5) writeToFile:imageFilePath  atomically:YES];
    if (success){
        NSLog(@"写入本地成功");
    }
}

- (void)shareWX:(CSShareModel*)model{
    model.shareImage =self.qcodeImage; //[UIImage imageNamed:@"qrcode.jpeg"];
    NSData * imageData = UIImageJPEGRepresentation(model.shareImage, 0.7);
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = imageData;
    
    WXMediaMessage *message = [WXMediaMessage message];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"qrcode"
                                                         ofType:@"jepg"];
    message.thumbData = [NSData dataWithContentsOfFile:filePath];
    message.mediaObject = imageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.scene = model.shareType == CSShareTypeWXCircle ? WXSceneTimeline : WXSceneSession;
    req.message = message;
    [WXApi sendReq:req completion:^(BOOL success) {
        if (success) {
            //[self.shareView cs_doDismiss];
        }
    }];
}

- (void)shareFB:(CSShareModel*)model{
    model.shareImage = self.qcodeImage;//[UIImage imageNamed:@"qrcode.jpeg"];
    FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
    photo.image = model.shareImage;
    photo.userGenerated = YES;
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    content.photos = @[photo];
    
    [FBSDKShareDialog showFromViewController:[UIViewController currentViewController] withContent:content delegate:self];

}

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results{
    NSLog(@"--results:%@",results);
    
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error{
    NSLog(@"--error");
    
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer{
    NSLog(@"--cancel");
}
@end
