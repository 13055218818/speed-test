//
//  CSTutorDetailEmptyCell.m
//  ColorStar
//
//  Created by gavin on 2020/12/24.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorDetailEmptyCell.h"

@implementation CSTutorDetailEmptyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = EmptyColor;
    }
    return self;
    

}

@end
