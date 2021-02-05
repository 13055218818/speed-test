//
//  CSBaseTableCell.h
//  ColorStar
//
//  Created by gavin on 2020/9/25.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CSBaseTableCell : UITableViewCell

+ (NSString*)reuserIndentifier;

- (CGFloat)tableViewCellHeight;

- (void)mockData;

- (void)configModel:(id)model;

@end


