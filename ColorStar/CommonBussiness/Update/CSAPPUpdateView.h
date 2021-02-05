//
//  CSAPPUpdateView.h
//  ColorStar
//
//  Created by gavin on 2020/10/14.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSAPPUpdateView : UIView

- (instancetype)initWithFrame:(CGRect)frame updateNote:(NSString*)updateNote;
@property (nonatomic, assign)BOOL   isUpdate;
@property (nonatomic, strong)NSURL * downURL;
@end


