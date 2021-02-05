//
//  CSHomeTopicHeaderReusableView.h
//  ColorStar
//
//  Created by gavin on 2020/8/5.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSHomeTopicSectionModel.h"

typedef void(^CSHomeHeaderCheckMoreClick)(CSHomeTopicSectionModel * sectionModel);

@interface CSHomeTopicHeaderReusableView : UICollectionReusableView

@property (nonatomic, strong)CSHomeTopicSectionModel * sectionModel;

@property (nonatomic, copy)CSHomeHeaderCheckMoreClick  checkMore;

@end


