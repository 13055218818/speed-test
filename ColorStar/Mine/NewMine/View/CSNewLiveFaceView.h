//
//  CSNewLiveFaceView.h
//  ColorStar
//
//  Created by apple on 2021/1/13.
//  Copyright © 2021 gavin. All rights reserved.
//

#import "CSBasePopupView.h"
#import "QiSlider.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^CSNewLiveFaceViewDissClickBlock)(BOOL isDiss);
@protocol CSNewLiveFaceViewDelegate <NSObject>
- (void)CSNewLiveFaceView1SelectDefinition:(NSInteger)index;
- (void)CSNewLiveFaceView2SelectDefinition:(NSInteger)index;
@end

@interface CSNewLiveFaceView : CSBasePopupView
@property (nonatomic, strong) QiSlider *smoothSlider;
@property (nonatomic, strong) QiSlider *WhiteningSlider;
@property (nonatomic, strong) QiSlider *adjustExposureSlider;
@property(nonatomic,weak)id<CSNewLiveFaceViewDelegate> delegate;
- (void)refreshFaceView1:(NSInteger)index;
- (void)refreshFaceView2:(NSInteger)index;
@property (nonatomic, copy)CSNewLiveFaceViewDissClickBlock clickBlock;
@end

NS_ASSUME_NONNULL_END
