//
//  AppDelegate+Module_Login.m
//  Module_Login
//
//  Created by ios on 2017/6/22.
//  Copyright © 2017年 qian. All rights reserved.
//

#import "AppDelegate+Module_Login.h"

#import "LoginModule.h"

#import "NSString+MD5Addition.h"
#import "GTMBase64.h"
#import <AFNetworking.h>

@implementation AppDelegate (Module_Login)

-(void)initWithCustomLoginModule
{
    LoginCustomManager *mgr = [LoginCustomManager shareMangaer];
    //自定义加密block
    mgr.encodeBK = ^(NSMutableDictionary *dic, void (^callback)(NSDictionary *encodedic)) {
        if (callback) {
            for (NSString *key in dic.allKeys) {
                NSData *data = [[dic[key] stringFromMD5] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
                data = [GTMBase64 encodeData:data];
                NSString * encodestr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                dic[key] =encodestr;
            }
            NSLog(@"自定义加密后字典:%@",dic);
            callback(dic);
        }
    };
    //自定义网络block
    mgr.networkBK = ^(NSString *url, NSDictionary *params, void (^success)(id responseObj), void (^failure)(NSError *error)) {
        NSLog(@"自定义POSTURL:%@,%@",url,params);
        // 1.获得请求管理者
        AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
        mgr.requestSerializer.timeoutInterval =10.0f;
        //https
        AFSecurityPolicy *securityPolicy =[AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates =YES;
        mgr.securityPolicy =securityPolicy;
        
        AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
        serializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"baiduapp/json",@"text/html",@"text/plain",nil];
        mgr.responseSerializer = serializer;
        // 2.发送POST请求
        [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                NSDictionary *responseDic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"自定义POSTResponse:%@",responseDic);
                success(responseDic);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    };
}

@end
