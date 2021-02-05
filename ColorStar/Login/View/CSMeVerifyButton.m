//
//  PESM_MeVerifyButton.m
//  PayExpenseServeMe
//
//  Created by 魏虔坤 on 2020/9/7.
//

#import "CSMeVerifyButton.h"
@interface CSMeVerifyButton ()
/*
 * 定时器
 */
@property(strong,nonatomic) NSTimer *timer;

/*
 * 定时多少秒
 */
@property(assign,nonatomic) NSInteger count;
@end
@implementation CSMeVerifyButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 配置
        [self setup];
        
    }
    
    return self;
}

#pragma mark - 配置


- (void)setup{
    
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:9.f];
    
    [self.layer setBorderWidth:1];
    self.layer.borderColor = [UIColor colorWithHexString:@"#444548"].CGColor;
    self.layer.cornerRadius = 6.0f;
    self.layer.masksToBounds = YES;
    
}
#pragma mark - 添加定时器
- (void)timeFailBeginFrom:(NSInteger)timeCount{
    self.count = timeCount;
    self.enabled = NO;
    // 加1个定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeDown) userInfo: nil repeats:YES];
    
    
}

#pragma mark - 定时器事件
- (void)timeDown{
    if (self.count != 1){
        
        self.count -=1;
        self.enabled = NO;
        [self setTitle:[NSString stringWithFormat:@"%lds", self.count] forState:UIControlStateNormal];
        self.state = CSMeVerifyButtonStateDisNormal;
    } else {
        
        self.enabled = YES;
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.state = CSMeVerifyButtonStateNormal;
        [self.timer invalidate];
    }
}


- (void)setState:(CSMeVerifyButtonState)state{
    if (state == CSMeVerifyButtonStateNormal) {
        [self setTitleColor:[UIColor colorWithHexString:@"#ACACAC"] forState:UIControlStateNormal];
        self.layer.borderColor = [UIColor colorWithHexString:@"#444548"].CGColor;
    }else if (state == CSMeVerifyButtonStateDisNormal){
        [self setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        self.layer.borderColor = [UIColor colorWithHexString:@"#444548"].CGColor;
    }else{
        [self setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        self.layer.borderColor = [UIColor colorWithHexString:@"#444548"].CGColor;
    }
}



@end
