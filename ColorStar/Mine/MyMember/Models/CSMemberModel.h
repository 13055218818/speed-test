//
//  CSMemberModel.h
//  ColorStar
//
//  Created by gavin on 2020/9/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseModel.h"
#import "CSUserModel.h"

/*
 "uid":14,
 "account":"wx20200731124707",
 "pwd":"e10adc3949ba59abbe56e057f20f883e",
 "nickname":"T_T",
 "avatar":"http:\/\/thirdwx.qlogo.cn\/mmopen\/vi_32\/DYAIOgq83erx3dZgYibgcQibIL1DO2TpjVTn8ziaT5iaicZx8OXo6CeX6K73gcLXicfAlNaDLic1BSE52cwamHzZ9Theg\/132",
 "name":null,
 "phone":"18817334302",
 "grade_id":0,
 "full_name":"",
 "bank_card":"",
 "add_time":1596170827,
 "add_ip":"223.104.18.101",
 "last_time":1597743156,
 "last_ip":"222.190.245.74",
 "now_money":"0.00",
 "gold_num":1,
 "brokerage_price":"0.00",
 "integral":"0.00",
 "status":1,
 "level":1,
 "spread_uid":0,
 "spread_time":0,
 "valid_time":0,
 "user_type":"wechat",
 "is_promoter":0,
 "pay_count":0,
 "is_binding":0,
 "is_senior":0,
 "is_h5user":0,
 "is_permanent":0,
 "overdue_time":1599576897,
 "client_id":""
 */

@interface CSMemberBaseInfoModel : CSUserModel

@property (nonatomic, strong)NSString  * account;

@property (nonatomic, strong)NSString  * name;

@property (nonatomic, strong)NSString  * full_name;

@property (nonatomic, strong)NSString  * bank_card;

@property (nonatomic, strong)NSString  * add_time;

@property (nonatomic, strong)NSString  * now_money;

@property (nonatomic, strong)NSString  * gold_num;

@property (nonatomic, strong)NSString  * brokerage_price;

@property (nonatomic, strong)NSString  * integral;

@property (nonatomic, strong)NSString  * spread_uid;

@property (nonatomic, strong)NSString  * spread_time;

@property (nonatomic, strong)NSString  * valid_time;

@property (nonatomic, strong)NSString  * user_type;

@property (nonatomic, strong)NSString  * pay_count;

@property (nonatomic, strong)NSString  * is_binding;

@property (nonatomic, strong)NSString  * is_senior;

@property (nonatomic, strong)NSString  * is_h5user;

@property (nonatomic, strong)NSString  * is_permanent;

@property (nonatomic, strong)NSString  * overdue_time;

@property (nonatomic, strong)NSString  * client_id;

@end

@interface CSMemberInterestModel : CSBaseModel

@property (nonatomic, strong)NSString * interestId;

@property (nonatomic, strong)NSString * name;

@property (nonatomic, strong)NSString * pic;

@property (nonatomic, strong)NSString * explain;

@property (nonatomic, strong)NSString * sort;

@end

@interface CSMemberDescriptionModel : CSBaseModel

@property (nonatomic, strong)NSString * descriptId;

@property (nonatomic, strong)NSString * text;

@property (nonatomic, strong)NSString * sort;

@end


@interface CSMemberVipInfoModel : CSBaseModel

@property (nonatomic, strong)NSString * memberId;

@property (nonatomic, strong)NSString * type;

@property (nonatomic, strong)NSString * title;

@property (nonatomic, strong)NSString * vip_day;

@property (nonatomic, strong)NSString * original_price;

@property (nonatomic, strong)NSString * price;

@property (nonatomic, strong)NSString * is_permanent;

@property (nonatomic, strong)NSString * is_publish;

@property (nonatomic, strong)NSString * is_free;

@property (nonatomic, strong)NSString * sort;

@property (nonatomic, strong)NSString * is_del;

@property (nonatomic, strong)NSString * add_time;

@property (nonatomic, strong)NSString * unit;

@end

/*
 "code":200,
 "msg":"ok",
 "data":{
 "userInfo":{
 
 },
 "interests":[
 {
 "id":161,
 "name":"\u4f1a\u5458\u4f18\u60e0\u4ef7",
 "pic":"http:\/\/
 -zsff.oss-cn-beijing.aliyuncs.com\/39472202004291128217988.png",
 "explain":"\u8d2d\u4e70\u4e13\u9898\u4eab\u4f1a\u5458\u4ef7",
 "sort":"1"
 },
 {
 "id":162,
 "name":"\u514d\u8d39\u8bfe\u7a0b",
 "pic":"http:\/\/cremb-zsff.oss-cn-beijing.aliyuncs.com\/59285202004291128212590.png",
 "explain":"\u90e8\u5206\u8bfe\u7a0b\u4f1a\u5458\u514d\u8d39",
 "sort":"2"
 },
 {
 "id":163,
 "name":"\u66f4\u591a\u6743\u76ca",
 "pic":"http:\/\/cremb-zsff.oss-cn-beijing.aliyuncs.com\/11009202004291128212348.png",
 "explain":"\u66f4\u591a\u6743\u76ca\u589e\u52a0\u4e2d",
 "sort":"3"
 }
 ],
 "description":[
 {
 "id":164,
 "text":"\u4f1a\u5458\u8d2d\u4e70\u90e8\u5206\u8bfe\u7a0b\u53ef\u4eab\u53d7\u4f18\u60e0\u4ef7",
 "sort":"1"
 },
 {
 "id":165,
 "text":"\u4f1a\u5458\u5230\u671f\u540e\u6743\u76ca\u5373\u5931\u6548\uff0c\u9700\u7ee7\u7eed\u4eab\u53d7\u6743\u76ca\u8bf7\u53ca\u65f6\u7eed\u8d39",
 "sort":"2"
 },
 {
 "id":166,
 "text":"\u62fc\u56e2\u6d3b\u52a8\u4ef7\u65e0\u4f1a\u5458\u4f18\u60e0",
 "sort":"3"
 }
 ],
 "member":{
 "id":1,
 "type":1,
 "title":"\u6708\u5361",
 "vip_day":30,
 "original_price":"30.00",
 "price":"20.00",
 "is_permanent":0,
 "is_publish":1,
 "is_free":0,
 "sort":4,
 "is_del":0,
 "add_time":1588129765,
 "unit":"\u6708"
 },
 "freeData":{
 "free":{
 "id":5,
 "type":1,
 "title":"\u514d\u8d39",
 "vip_day":7,
 "original_price":"0.00",
 "price":"0.00",
 "is_permanent":0,
 "is_publish":1,
 "is_free":1,
 "sort":0,
 "is_del":0,
 "add_time":1588130680
 },
 "is_record":1
 }
 },
 "count":0
 */

@interface CSMemberFreeDataBaseModel : CSBaseModel

@property (nonatomic, strong)NSString * freeId;

@property (nonatomic, strong)NSString * type;

@property (nonatomic, strong)NSString * title;

@property (nonatomic, strong)NSString * vip_day;

@property (nonatomic, strong)NSString * original_price;

@property (nonatomic, strong)NSString * price;

@property (nonatomic, strong)NSString * is_permanent;

@property (nonatomic, strong)NSString * is_publish;

@property (nonatomic, strong)NSString * is_free;

@property (nonatomic, strong)NSString * sort;

@property (nonatomic, strong)NSString * is_del;

@property (nonatomic, strong)NSString * add_time;

@end

@interface CSMemberFreeDataModel : CSBaseModel

@property (nonatomic, strong)CSMemberFreeDataBaseModel  * free;

@property (nonatomic, strong)NSString   * is_record;


@end



@interface CSMemberModel : CSBaseModel

@property (nonatomic, strong)CSMemberBaseInfoModel * userInfo;

@property (nonatomic, strong)NSArray<CSMemberInterestModel*>     * interests;

@property (nonatomic, strong)NSArray<CSMemberDescriptionModel*>  * descs;

@property (nonatomic, strong)CSMemberVipInfoModel  * member;

@property (nonatomic, strong)CSMemberFreeDataModel  * freeData;



@end


