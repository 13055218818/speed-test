//
//  CSGuideViewController.h
//  ColorStar
//
//  Created by 陶涛 on 2020/8/13.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseViewController.h"

typedef void(^CSGuideComplete)(BOOL complete);

@interface CSGuideViewController : CSBaseViewController

@property (nonatomic, strong)CSGuideComplete complete;

@end


