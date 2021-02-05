//
//  CSSearchItemView.h
//  ColorStar
//
//  Created by 陶涛 on 2020/8/13.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CSSearchItemClick)(NSString * text);

typedef void(^CSSearchItemDelete)(NSString * text);


@interface CSSearchItemView : UIView

@property (nonatomic, strong)NSString * title;

@property (nonatomic, assign)BOOL       showHotIcon;

@property (nonatomic, assign)BOOL       deleteItem;

@property (nonatomic, strong)NSArray  * list;

@property (nonatomic, copy)CSSearchItemClick  searchClick;

@property (nonatomic, copy)CSSearchItemDelete  deleteClick;


@end


