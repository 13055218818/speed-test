//
//  CSNewArtorBriefCell.h
//  ColorStar
//
//  Created by 陶涛 on 2020/11/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseTableCell.h"



typedef void(^CSTutorBriefBlock)(void);

@interface CSTutorBriefCell : CSBaseTableCell

@property (nonatomic, strong)CSTutorBriefBlock  briefBlock;

@end


