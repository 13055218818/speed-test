//
//  CSCalendarRedPointInfo.h
//  ColorStar
//
//  Created by gavin on 2020/11/30.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseModel.h"

@interface CSCalendarRedPointInfoModel : CSBaseModel

@property (nonatomic, strong)NSString  * date;

@property (nonatomic, assign)BOOL        is_show;

@end

@interface CSCalendarRedPointInfo : CSBaseModel

@property (nonatomic, strong)NSArray * list;

@end


