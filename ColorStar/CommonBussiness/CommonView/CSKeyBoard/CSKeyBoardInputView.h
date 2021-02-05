//
//  CSKeyBoardInputView.h
//  ColorStar
//
//  Created by gavin on 2020/12/4.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CSKeyBoardInputBlock)(NSString * content);

@interface CSKeyBoardInputView : UIView

@property (nonatomic, strong)NSString * placeHolder;

@property (nonatomic, copy)CSKeyBoardInputBlock inputBlock;

@property (nonatomic, assign)NSInteger  maxCount;

- (void)startComment;

- (void)endComment;

@end


