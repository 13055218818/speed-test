//
//  CSTutorLiveMessageCell.m
//  ColorStar
//
//  Created by gavin on 2020/11/21.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorLiveMessageCell.h"

@interface CSTutorLiveMessageCell ()

@property (nonatomic, strong)UIView  * containerView;

@property (nonatomic, strong)UILabel * nameLabel;

@property (nonatomic, strong)UILabel * messageLabel;

@property (nonatomic, strong)CSTutorLiveMessageModel * model;
@end

@implementation CSTutorLiveMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self.contentView addSubview:self.containerView];
//    [self.containerView addSubview:self.nameLabel];
    [self.containerView addSubview:self.messageLabel];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(12);
        make.right.mas_equalTo(self.contentView).offset(-12);
        make.bottom.mas_equalTo(self.contentView).offset(-8);
    }];
    
//    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(10);
//        make.top.mas_equalTo(8);
//        make.bottom.mas_equalTo(-8);
//    }];
    
//    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.nameLabel);
//        make.left.mas_equalTo(self.nameLabel.mas_right);
//    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(8);
        make.bottom.mas_equalTo(-8);
        make.right.mas_equalTo(-10);
    }];
    
}

- (void)mockData{
    self.nameLabel.text = @"喜欢吃香菜：";
    self.messageLabel.text = @"我每天都会定时来看主播的～";
}

- (void)configModel:(id)model{
    if (![model isKindOfClass:[CSTutorLiveMessageModel class]]) {
        return;
    }
    self.model = model;
    
    self.messageLabel.attributedText = self.model.attributeMessage;
    
}

+ (CGFloat)cellHeightForModel:(CSTutorLiveMessageModel*)model{
    
    if (model.cellHeight > 0) {
        return model.cellHeight;
    }
    
    CGSize textSize = [model.messageShow textSizeWithWidth:ScreenW - 44 withFont:kFont(12)];
    model.cellHeight = textSize.height + 24;
    return model.cellHeight;
    
}

#pragma mark - Properties Method

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
        _containerView.backgroundColor = [UIColor colorWithHexString:@"#7C7F82" alpha:0.5];
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.cornerRadius = 6.0f;
    }
    return _containerView;
}

- (UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _nameLabel.textColor = LoadColor(@"#8DE8FF");
        _nameLabel.font = kFont(12.0f);
    }
    return _nameLabel;
}

- (UILabel*)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.font = kFont(12.0f);
    }
    return _messageLabel;
}

@end
