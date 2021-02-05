//
//  CSNewLiveViewController.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorLiveViewController.h"
#import "CSTutorLiveBackView.h"
#import "CSTutorLiveSurfaceView.h"
#import "CSTutorLiveManager.h"
#import "CSTutorLiveModel.h"

@interface CSTutorLiveViewController ()

@property (nonatomic, strong)CSTutorLiveBackView    * liveContainerView;

@property (nonatomic, strong)CSTutorLiveSurfaceView * surfaceView;
 
@property (nonatomic, strong)CSTutorLiveModel       * model;

@end

@implementation CSTutorLiveViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
    [self fetchLiveInfo];
    
}

- (void)setupViews{
    
    self.liveContainerView = [[CSTutorLiveBackView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.liveContainerView];
    
    self.surfaceView = [[CSTutorLiveSurfaceView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.surfaceView];

    CS_Weakify(self, weakSelf);
    self.surfaceView.surfaceBlock = ^(CSTutorLiveSurfaceViewType type) {
        [weakSelf dealSurfaceBlock:type];
    };
    
    
}

- (void)fetchLiveInfo{
    
    CS_Weakify(self, weakSelf);
    [[CSTutorLiveManager shared] fetchLiveInfo:self.stream_name liveId:self.live_id specialId:self.special_id complete:^(CSNetResponseModel *response, NSError *error) {
        if (!error) {
            if ([response.data isKindOfClass:[NSDictionary class]]) {
                CSTutorLiveModel * model = [CSTutorLiveModel yy_modelWithDictionary:response.data];
                weakSelf.surfaceView.liveModel = model;
                weakSelf.liveContainerView.liveModel = model;
//                [weakSelf fetchVistors:model];
                if ([model.live_status isEqualToString:@"2"]) {
                    [csnation(@"直播结束") showAlert];
                }else if ([model.live_status isEqualToString:@"0"]){
                    [csnation(@"直播未开始") showAlert];
                }
            }
        }else{
            [csnation(@"获取直播信息失败") showAlert];
        }
    }];
    
    
}

- (void)fetchVistors:(CSTutorLiveModel*)liveModel{
    if ([NSString isNilOrEmpty:liveModel.liveInfo.liveId]) {
        return;
    }
    
    CS_Weakify(self, weakSelf);
    [[CSTutorLiveManager shared] fetchVistors:liveModel.liveInfo.liveId complete:^(CSNetResponseModel *response, NSError *error) {
        if (!error && [response.data isKindOfClass:[NSDictionary class]]) {
            NSDictionary * data = response.data;
            NSArray * list = [data valueForKey:@"list"];
            if (list.count > 0) {
                weakSelf.surfaceView.vistors = list;
            }
        }
            
    }];;
    
}

- (void)dealSurfaceBlock:(CSTutorLiveSurfaceViewType)type{
    
    if (type == CSTutorLiveSurfaceViewTypeBack) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

@end
