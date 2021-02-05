//
//  CSTutorLiveMessageModel.h
//  ColorStar
//
//  Created by gavin on 2020/11/21.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseModel.h"

@interface CSTutorLiveMessageModel : CSBaseModel

@property (nonatomic, strong)NSString * name;

@property (nonatomic, strong)NSString * message;

@property (nonatomic, assign)CGFloat  cellHeight;

@property (nonatomic, strong)NSString * messageShow;

@property (nonatomic, strong)NSMutableAttributedString  * attributeMessage;

@end


