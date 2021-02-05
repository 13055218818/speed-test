//
//  CSNewCourseCategoryView.m
//  ColorStar
//
//  Created by apple on 2020/11/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewCourseCategoryView.h"
#import "CSNewCourseCategoryViewCell.h"
@interface CSNewCourseCategoryView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) UIView  *contentView;
@property (nonatomic, strong) NSMutableArray  *dataArray;
@end

@implementation CSNewCourseCategoryView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = [NSMutableArray array];
        [self layoutAllSubviews];
    }
    return self;
}
 
- (void)layoutAllSubviews{
    UIView *bgView = [[UIView alloc] init];
    bgView.alpha = 0.5;
    bgView.backgroundColor = [UIColor blackColor];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissContactView:)];
    [bgView addGestureRecognizer:tapGesture];

    UILabel  *cancelLabel = [[UILabel alloc] init];
    cancelLabel.backgroundColor = [UIColor whiteColor];
    cancelLabel.text = csnation(@"取消");
    cancelLabel.textColor = [UIColor colorWithHexString:@"#007AFF"];
    cancelLabel.textAlignment = NSTextAlignmentCenter;
    cancelLabel.font = kFont(12);
    [self addSubview:cancelLabel];
    [cancelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_offset(@(50*heightScale +kSafeAreaBottomHeight));
    }];
    
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.contentView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(cancelLabel.mas_top).offset(-5*heightScale);
        make.height.mas_offset(250*heightScale);
    }];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [self.tableView registerClass:[CSNewCourseCategoryViewCell class] forCellReuseIdentifier:@"CSNewCourseCategoryViewCell"];
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.contentView);
    }];
    
}

- (void)refreshUIWith:(NSMutableArray *)arrray{
    [self.dataArray removeAllObjects];
    self.dataArray = arrray;
    [self.tableView reloadData];
}
#pragma mark - 手势点击事件,移除View
- (void)dismissContactView:(UITapGestureRecognizer *)tapGesture{
    
    [self dismissContactView];
}
 
-(void)dismissContactView
{
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
    for (CSNewCourseCategoryModel *model in self.dataArray) {
        if (model.isSelect) {
            if (self.clickBlock) {
                self.clickBlock(model);
            }
        }
    }
    
    
}
 
// 这里加载在了window上
-(void)showView
{
    UIWindow * window = [UIApplication sharedApplication].windows[0];
    [window addSubview:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*heightScale;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSNewCourseCategoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSNewCourseCategoryViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count > 0) {
        cell.model = self.dataArray[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CSNewCourseCategoryModel *model = self.dataArray[indexPath.row];
            for (CSNewCourseCategoryModel *model1 in self.dataArray) {
            if ([model.categoryId isEqualToString:model1.categoryId]) {
                model1.isSelect = YES;
               
            }else{
                model1.isSelect = NO;
            }
        }
    [self.tableView reloadData];
    [self dismissContactView];

}


@end
