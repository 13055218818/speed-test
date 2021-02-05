//
//  CSLiveRankContainerView.m
//  ColorStar
//
//  Created by gavin on 2020/10/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSLiveRankContainerView.h"
#import "CSLiveRankCell.h"
#import "UIColor+CS.h"

NSString * CSLiveRankCellReuseIdentifier = @"CSLiveRankCellReuseIdentifier";

@interface CSLiveRankContainerView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView   * tableView;

@end

@implementation CSLiveRankContainerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#121212"];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 15, 0);
    [self.tableView registerClass:[CSLiveRankCell class] forCellReuseIdentifier:CSLiveRankCellReuseIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#121212"];
    [self addSubview:self.tableView];
}

- (void)setRanklist:(NSArray *)ranklist{
    _ranklist = ranklist;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ranklist.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CSLiveRankCell * cell = [tableView dequeueReusableCellWithIdentifier:CSLiveRankCellReuseIdentifier forIndexPath:indexPath];
    CSLiveRewardDetailModel * model = self.ranklist[indexPath.row];
    model.rank = indexPath.row + 1;
    cell.detailModel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

@end
