//
//  LHHttpTool.m
//  ToolClass
//
//  Created by lx on 16/12/16.
//  Copyright © 2016年 lx. All rights reserved.
//

#import "LHHttpTool.h"
#import "AFNetworking.h"




@interface LHHttpTool ()

/**
 *  图片的二进制数据
 */
@property (nonatomic, strong) NSData *data;
/**
 *  服务器对应的参数名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  文件的名称(上传到服务器后，服务器保存的文件名)
 */
@property (nonatomic, copy) NSString *filename;
/**
 *  文件的MIME类型(image/png,image/jpg等)
 */
@property (nonatomic, copy) NSString *mimeType;


@end

@implementation LHHttpTool

+(LHHttpTool *)shareLHttpTool{
    static LHHttpTool *httpTool = nil;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        httpTool = [[LHHttpTool alloc] init];
    });
    return httpTool;
}

- (AFHTTPSessionManager *)AFNetManager{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //申明返回的的数据json类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //申明请求的数据json类型
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //如果返回的类型不一致就换成其他的类型的数据
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    manager.requestSerializer.timeoutInterval = 5.0;
    return manager;
}


//get请求数据
- (void)typeGETURLString:(NSString *)URLString parameters:(id)parameters success:(netRequestSuccess)success failure:(netRequestFailure)failure{
    
    [[self AFNetManager] GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

//pos请求数据
- (void)typePOSTURLString:(NSString *)URLString parameters:(id)parameters success:(netRequestSuccess)success failure:(netRequestFailure)failure{
    [[self AFNetManager] POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

//上传图片

- (void)uploadURLString:(NSString *)URLString parameters:(id)parameters uploadParam:(LHHttpTool *)failParm success:(netRequestSuccess)success failure:(netRequestFailure)failure{
    [[self AFNetManager] POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:failParm.data name:failParm.name fileName:failParm.filename mimeType:failParm.mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
    
}

// 网络监测
+ (void)ReachabilityStatus:(void (^)(id))netStatus
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
                
            case AFNetworkReachabilityStatusUnknown:
                
                if (netStatus) {
                    netStatus(@"未知网络类型");
                }
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                
                if (netStatus) {
                    netStatus(@"无可用网络");
                }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                if (netStatus) {
                    netStatus(@"当前WIFE下");
                }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                if (netStatus) {
                    netStatus(@"使用蜂窝流量");
                }
                break;
                
            default:
                
                break;
                
        }
        
    }];
    [manager startMonitoring];
}

@end
