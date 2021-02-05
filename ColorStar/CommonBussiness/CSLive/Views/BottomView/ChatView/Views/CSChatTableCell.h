//
//  CSChatTableCell.h
//  ColorStar
//
//  Created by gavin on 2020/10/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSChatModel.h"
#import "MLEmojiLabel.h"

@interface CSChatTableCell : UITableViewCell

@property (nonatomic, strong) CSChatModel *model;

@property (nonatomic, copy) void (^didSelectLinkTextOperationBlock)(NSString *link, MLEmojiLabelLinkType type);


@end


