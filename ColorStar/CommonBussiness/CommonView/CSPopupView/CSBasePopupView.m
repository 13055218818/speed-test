//
//  CSBasePopupView.m
//  ColorStar
//
//  Created by gavin on 2020/12/5.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBasePopupView.h"

@interface CSBasePopupView (){
    //是否已移除
    BOOL isDismissed;
    dispatch_once_t loadOnceToken;
}

@property (nonatomic, copy) void(^cs_dismission)(void);

@property (nonatomic, strong) CSPopupMaskConfig *config;
@property (nonatomic) BOOL runStatus;

@property (nonatomic, assign) long long showInteval;


@end

@implementation CSBasePopupView
@synthesize dismissedBlock;

#pragma mark - Get Set Property

-(long long)getDateTimeTOMilliSeconds:(NSDate *)datetime
{
    NSTimeInterval interval = [datetime timeIntervalSince1970];
    
    long long totalMilliseconds = interval*1000 ;
    
    return totalMilliseconds;
}

-(void) setMaskConfig:(CSPopupMaskConfig *)config
{
    self.config = config;
}

-(CSPopupMaskConfig *) getMaskConfig
{
    return self.config;
}

-(CSPopupMaskConfig *) config
{
    if(!_config) {
        _config = [CSPopupMaskConfig new];
    }
    return _config;
}

-(CGFloat) cs_animationDuration
{
    return self.config.animationDuration;
}

-(void) setcs_animationDuration:(CGFloat)cs_animationDuration
{
    self.config.animationDuration = cs_animationDuration;
}

-(void) setcs_tapToDismiss:(BOOL)cs_tapToDismiss
{
    self.config.tapToDismiss = cs_tapToDismiss;
}

-(BOOL) cs_tapToDismiss
{
    return self.config.tapToDismiss;
}

#pragma mark UIResponder Methods

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    if (self.config.tapToDismiss) {
        [self cs_doDismiss];
    }
}

#pragma mark Base Methods

- (void)cs_loadView {
    // do noting in base
}

- (void)cs_maskWillAppear {
    // do noting in base
}

- (void)cs_maskDoAppear {
    // do noting in base
}

- (void)cs_maskDidAppear {
    // do noting in base
}

- (void)cs_maskWillDisappear {
    // do noting in base
}

- (void)cs_maskDoDisappear {
    // do noting in base
}

- (void)cs_maskDidDisappear {
    // do noting in base
    if (self.dismissedBlock) {
        self.dismissedBlock();
    }
}

#pragma mark Property Methods

- (UIView *)cs_contentView {
    
    if (!_cs_contentView) {
        _cs_contentView = [[UIView alloc]init];
        _cs_contentView.frame = self.bounds;
        [self addSubview:_cs_contentView];
    }
    
    return _cs_contentView;
}

-(UIView *) contentView
{
    return self.cs_contentView;
}

#pragma mark Inerface Methods

- (void)cs_showInView:(UIView *)view
          offsetInsets:(UIEdgeInsets)offsetInsets
             maskColor:(UIColor *)maskColor
            completion:(void(^)(void))completion
            dismission:(void(^)(void))dismission {
    
    isDismissed = NO;
    
    self.cs_dismission = dismission;
    
    UIView *currentView = view;
    
    NSArray *tipsAlerts = currentView.subviews;
    BOOL hasTipsAlert = NO;
    for (UIView *subview in tipsAlerts) {
        if ([subview isKindOfClass:[view class]]) {
            
            hasTipsAlert = YES;
            break;
        }
    }
    
    CGRect frame = currentView.bounds;
    frame.origin.x += offsetInsets.left;
    frame.origin.y += offsetInsets.top;
    frame.size.width -= offsetInsets.left+offsetInsets.right;
    frame.size.height -= offsetInsets.top+offsetInsets.bottom;
    
    self.backgroundColor = [UIColor clearColor];
    self.frame = frame;
    self.clipsToBounds = YES;
    
    [currentView addSubview:self];
    dispatch_once(&loadOnceToken, ^{
        [self cs_loadView];
    });
    
    [self cs_maskWillAppear];
    
    
    [UIView animateWithDuration:self.config.animationDuration?self.config.animationDuration:.3f
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        [self cs_maskDoAppear];
        if (hasTipsAlert == NO) {
            self.backgroundColor = maskColor;
        }
        self.cs_contentView.alpha = 1.f;
    }
                     completion:^(BOOL finished) {
        [self cs_maskDidAppear];
        self.showInteval = [self getDateTimeTOMilliSeconds:[NSDate date]];
        if (completion) {
            completion();
        }
    }];
}

-(void) cs_doDismiss:(void (^)(void))dismission
{
    self.cs_dismission =  dismission;
    [self cs_doDismiss];
}

- (void)cs_doDismiss {
    if (isDismissed) {
        return;
    }
    else {
        isDismissed = YES;
    }
    
    [self cs_maskWillDisappear];
    CS_Weakify(self, weakSelf);
    [UIView animateWithDuration:self.config.animationDuration?self.config.animationDuration:.3f
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationCurveEaseInOut
                     animations:^{
        
        [self cs_maskDoDisappear];
        self.backgroundColor = [UIColor clearColor];
        self.cs_contentView.alpha = 0;
    }
                     completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        
        
        if (weakSelf.cs_dismission) {
            weakSelf.cs_dismission();
        }
        [self cs_maskDidDisappear];
    }
     ];
}

-(void) show
{
    CSPopupMaskConfig *config = self.config;
    [self cs_showInView:config.superView
            offsetInsets:config.offsetInsets
               maskColor:config.maskColor
              completion:config.completion
              dismission:config.dismiss];
}




@end
