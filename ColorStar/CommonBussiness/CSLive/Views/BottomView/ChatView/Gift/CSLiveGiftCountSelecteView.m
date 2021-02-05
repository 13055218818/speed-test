//
//  CSLiveGiftCountSelecteView.m
//  ColorStar
//
//  Created by gavin on 2020/10/13.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSLiveGiftCountSelecteView.h"


@interface CSLiveGiftCountSelecteView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UIView     * bgView;

@property (nonatomic, strong)UITableView * tableView;

@property (nonatomic,copy) void(^action)(NSInteger index);

@property (nonatomic,copy) NSArray * selectData;

@property (nonatomic,assign)CGPoint  selectPoint;

@end

@implementation CSLiveGiftCountSelecteView


+ (void)addGiftCountSelecteViewWithPoint:(CGPoint)point
                                   selectData:(NSArray *)selectData
                                       action:(void(^)(NSInteger index))action animated:(BOOL)animate{
    UIWindow *window = [[[UIApplication sharedApplication] windows] firstObject];
    
    CSLiveGiftCountSelecteView * selecteView = [[CSLiveGiftCountSelecteView alloc] initWithFrame:window.bounds data:selectData point:point];
    selecteView.action = action;
    selecteView.backgroundColor = [UIColor colorWithHue:0
                                                saturation:0
                                                brightness:0 alpha:0.1];
    [window addSubview:selecteView];
    
}

+ (void)hiden{
    
}


- (instancetype)initWithFrame:(CGRect)frame data:(NSArray*)data point:(CGPoint)point{
    if (self = [super initWithFrame:frame]) {
        _selectData = data;
        _selectPoint = point;
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    self.bgView = [[UIView alloc]initWithFrame:self.bounds];
    self.bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundClick:)];
    [self.bgView addGestureRecognizer:tap];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 30;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
    CGFloat rowHeight = 30;
    CGFloat rowWith = 100;
    self.tableView.frame = CGRectMake(self.selectPoint.x - 50, self.selectPoint.y - 20 - (rowHeight*self.selectData.count), rowWith, (rowHeight*self.selectData.count));
    self.tableView.layer.masksToBounds = YES;
    self.tableView.layer.cornerRadius = 10;
    
    
    
}

- (void)tapBackgroundClick:(UITapGestureRecognizer*)gesture{
    
//    CGPoint locationPoint = [gesture locationInView:self];
//    locationPoint = [self.tableView.layer convertPoint:locationPoint fromLayer:self.layer];
//    if (![self.tableView.layer containsPoint:locationPoint]) {
//
//    }
    [self dismiss];
    
}

- (void)show{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.5;
       self.tableView.transform = CGAffineTransformMakeScale(1.0, 1.0);
       
    }];
    
}

- (void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{

//        self.tableView.transform = CGAffineTransformMakeScale(0.000001, 0.0001);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.tableView removeFromSuperview];
        self.tableView = nil;
    }];
    
}


#pragma mark - UITableViewDataSource Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.selectData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"PellTableViewSelectIdentifier";
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:Identifier];
    }
    cell.textLabel.text = self.selectData[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.action) {
        self.action(indexPath.row);
    }
    [self dismiss];
}

- (void)drawRect:(CGRect)rect{
    
    
    //    [colors[serie] setFill];
    // 设置背景色
    [[UIColor whiteColor] set];
    //拿到当前视图准备好的画板
    
    CGContextRef  context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    
    CGContextBeginPath(context);//标记
    CGContextMoveToPoint(context,self.selectPoint.x, self.selectPoint.y - 10);//设置起点
    
    CGContextAddLineToPoint(context, self.selectPoint.x - 10,  self.selectPoint.y - 20);
    
    CGContextAddLineToPoint(context,self.selectPoint.x + 10, self.selectPoint.y - 20);
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    [[UIColor whiteColor] setFill];  //设置填充色
    
    [[UIColor whiteColor] setStroke]; //设置边框颜色
    
    CGContextDrawPath(context,
                      kCGPathFillStroke);//绘制路径path
    
//    [self setNeedsDisplay];
}

@end
