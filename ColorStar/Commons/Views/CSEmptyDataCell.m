//
//  CSEmptyDataCell.m
//  ColorStar
//
//  Created by gavin on 2020/8/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSEmptyDataCell.h"
#import "CSEmptyDataView.h"
#import "UIView+CS.h"

@interface CSEmptyDataCell ()

@property (nonatomic, strong)CSEmptyDataView  * emptyView;

@end

@implementation CSEmptyDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    self.emptyView = [[CSEmptyDataView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height)];
    [self.contentView addSubview:self.emptyView];
    
}

- (void)layoutSubviews{
    self.emptyView.frame = self.contentView.bounds;
    
}

@end
