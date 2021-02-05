//
//  CSGuideViewController.m
//  ColorStar
//
//  Created by 陶涛 on 2020/8/13.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSGuideViewController.h"
#import "UIView+CS.h"
#import "UIColor+CS.h"
#import "WOPageControl.h"
#import "CSFirstAppStartView.h"
#import "CSBasePopupView.h"

@interface CSGuideViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)NSArray *picList;

@property (nonatomic, strong)NSArray *picCenterList;

@property (nonatomic, strong)UIScrollView * scrollView;

@property (nonatomic, strong)WOPageControl * pageControl;

@end

@implementation CSGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.picList = @[@"cs_guider_cn",@"cs_guider_cn",@"cs_guider_cn"];
    
    self.picCenterList = @[@"cs_guider_center_one",@"cs_guider_center_two",@"cs_guider_center_three"];
    NSArray  *titleOne = @[csnation(@"娱乐教育"),csnation(@"导师资源"),csnation(@"明星周边")];
    NSArray  *titleTwo = @[csnation(@"国际化的娱乐教育平台"),csnation(@"丰富的导师资源"),csnation(@"明星周边产品")];

    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width*self.picList.count, 0);
    self.scrollView.backgroundColor = [UIColor colorWithRed:17/255.0 green:2/255.0 blue:62/255.0 alpha:1];
    [self.view addSubview:self.scrollView];
    
    for (int i = 0; i < self.picList.count; i++) {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(self.view.width*i, 0, self.scrollView.width, self.scrollView.height);
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:self.picList[i]];
        [self.scrollView addSubview:imageView];
        CGFloat topMargin ;
        CGFloat centerHeight ;
        switch (i) {
            case 0:
            {
                topMargin = 223*heightScale;
                centerHeight = 322*heightScale;
            }
                break;
            case 1:
            {
                topMargin = 192*heightScale;
                centerHeight = 353*heightScale;
            }
                break;
            case 2:
            {
                topMargin = 80*heightScale;
                centerHeight = 465*heightScale;
            }
                break;
            default:
                break;
        }
        UIImageView * centerImageView = [[UIImageView alloc]init];
        centerImageView.frame = CGRectMake((self.view.width-30*widthScale)*i + (15+15)*widthScale *i, topMargin, self.scrollView.width-30*widthScale, centerHeight);
        centerImageView.layer.masksToBounds = YES;
        centerImageView.contentMode = UIViewContentModeScaleAspectFill;
        centerImageView.image = [UIImage imageNamed:self.picCenterList[i]];
        [self.scrollView addSubview:centerImageView];
        
        UILabel  *labelOne = [[UILabel alloc] init];
        labelOne.text = titleOne[i];
        labelOne.textAlignment = NSTextAlignmentCenter;
        labelOne.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        labelOne.font = kFont(24);
        labelOne.frame = CGRectMake(ScreenW*i, 560*heightScale, ScreenW, 30*heightScale);
        [self.scrollView addSubview:labelOne];
        UILabel  *labelTwo = [[UILabel alloc] init];
        labelTwo.text = titleTwo[i];
        labelTwo.textAlignment = NSTextAlignmentCenter;
        labelTwo.textColor = [UIColor colorWithHexString:@"#B5B5B5"];
        labelTwo.font = kFont(16);
        labelTwo.frame = CGRectMake(ScreenW*i, 590*heightScale, ScreenW, 30*heightScale);
        [self.scrollView addSubview:labelTwo];
        
        if (i == self.picList.count - 1) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:NSLocalizedString(@"立即开启", nil) forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(guideFinish) forControlEvents:UIControlEventTouchUpInside];
            btn.center = CGPointMake(self.scrollView.width/2 + self.scrollView.width*i, self.scrollView.height - 150*heightScale);
            btn.bounds = CGRectMake(0, 0, 200, 40);
//            btn.backgroundColor = [UIColor colorWithHexString:@"#16BAE5"];
            [btn setBackgroundImage:[UIImage imageNamed:@"startOpenNow.png"] forState:UIControlStateNormal];
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 20;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.scrollView addSubview:btn];
        }
    }
    
    self.pageControl = [[WOPageControl alloc] initWithFrame:CGRectMake(110, 200, 50, 4)];
    [self.view addSubview:self.pageControl];
    self.pageControl.center = CGPointMake(self.view.width/2, self.view.height - 100*heightScale);
    
    self.pageControl.cornerRadius = 5;
    self.pageControl.dotHeight = 10;
    self.pageControl.dotSpace = 24;
    self.pageControl.currentDotWidth = 24;
    self.pageControl.otherDotWidth = 10;
    self.pageControl.otherDotColor = [UIColor colorWithWhite:1.0 alpha:0.38];
    self.pageControl.currentDotColor = [UIColor whiteColor];
    self.pageControl.numberOfPages = self.picList.count;
//    CSFirstAppStartView  * shareView = [[CSFirstAppStartView alloc]init];
//    CSFirstAppStartView.cs_tapToDismiss = YES;
    //[self saveqrcodeImage];
//    [CSFirstAppStartView show];
//    [shareView show];
    
//    [self.view bringSubviewToFront:shareView];
    

}

- (void)guideFinish{
    if (self.complete) {
        self.complete(YES);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int number = scrollView.contentOffset.x/scrollView.width;
    
    self.pageControl.currentPage = number;
    
}


@end
