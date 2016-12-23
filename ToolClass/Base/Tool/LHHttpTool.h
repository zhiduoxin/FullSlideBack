//
//  LHHttpTool.h
//  ToolClass
//
//  Created by lx on 16/12/16.
//  Copyright © 2016年 lx. All rights reserved.
//

#import <Foundation/Foundation.h>


//网络请求成功或者失败的block
typedef void(^netRequestSuccess)(NSURLSessionDataTask *task,id responObject);
typedef void(^netRequestFailure)(NSURLSessionDataTask *task,NSError *error);

@interface LHHttpTool : NSObject
+(LHHttpTool *)shareLHttpTool;
- (void)typeGETURLString:(NSString *)URLString parameters:(id)parameters success:(netRequestSuccess)success failure:(netRequestFailure)failure;
- (void)typePOSTURLString:(NSString *)URLString parameters:(id)parameters success:(netRequestSuccess)success failure:(netRequestFailure)failure;
- (void)uploadURLString:(NSString *)URLString parameters:(id)parameters uploadParam:(LHHttpTool *)failParm success:(netRequestSuccess)success failure:(netRequestFailure)failure;
+ (void)ReachabilityStatus:(void (^)(id))netStatus;
@end
