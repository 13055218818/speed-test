//
//  CSHomeRecommendGuitarCell.m
//  ColorStar
//
//  Created by apple on 2020/11/10.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeRecommendGuitarCell.h"


@interface CSHomeRecommendGuitarCell()
@property (nonatomic, strong)UILabel      *leftLabel;
@property (nonatomic, strong)UILabel      *rightLabel;
@property (nonatomic, strong)UIView       *leftView;
@property (nonatomic, strong)UILabel       *leftTitleLabel;
@property (nonatomic, strong)UILabel       *leftDetailLabel;
@property (nonatomic, strong)UIButton       *leftButton;
@property (nonatomic, strong)UIView       *rightView;
@property (nonatomic, strong)UILabel       *rightTitleLabel;
@property (nonatomic, strong)UILabel       *rightDetailLabel;
@property (nonatomic, strong)UIButton       *rightButton;
@property (nonatomic, strong)NSMutableArray *dataArray;

@end
@implementation CSHomeRecommendGuitarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withArray:(NSMutableArray *)array
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
        self.dataArray = [NSMutableArray array];
        self.dataArray = array;
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.leftLabel = [[UILabel alloc] init];
    self.leftLabel.text = NSLocalizedString(@"精选吉他课",nil);
    self.leftLabel.font = kFont(16);
    self.leftLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.leftLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.leftLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(12*widthScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(16*heightScale);
        
    }];
    
    self.rightLabel = [[UILabel alloc] init];
    self.rightLabel.hidden = YES;
    self.rightLabel.text = NSLocalizedString(@"吉他·在线",nil);
    self.rightLabel.font = kFont(9);
    self.rightLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.rightLabel.textAlignment = NSTextAlignmentCenter;
    ViewRadius(self.rightLabel, 3);
    self.rightLabel.backgroundColor = [UIColor colorWithHexString:@"#EDEDED" alpha:0.2];
    [self.contentView addSubview:self.rightLabel];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-12*widthScale);
        make.centerY.mas_equalTo(self.leftLabel.mas_centerY);
        make.width.mas_offset(@(51*heightScale));
        make.height.mas_offset(@(17*heightScale));
        
    }];
    [self makeViedoView:self.dataArray];
 
}

-(void)makeViedoView:(NSMutableArray  *)listArray{
    CGFloat viewWidth =(ScreenW-2*12*widthScale-5*widthScale)/2.0;
    for (NSInteger i =0 ; i<listArray.count; i ++) {
        CSNewHomeRecommendGuitarListModel *moedl = self.dataArray[i];
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
        [self.contentView addSubview:view];
        view.frame = CGRectMake(12*widthScale + i%2 *(viewWidth +5*widthScale), 52*heightScale +i/2*157*heightScale, viewWidth, 157*heightScale);
        [self.contentView addSubview:view];
        
        UIImageView *playView = [[UIImageView alloc] init];
        [playView sd_setImageWithURL:[NSURL URLWithString:moedl.image] placeholderImage:[UIImage imageNamed:@"CSNewHeadplaceholderImage.png"]];
        [view addSubview:playView];
        
        [playView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(view);
            make.height.mas_offset(@(106*heightScale));
        }];
        
        UIButton *playButton = [[UIButton alloc] init];
        playButton.tag = i;
        [playButton setImage:[UIImage imageNamed:@"CSNewHomeRecommendPlay.png"] forState:UIControlStateNormal];
        [playButton addTarget:self action:@selector(guitarPlayClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:playButton];
        [playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(view);
            make.height.mas_offset(@(106*heightScale));
        }];
        
        
        UILabel  *titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 1;
        titleLabel.text = moedl.title;//NSLocalizedString(@"Mike McLaughlin",nil);
        titleLabel.font = kFont(12);
        titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(playView.mas_centerX);
            make.top.mas_equalTo(playView.mas_bottom).offset(4*heightScale);
            make.width.mas_equalTo(playView.mas_width);
        }];
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.numberOfLines = 1;
        detailLabel.text = moedl.detail_short;//NSLocalizedString(@"在线教你如何把玩吉他·快来吧～",nil);
        detailLabel.font = kFont(12);
        detailLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        detailLabel.textAlignment = NSTextAlignmentLeft;
        [view addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(playView.mas_centerX);
            make.top.mas_equalTo(titleLabel.mas_bottom).offset(2*heightScale);
            make.width.mas_equalTo(playView.mas_width);
        }];
    }
    CGFloat rowHeight = 52*heightScale;
    if (listArray.count%2 == 0) {
        rowHeight = 157*heightScale *listArray.count/2 + 52*heightScale;
    }else{
        rowHeight = 157*heightScale *(listArray.count/2+1) + 52*heightScale;
    }
    self.leftButton = [[UIButton alloc] init];
    self.leftButton.hidden = YES;
    self.leftButton.titleLabel.font = kFont(12);
    [self.leftButton setTitle:NSLocalizedString(@"更多吉他课",nil) forState:UIControlStateNormal];
    [self.leftButton setImage:[UIImage imageNamed:@"CSHomeRecommendGuitarLeftPlay.png"] forState:UIControlStateNormal];
    ViewRadius(self.leftButton, 6);
    [self.leftButton setBackgroundColor:[UIColor colorWithHexString:@"#EDEDED" alpha:0.3]];
    [self.leftButton addTarget:self action:@selector(attentionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.leftButton];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(12*heightScale);
        make.width.mas_offset(@(viewWidth));
        make.height.mas_offset(@(24*heightScale));
        make.top.mas_equalTo(self.contentView.mas_top).offset(rowHeight +16*heightScale);
    }];
    
    self.rightButton = [[UIButton alloc] init];
    self.rightButton.titleLabel.font = kFont(12);
    [self.rightButton setTitle:NSLocalizedString(@"换一批",nil) forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"CSHomeRecommendGuitarLeftChange"] forState:UIControlStateNormal];
    ViewRadius(self.rightButton, 6);
    //[self.rightButton setBackgroundColor:[UIColor colorWithHexString:@"#EDEDED" alpha:0.3]];
    [self.rightButton addTarget:self action:@selector(attentionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.rightButton];
   
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-12*widthScale);
        make.centerY.mas_equalTo(self.leftLabel.mas_centerY);
        make.width.mas_offset(@(60*widthScale));
        make.height.mas_offset(@(17*heightScale));
    }];
}

- (void)setModel:(CSNewHomeRecommendGuitarModel *)model{
    _model = model;
    self.leftLabel.text = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"精选",nil),model.subject_name,NSLocalizedString(@"课",nil)];
    self.rightLabel.text = [NSString stringWithFormat:@"%@·%@",model.subject_name,NSLocalizedString(@"在线",nil)];
}

- (void)guitarPlayClick:(UIButton *)btn{
    CSNewHomeRecommendGuitarListModel *model = self.dataArray[btn.tag];
    if ([self.delegate respondsToSelector:@selector(CSHomeRecommendGuitarCellPlayButton:)]) {
        [self.delegate CSHomeRecommendGuitarCellPlayButton:model];
    }
}

- (void)attentionButtonClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(CSHomeRecommendGuitarCellChangeButton)]) {
        [self.delegate CSHomeRecommendGuitarCellChangeButton];
    }
}


@end
