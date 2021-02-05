//
//  CSTotalTool.m
//  ColorStar
//
//  Created by apple on 2020/11/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTotalTool.h"
#import <Accelerate/Accelerate.h>
@interface CSTotalTool()

@end

@implementation CSTotalTool

+ (CSTotalTool *)sharedInstance {
    static CSTotalTool *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[CSTotalTool alloc]init];
    });
    return sharedClient;
}

- (instancetype)init {
    self = [super init];
    if (self) {
    };
    return self;
}

-(CGFloat)getButtonWidth:(NSString *)str WithFont:(CGFloat)font WithLefAndeRightMargin:(CGFloat)margin{
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]}];
    CGSize statuseStrSize = CGSizeMake(ceilf(size.width), ceilf(size.height));

    CGFloat labWith =statuseStrSize.width +2*margin;
    return labWith;
}

- (CAGradientLayer *)makeCAGradientLayerFrame:(CGRect)frame  withStartColor:(UIColor *)starColor withEndColor:(UIColor *)endColor{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)starColor.CGColor, (__bridge id)endColor.CGColor];
    gradientLayer.locations = @[@0.0, @1.0];;
       gradientLayer.startPoint = CGPointMake(0, 0);
       gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame =frame;
    return gradientLayer;
    
}



- (void)setPartRoundWithView:(UIView *)view corners:(UIRectCorner)corners cornerRadius:(float)cornerRadius {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)].CGPath;
    view.layer.mask = shapeLayer;

}

- (void)setCornerWithLeftTopCorner:(CGFloat)leftTop
                    rightTopCorner:(CGFloat)rigtTop
                  bottomLeftCorner:(CGFloat)bottemLeft
                 bottomRightCorner:(CGFloat)bottemRight
                              view:(UIView *)view
                             frame:(CGRect)frame {
    
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPath];
    maskPath.lineWidth = 1.0;
    maskPath.lineCapStyle = kCGLineCapRound;
    maskPath.lineJoinStyle = kCGLineJoinRound;
    [maskPath moveToPoint:CGPointMake(bottemRight, height)]; //左下角
    [maskPath addLineToPoint:CGPointMake(width - bottemRight, height)];
    
    [maskPath addQuadCurveToPoint:CGPointMake(width, height- bottemRight) controlPoint:CGPointMake(width, height)]; //右下角的圆弧
    [maskPath addLineToPoint:CGPointMake(width, rigtTop)]; //右边直线
    
    [maskPath addQuadCurveToPoint:CGPointMake(width - rigtTop, 0) controlPoint:CGPointMake(width, 0)]; //右上角圆弧
    [maskPath addLineToPoint:CGPointMake(leftTop, 0)]; //顶部直线
    
    [maskPath addQuadCurveToPoint:CGPointMake(0, leftTop) controlPoint:CGPointMake(0, 0)]; //左上角圆弧
    [maskPath addLineToPoint:CGPointMake(0, height - bottemLeft)]; //左边直线
    [maskPath addQuadCurveToPoint:CGPointMake(bottemLeft, height) controlPoint:CGPointMake(0, height)]; //左下角圆弧

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = frame;
    maskLayer.path = maskPath.CGPath;
    maskLayer.frame = frame;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur
{
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                       &outBuffer,
                                       NULL,
                                       0,
                                       0,
                                       boxSize,
                                       boxSize,
                                       NULL,
                                       kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}




- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.label.text = hint;
    HUD.detailsLabel.text = hint;
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.bezelView.color = [UIColor clearColor];
    HUD.bezelView.alpha = 0;
    HUD.mode = MBProgressHUDModeCustomView;
    //自定义动画
    UIImageView *gifImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading1"]];
    
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    for (int i = 0; i <8; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%d", i + 1]];
        [arrM addObject:image];
    }
    [gifImageView setAnimationImages:arrM];
    [gifImageView setAnimationDuration:1.5];
    [gifImageView setAnimationRepeatCount:0];
    [gifImageView startAnimating];
    HUD.customView = gifImageView;
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    [view addSubview:HUD];
}

- (void)hidHudInView:(UIView *)view{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
        [hud hideAnimated:YES];
    });
}

+ (UIViewController *)recursiveFindCurrentShowViewControllerFromViewController:(UIViewController *)fromVC

{

    if ([fromVC isKindOfClass:[UINavigationController class]]) {

        return [self recursiveFindCurrentShowViewControllerFromViewController:[((UINavigationController *)fromVC) visibleViewController]];

    } else if ([fromVC isKindOfClass:[UITabBarController class]]) {

        return [self recursiveFindCurrentShowViewControllerFromViewController:[((UITabBarController *)fromVC) selectedViewController]];

    } else {

        if (fromVC.presentedViewController) {

            return [self recursiveFindCurrentShowViewControllerFromViewController:fromVC.presentedViewController];

        } else {

            return fromVC;

        }

    }

}


+ (UIViewController *)getCurrentShowViewController

{

    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;

    UIViewController *currentShowVC = [self recursiveFindCurrentShowViewControllerFromViewController:rootVC];

    return currentShowVC;

}

-(UIColor *)mainColorOfImage:(UIImage *)image with:(BOOL)isMain{

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1

    int bitmapInfo =kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;

#else

   int bitmapInfo = kCGImageAlphaPremultipliedLast;

#endif

   //第一步：先把图片缩小，加快计算速度，但越小结果误差可能越大

    CGSize thumbSize=CGSizeMake(50,50);

    CGColorSpaceRef colorSpace =CGColorSpaceCreateDeviceRGB();

    CGContextRef context =CGBitmapContextCreate(NULL,

                                                 thumbSize.width,

                                                 thumbSize.height,

                                                8,//bits per component

                                                 thumbSize.width*4,

                                                 colorSpace,

                                                 bitmapInfo);

   CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);

   CGContextDrawImage(context, drawRect, image.CGImage);

   CGColorSpaceRelease(colorSpace);

   //第二步：取每个点的像素值

   unsigned char* data =CGBitmapContextGetData (context);

   if (data == NULL)return nil;

   NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];

   for (int x=0; x<thumbSize.width; x++) {

       for (int y=0; y<thumbSize.height; y++) {

           int offset = 4*(x*y);

           int red = data[offset];

           int green = data[offset+1];

           int blue = data[offset+2];

           int alpha =  data[offset+3];



           NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];

            [cls addObject:clr];

        }

    }

    CGContextRelease(context);

   //第三步：找到出现次数最多的那个颜色
   
    if (isMain) {
        
        NSEnumerator *enumerator = [cls objectEnumerator];
        NSArray *curColor = nil;

        NSArray *MaxColor=nil;

        NSUInteger MaxCount=0;

        while ( (curColor = [enumerator nextObject]) != nil ){

            NSUInteger tmpCount = [cls countForObject:curColor];

            if (tmpCount < MaxCount) continue;

             MaxCount=tmpCount;

             MaxColor=curColor;

         }
        return [UIColor colorWithRed:([MaxColor[0]intValue]/255.0f)green:([MaxColor[1]intValue]/255.0f)blue:([MaxColor[2]intValue]/255.0f)alpha:[MaxColor[3]intValue]/255.0f];
    }else{
        NSEnumerator *enumerator = [cls objectEnumerator];
        NSArray *nextCurColor = nil;
        NSArray *nextColor=nil;

        NSUInteger nextCount=0;

        while ( (nextCurColor = [enumerator nextObject]) != nil ){

            NSUInteger nextTemCount = [cls countForObject:nextCurColor];

            if (nextTemCount < nextCount) continue;

            nextCount=nextTemCount;

            nextColor= nextCurColor;

         }
        return [UIColor colorWithRed:([nextColor[0]intValue]/255.0f)green:([nextColor[1]intValue]/255.0f)blue:([nextColor[2]intValue]/255.0f)alpha:[nextColor[3]intValue]/3/255.0f];
    }
}

// 方法调用
- (BOOL)versionCompareFirst:(NSString *)first andVersionSecond:(NSString *)second
{
    NSArray *versions1 = [first componentsSeparatedByString:@"."];
    NSArray *versions2 = [second componentsSeparatedByString:@"."];
    NSMutableArray *ver1Array = [NSMutableArray arrayWithArray:versions1];
    NSMutableArray *ver2Array = [NSMutableArray arrayWithArray:versions2];
    // 确定最大数组
    NSInteger a = (ver1Array.count> ver2Array.count)?ver1Array.count : ver2Array.count;
    // 补成相同位数数组
    if (ver1Array.count < a) {
        for(NSInteger j = ver1Array.count; j < a; j++)
        {
            [ver1Array addObject:@"0"];
        }
    }
    else
    {
        for(NSInteger j = ver2Array.count; j < a; j++)
        {
            [ver2Array addObject:@"0"];
        }
    }
    // 比较版本号
    int result = [self compareArray1:ver1Array andArray2:ver2Array];
    if(result == 1)
    {
        NSLog(@"V1 > V2");
        return YES;
    }
    else if (result == -1)
    {
        NSLog(@"V1 < V2");
        return NO;
    }
    else if (result ==0 )
    {
        NSLog(@"V1 = V2");
        return NO;
    }else{
        return NO;
    }
}
// 比较版本号
- (int)compareArray1:(NSMutableArray *)array1 andArray2:(NSMutableArray *)array2
{
    for (int i = 0; i< array2.count; i++) {
        NSInteger a = [[array1 objectAtIndex:i] integerValue];
        NSInteger b = [[array2 objectAtIndex:i] integerValue];
        if (a > b) {
            return 1;
        }
        else if (a < b)
        {
            return -1;
        }
    }
    return 0;
}

- (NSString *)convertToJsonData:(NSDictionary *)dict{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

@end
