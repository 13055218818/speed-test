//
//  CSChatModel.h
//  ColorStar
//
//  Created by gavin on 2020/10/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    CSMessageTypeSendToOthers,
    CSMessageTypeSendToMe
} CSMessageType;

@interface CSChatModel : NSObject

@property (nonatomic, assign) CSMessageType messageType;


@property (nonatomic, copy) NSString    *sendName;
@property (nonatomic, copy) NSAttributedString   * attributeString;
@property (nonatomic, copy) NSString   *iconName;
@property (nonatomic, copy) NSString   *imageName;


@end


