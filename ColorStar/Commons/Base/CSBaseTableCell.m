//
//  CSBaseTableCell.m
//  ColorStar
//
//  Created by gavin on 2020/9/25.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseTableCell.h"

@implementation CSBaseTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

+ (NSString*)reuserIndentifier{
    return [NSString stringWithFormat:@"CSCollectionReuseIdentifier_%@",NSStringFromClass([self class])];
}

- (CGFloat)tableViewCellHeight{
    return 0;
}

- (void)mockData{
    
}

- (void)configModel:(id)model{
    
}
@end
