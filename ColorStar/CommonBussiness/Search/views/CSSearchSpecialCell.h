//
//  CSSearchSpecialCell.h
//  ColorStar
//
//  Created by gavin on 2020/11/27.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseTableCell.h"

typedef void(^CSSearchSpecialBlock)(BOOL follow);

@interface CSSearchSpecialCell : CSBaseTableCell

@property (nonatomic, copy)CSSearchSpecialBlock specialBlock;


@end


