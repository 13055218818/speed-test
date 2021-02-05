//
//  CSHomeActorIconCell.h
//  ColorStar
//
//  Created by gavin on 2020/8/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSHomeActorIconModel.h"

typedef void(^CSHomeActorItemClick)(CSHomeActorIconModel * model);
@interface CSHomeActorIconCell : UICollectionViewCell

@property (nonatomic,copy)CSHomeActorItemClick  itemClick;

- (void)configModels:(NSArray*)models;

@end


