//
//  CSNetResponseModel.h
//  ColorStar
//
//  Created by gavin on 2020/8/6.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CSNetResponseModel : NSObject

@property (nonatomic, assign)NSInteger code;

@property (nonatomic, assign)NSInteger count;

@property (nonatomic, strong)id        data;

@property (nonatomic, strong)NSString  * msg;

@end


