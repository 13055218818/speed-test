//
//  CSSearchReultModel.h
//  ColorStar
//
//  Created by gavin on 2020/8/15.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseModel.h"

/**
 "browse_count": 663,浏览量(热度) <number>
 "is_pink": 0,... <number>
 "pink_money": "0.00",... <string>
 -"label": [标签<array>
 "吉他大师"
 ],
 "id": 13,... <number>
 "title": "Larry Carlton",标题 <string>
 "abstract": "Larry Carlton，世界著名吉他大师，于1948年3月出生于美国的南加州。作为美国爵士、蓝调、流行音乐和摇滚吉他的顶级大师，Larry Carlton的传奇一生和为音乐的疯狂让他获得8次格莱美提名，4次格莱美大奖，至今参与过的音乐专辑超过500张，是20世纪下半叶的爵士乐坛最杰出的吉他手之一。在larry的音乐旅途上，他曾与世界级吉他手Ritenour合作推出《挚友》并荣获格莱美音乐奖，成为蓝调吉他大师。随后，他开始与不同的世界级艺人合作，包括：传奇布鲁斯大师B.B King，萨克斯演奏家John Coltrane，好莱坞Sammy Davis.Jr，John Coltrane，以及Michael Jackson等。现在的音乐如爵士、布鲁斯、流行和摇滚都烙上了Larry Carlton的印记。",详情 <string>
 "image": "http://cdn.color-star.cn/afbf6202009250943065758.jpg?x-oss-process=image/resize,m_lfit,h_254,w_690",封面图 <string>
 "money": "0.00",... <string>
 "is_follow": 0是否关注 <number>
 */
@interface CSSearchReultModel : CSBaseModel

@property (nonatomic, strong)NSString * is_pink;

@property (nonatomic, strong)NSArray  * label;

@property (nonatomic, strong)NSString * modelId;

@property (nonatomic, strong)NSString * title;

@property (nonatomic, strong)NSString * abstract;

@property (nonatomic, strong)NSString * image;

@property (nonatomic, strong)NSString * money;

@property (nonatomic, strong)NSString * price;

@property (nonatomic, assign)BOOL       is_follow;

@property (nonatomic, assign)NSInteger  browse_count;

@property (nonatomic, strong)NSString * subject_name;
@end


