//
//  CSEmptySearchCell.h
//  ColorStar
//
//  Created by gavin on 2020/8/14.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CSResearchBlock)(void);

@interface CSEmptySearchCell : UITableViewCell

@property (nonatomic, copy)CSResearchBlock reSearchBlock;

@end


