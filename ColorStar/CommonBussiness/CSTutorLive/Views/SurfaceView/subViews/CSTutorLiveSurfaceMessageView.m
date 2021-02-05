//
//  CSLiveNewMessageShowView.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/18.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorLiveSurfaceMessageView.h"
#import "CSTutorLiveMessageCell.h"
#import "CSTutorLiveGiftCell.h"
#import "CSTutorLiveModel.h"
#import "CSTutorLiveGiftModel.h"

@interface CSTutorLiveSurfaceMessageView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView    * giftTable;

@property (nonatomic, strong)UITableView    * chatTable;

@property (nonatomic, strong)NSMutableArray * comments;

@property (nonatomic, strong)NSMutableArray * gifts;

@end

@implementation CSTutorLiveSurfaceMessageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self addSubview:self.giftTable];
    [self addSubview:self.chatTable];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.giftTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(100*heightScale);
    }];
    
    [self.chatTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(200*heightScale);
    }];
}

- (void)initComments:(NSArray*)comments{
    
    if (comments.count == 0) {
        return;
    }
    
    [self.comments removeAllObjects];
    [self.gifts removeAllObjects];
    for (CSTutorCommentDetailModel * detailModel in comments) {
        if ([detailModel.type isEqualToString:@"1"]) {//文字
            CSTutorLiveMessageModel * message = [[CSTutorLiveMessageModel alloc]init];
            message.name = detailModel.nickname;
            message.message = detailModel.content;
            [self.comments addObject:message];
        }else if ([detailModel.type isEqualToString:@"4"]){//礼物
            CSTutorLiveGiftModel * model = [[CSTutorLiveGiftModel alloc]init];
            model.sender = detailModel.nickname;
            model.avtorURL = detailModel.avatar;
            model.giftName = detailModel.gift_name;
            model.giftCount = detailModel.gift_num;
            
            [self.gifts addObject:model];
        }
        
    }
    
    [self.chatTable reloadData];
    [self.giftTable reloadData];
    if (self.comments.count > 0) {
        NSIndexPath * chatIndexPath = [NSIndexPath indexPathForRow:self.comments.count - 1 inSection:0];
        [self.chatTable scrollToRowAtIndexPath:chatIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
    if (self.gifts.count > 0) {
        NSIndexPath * giftIndexPath = [NSIndexPath indexPathForRow:self.gifts.count - 1 inSection:0];
        [self.giftTable scrollToRowAtIndexPath:giftIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
}

- (void)addComment:(CSIMMessageModel*)comment{
    
    CSTutorLiveMessageModel * message = [[CSTutorLiveMessageModel alloc]init];
    message.name = comment.userInfo.nickname;
    message.message = comment.message;
    
    [self.comments addObject:message];
    [self.chatTable reloadData];
    if (self.comments.count > 0) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:self.comments.count - 1 inSection:0];
        [self.chatTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }

    
}

- (void)addGift:(CSIMGiftModel*)gift{
    
    CSTutorLiveGiftModel * model = [[CSTutorLiveGiftModel alloc]init];
    model.sender = gift.username;
    model.avtorURL = gift.user_avatar;
    model.giftName = gift.live_gift_name;
    model.giftCount = gift.live_gift_num;
    [self.gifts addObject:model];
    [self.giftTable reloadData];
    if (self.gifts.count > 0) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:self.gifts.count - 1 inSection:0];
        [self.giftTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }

    
}

#pragma mark - UITableView Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.giftTable]) {
        return self.gifts.count;
    }
    return self.comments.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:self.giftTable]) {
        
        CSTutorLiveGiftCell * cell = [tableView dequeueReusableCellWithIdentifier:[CSTutorLiveGiftCell reuserIndentifier]];
        [cell mockData];
        CSTutorLiveGiftModel * model = self.gifts[indexPath.row];
        [cell configModel:model];
        return cell;
    }
    
    CSTutorLiveMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:[CSTutorLiveMessageCell reuserIndentifier]];
    CSTutorLiveMessageModel * detailModel = self.comments[indexPath.row];
    [cell mockData];
    [cell configModel:detailModel];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.giftTable]) {
        
        return 50*heightScale;
        
    }
    CSTutorLiveMessageModel * detailModel = self.comments[indexPath.row];
    return [CSTutorLiveMessageCell cellHeightForModel:detailModel];
}

#pragma mark - Properties

- (UITableView*)giftTable{
    if (!_giftTable) {
        _giftTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _giftTable.delegate = self;
        _giftTable.dataSource = self;
        _giftTable.backgroundColor = [UIColor clearColor];
        _giftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_giftTable registerClass:[CSTutorLiveGiftCell class] forCellReuseIdentifier:[CSTutorLiveGiftCell reuserIndentifier]];
    }
    return _giftTable;
}

- (UITableView*)chatTable{
    if (!_chatTable) {
        _chatTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _chatTable.dataSource = self;
        _chatTable.delegate = self;
        _chatTable.backgroundColor = [UIColor clearColor];
        _chatTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_chatTable registerClass:[CSTutorLiveMessageCell class] forCellReuseIdentifier:[CSTutorLiveMessageCell reuserIndentifier]];
    }
    return _chatTable;
}

- (NSMutableArray*)comments{
    if (!_comments) {
        _comments = [NSMutableArray arrayWithCapacity:0];
    }
    return _comments;
}

- (NSMutableArray*)gifts{
    if (!_gifts) {
        _gifts = [NSMutableArray arrayWithCapacity:0];
    }
    return _gifts;
}

@end
