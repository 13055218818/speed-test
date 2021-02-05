//
//  CSAvtorImageView.h
//  ColorStar
//
//  Created by gavin on 2020/11/21.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSAvtorImageView : UIView

@property (nonatomic, strong)UIImage * image;

@property (nonatomic, strong)UIColor * backColor;

@property (nonatomic, assign)CGFloat  innerWH;

- (void)sd_setImage:(NSString*)imageString;
@end


