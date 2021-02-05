//
//  CSMeVerifyButton.h
//
//  Created by 魏虔坤 on 2020/9/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    CSMeVerifyButtonStateDisNormal,
    CSMeVerifyButtonStateNormal,
    CSMeVerifyButtonStateRun,
} CSMeVerifyButtonState;
@interface CSMeVerifyButton : UIButton

- (void)timeFailBeginFrom:(NSInteger)timeCount;
@property (nonatomic, assign)CSMeVerifyButtonState state;
@end

NS_ASSUME_NONNULL_END
