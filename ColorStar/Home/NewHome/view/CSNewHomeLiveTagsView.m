//
//  CSNewHomeLiveTagsView.m
//  ColorStar
//
//  Created by apple on 2020/11/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewHomeLiveTagsView.h"


@interface CSNewHomeLiveTagsCell : UICollectionViewCell
@property (nonatomic,strong)UILabel   *tileLab;
@property (nonatomic, strong)CSNewHomeLiveTagModel  *model;
@end


@implementation CSNewHomeLiveTagsCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
    
}

-(void)setModel:(CSNewHomeLiveTagModel *)model{

    self.tileLab.text = model.name;
//这里判断点中状态 改变标签的颜色
    if (model.isSelect) {

        [self labSelect];

    }else{

        [self labNoSelect];
    }
}
-(void)setUI{
//自定义标签
    [self.contentView addSubview:self.tileLab];
//约束
    [self.tileLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(@(24*heightScale));
        make.width.equalTo(self);
    }];
}
-(UILabel *)tileLab{
    
    if(!_tileLab){
        
        _tileLab = [[UILabel alloc]init];
        _tileLab.layer.masksToBounds = YES;
        _tileLab.layer.cornerRadius = 12*heightScale;
        _tileLab.textAlignment = NSTextAlignmentCenter;
        _tileLab.font = kFont(12);
        _tileLab.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
        _tileLab.textColor = [UIColor colorWithHexString:@"#979797"];
        ViewBorder(_tileLab, [UIColor colorWithHexString:@"#979797"], 1);
    }
    return _tileLab;;
}
//选中改变颜色
-(void)labNoSelect{
    
    _tileLab.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    _tileLab.textColor = [UIColor colorWithHexString:@"#979797"];
    ViewBorder(_tileLab, [UIColor colorWithHexString:@"#979797"], 1);
    
}
//选中改变颜色
-(void)labSelect{
    
    _tileLab.backgroundColor = [UIColor colorWithHexString:@"#D7B393"];
    _tileLab.textColor = [UIColor colorWithHexString:@"#202020"];
    ViewBorder(_tileLab, [UIColor colorWithHexString:@"#D7B393"], 1);
}



@end

@interface CSNewHomeLiveTagsView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView  * collectionView;
@property (nonatomic, strong)NSMutableArray     *modelsArray;
@end

@implementation CSNewHomeLiveTagsView

- (instancetype)init
{
    if (self = [super init]) {
        self.modelsArray = [NSMutableArray array];
        [self addSubview:self.collectionView];
    }
    return self;
}
-(void)setArray:(NSMutableArray *)array
{
    _array = array;
    self.modelsArray = array;
    [self.collectionView reloadData];
}
#pragma mark ==================== collectionView ====================
-(UICollectionView *)collectionView{

    if(!_collectionView){
        
        UICollectionViewFlowLayout*layout=[[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 30*heightScale) collectionViewLayout:layout];
        [_collectionView registerClass:[CSNewHomeLiveTagsCell class] forCellWithReuseIdentifier:@"CSNewHomeLiveTagsCell"];
        _collectionView.showsVerticalScrollIndicator = FALSE;
        _collectionView.showsHorizontalScrollIndicator = FALSE;
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
        _collectionView.delegate =self;
        _collectionView.dataSource =self;
    }
    return _collectionView;
}


//-(void)setModelLab:(LearningDetailModelLabType *)modelLab{
//
//    _modelLab = modelLab;
//    [self.collectionView reloadData];
//}
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.modelsArray.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath{
    
    CSNewHomeLiveTagsCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"CSNewHomeLiveTagsCell" forIndexPath:indexPath];
    cell.model = self.modelsArray[indexPath.row];
    return cell;
}
#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath{
    
    //遍历数据源 取消所有点击 isSelect全部都设置成NO
    for (CSNewHomeLiveTagModel *modelSelect in self.modelsArray) {
        modelSelect.isSelect = NO;
    }
    //改变点击标签的Select
    CSNewHomeLiveTagModel *model = self.modelsArray[indexPath.row];
    model.isSelect = YES;
    //让你点中index 自动滚动到中间  横向水平滑动 加入动画
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
         //刷新collectionView
    [self.collectionView reloadData];
    if (self.clickBlock) {
        self.clickBlock(model);
    }
}
//返回这个UICollectionViewCell是否可以被选择
-(BOOL)collectionView:(UICollectionView*)collectionView shouldSelectItemAtIndexPath:(NSIndexPath*)indexPath{
    return YES;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath{
    
    CSNewHomeLiveTagModel *model = self.modelsArray[indexPath.row];
//这里用了 计算 字符串的长度 来获取宽度+标签两遍的宽度
    
    
    CGSize size = [model.name sizeWithAttributes:@{NSFontAttributeName: kFont(12)}];

    //获取宽高

    CGSize statuseStrSize = CGSizeMake(ceilf(size.width), ceilf(size.height));

    CGFloat labWith =statuseStrSize.width +30;

    return CGSizeMake(labWith,24*heightScale);
}

//定义每个UICollectionView 的边距
-(UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//边距的顺序是 上左下右
  return UIEdgeInsetsMake(0,15,0,15);
}





@end
