//
//  CSNewCourseNetManage.h
//  ColorStar
//
//  Created by apple on 2020/11/25.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CSNetWorkSuccessCompletion)(CSNetResponseModel * response);
typedef void(^CSNetWorkFailureCompletion)(NSError * error);
@interface CSNewCourseNetManage : NSObject
+ (instancetype)sharedManager;

@property (nonatomic, strong)AFHTTPSessionManager  * netManager;

//课程banner数据
- (void)getCourseBannerInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//课程分类数据
- (void)getCourseCategoryListInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//课程list数据
- (void)getCourseListInfoSuccessWith:(NSString *)grade_id withOrder:(NSString *)order withPage:(NSString *)page withLimit:(NSString *)limit Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

@end

NS_ASSUME_NONNULL_END
