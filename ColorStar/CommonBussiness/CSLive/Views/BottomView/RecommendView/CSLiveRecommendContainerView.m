//
//  CSLiveRecommendContainerView.m
//  ColorStar
//
//  Created by gavin on 2020/10/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSLiveRecommendContainerView.h"
#import "CSLiveRecommendCell.h"
#import "UIColor+CS.h"
#import "CSColorStar.h"
#import <Masonry/Masonry.h>

NSString * CSLiveRecommendCellReuseIdentifier = @"CSLiveRecommendCellReuseIdentifier";

@interface CSLiveRecommendContainerView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView   * tableView;


@end

@implementation CSLiveRecommendContainerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#121212"];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.image = LoadImage(@"cs_empty_data");
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(80);
    }];
    
    UILabel * label = [[UILabel alloc]init];
    label.text = @"暂无数据";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView);
        make.top.mas_equalTo(imageView.mas_bottom);
    }];
    return;
    
    self.tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 15, 0);
    [self.tableView registerClass:[CSLiveRecommendCell class] forCellReuseIdentifier:CSLiveRecommendCellReuseIdentifier];
    [self addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.recommendlist.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CSLiveRecommendCell * cell = [tableView dequeueReusableCellWithIdentifier:CSLiveRecommendCellReuseIdentifier forIndexPath:indexPath];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


@end
