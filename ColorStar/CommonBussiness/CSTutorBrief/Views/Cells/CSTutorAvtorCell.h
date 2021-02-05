//
//  CSNewArtorIntroCell.h
//  ColorStar
//
//  Created by 陶涛 on 2020/11/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseTableCell.h"

typedef void(^CSTutorAvtorBlock)(void);

@interface CSTutorAvtorCell : CSBaseTableCell

@property (nonatomic, copy)CSTutorAvtorBlock  avtorBlock;


@end


