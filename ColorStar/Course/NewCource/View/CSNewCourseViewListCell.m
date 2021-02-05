//
//  CSNewCourseViewListCell.m
//  ColorStar
//
//  Created by apple on 2020/11/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewCourseViewListCell.h"
@interface CSNewCourseViewListCell()
@property (nonatomic, strong)UIImageView        *bgImageView;
@property (nonatomic, strong)UILabel            *titleLabel;
@property (nonatomic, strong)UILabel            *nameLabel;
@property (nonatomic, strong)UILabel            *timeLabel;
@end
@implementation CSNewCourseViewListCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
        ViewRadius(self, 5);
        [self makeUI];
    }
    return self;
}
-(void)makeUI{
    UIView *view = [[UIView alloc] init];
    [self.contentView addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(@(100));
        make.left.right.top.bottom.mas_equalTo(self.contentView);
    }];
    
    self.bgImageView = [UIImageView new];
    self.bgImageView.clipsToBounds = YES;
    self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
//    self.bgImageView.image = [UIImage imageNamed:@"cs_home_banner"];
    [view addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(view);
    }];
    
    self.statuImageView = [UIImageView new];
   // self.statuImageView.image = [UIImage imageNamed:@"CSNewCourseViewListTOP1.png"];
    [view addSubview:self.statuImageView];
    [self.statuImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view.mas_top);
        make.right.mas_equalTo(view.mas_right).offset(-widthScale*4.5);
        make.width.mas_offset(@(35));
        make.height.mas_offset(@(17));
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    //self.nameLabel.text = NSLocalizedString(@"魏巡",nil);
    self.nameLabel.font = [UIFont boldSystemFontOfSize:10];
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).offset(12*widthScale);
        make.bottom.mas_equalTo(view.mas_bottom).offset(-9*heightScale);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    //self.titleLabel.text = NSLocalizedString(@"演唱技巧",nil);
    self.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).offset(12*widthScale);
        make.bottom.mas_equalTo(self.nameLabel.mas_top).offset(-9*heightScale);
        make.right.mas_equalTo(view.mas_right).offset(-2*widthScale);
    }];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.backgroundColor = [UIColor colorWithHexString:@"#DDB984"];
    self.timeLabel.text = NSLocalizedString(@"08:10",nil);
    self.timeLabel.font = kFont(9);
    self.timeLabel.textColor = [UIColor colorWithHexString:@"#181F30"];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
//        ViewRadius(self.timeLabel, 3);
    [view addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(view.mas_right).offset(-5*heightScale);
        make.centerY.mas_equalTo(self.nameLabel.mas_centerY);
        make.width.mas_offset(@(40));
        make.height.mas_offset(@(15));
    }];
    [self.timeLabel layoutIfNeeded];
    [[CSTotalTool sharedInstance] setPartRoundWithView:self.timeLabel corners:UIRectCornerTopRight cornerRadius:8.0];
    
    
    
}

- (void)setModel:(CSNewCourseModel *)model{
    _model = model;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"CSNewListBgDefaault.png"]];
    self.nameLabel.text = model.title;
    self.titleLabel.text = model.subject_name;
    self.timeLabel.text = model.browse_count;
    
}

- (CGFloat)getButtonWidth:(NSString *)str WithFont:(CGFloat)font{
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]}];
    CGSize statuseStrSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
    
    CGFloat labWith =statuseStrSize.width +20;
    return labWith;
}
//-(UICollectionViewLayoutAttributes *) preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes { [super preferredLayoutAttributesFittingAttributes:layoutAttributes]; UICollectionViewLayoutAttributes *attributes = [layoutAttributes copy]; attributes.size = CGSizeMake((ScreenW-40*widthScale)/3, (ScreenW-40*widthScale)/3);
//    return attributes;
//}

@end
