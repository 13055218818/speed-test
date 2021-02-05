//
//  CSHomeBaseTopiceCell.h
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSHomeTopicBaseModel.h"
#import <YYLabel.h>


NS_ASSUME_NONNULL_BEGIN

@interface CSHomeBaseTopiceCell : UICollectionViewCell

@property (nonatomic, strong)CSHomeTopicBaseModel  * baseModel;

@property (nonatomic, strong)UIView      * containerView;

@property (nonatomic, strong)UIImageView * thumbnailImageView;

@property (nonatomic, strong)UILabel     * titleLabel;

@property (nonatomic, strong)UILabel     * authorLabel;

@property (nonatomic, strong)UILabel     * priceLabel;

@property (nonatomic, strong)UIView      * separtLine;

@property (nonatomic, strong)UILabel     * courceLabel;

@property (nonatomic, strong)UILabel     * studyLabel;

@property (nonatomic, strong)YYLabel     * typeLabel1;

@property (nonatomic, strong)YYLabel     * typeLabel2;

- (void)setupViews;

- (void)setupConstraint;

- (void)configurModel:(CSHomeTopicBaseModel*)model;

@end

NS_ASSUME_NONNULL_END
