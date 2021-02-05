//
//  UILabel+CS.h
//  ColorStar
//
//  Created by gavin on 2020/8/5.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (CS)

@property (nonatomic, assign) UIEdgeInsets ymm_contentInsets;

#pragma mark - AttributedString
- (void)setLabelAttributedText:(NSMutableDictionary *)dict;

- (void)setLabelMutilAttributed:(NSString *)allText optionArray:(NSMutableArray *)array;
- (void)setLabelAttributedBySameText:(NSMutableDictionary *)dict withExeceptString:(NSString *)exceptString;

// 设置UILabel行间距
- (void)setLabelLineSpacing:(CGFloat)lineSpace;

- (void)setLabelLineSpacingWithOption:(NSDictionary *)optionDict;

@end

NS_ASSUME_NONNULL_END
