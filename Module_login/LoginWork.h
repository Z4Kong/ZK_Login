//
//  LoginWork.h
//  Module_Login
//
//  Created by qian on 17/6/20.
//  Copyright © 2017年 qian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModuleConstant.h"


@class LoginCustomManager;

@interface LoginWork : NSObject

/**
 *  密码登录接口
 *
 *  @param account  账号
 *  @param type     账号类型
 *  @param password 密码
 *  @param verify   验证回调
 *  @param success  成功回调
 *  @param failure  失败回调
 */
+(void)loginInWithAccount:(NSString *)account
              accountType:(AccountType)type
                 password:(NSString *)password
                   verify:(void (^)(VerifyError error))verify
                  success:(void (^)(id responseObj))success
                  failure:(void (^)(NSError *error))failure;

/**
 *  验证码登录接口
 *
 *  @param account  账号
 *  @param type     账号类型
 *  @param code     验证码
 *  @param verify   验证回调
 *  @param success  成功回调
 *  @param failure  失败回调
 */
+(void)loginInWithAccount:(NSString *)account
              accountType:(AccountType)type
                     code:(NSString *)code
                   verify:(void (^)(VerifyError error))verify
                  success:(void (^)(id responseObj))success
                  failure:(void (^)(NSError *error))failure;

/**
 *  退出接口
 *
 *  @param account 账号
 *  @param type    账号类型
 *  @param verify  验证回调
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+(void)loginOutWithAccount:(NSString *)account
               accountType:(AccountType)type
                    verify:(void (^)(VerifyError error))verify
                   success:(void (^)(id responseObj))success
                   failure:(void (^)(NSError *error))failure;
/**
 *  注册接口
 *
 *  @param account  账号
 *  @param type     账号类型
 *  @param password 密码
 *  @param code     验证码
 *  @param ext      扩展：昵称，头像
 *  @param verify   验证回调
 *  @param success  成功回调
 *  @param failure  失败回调
 */
+(void)registerWithAccount:(NSString *)account
               accountType:(AccountType)type
                  password:(NSString *)password
                      code:(NSString *)code
                 extension:(NSDictionary *)ext
                    verify:(void (^)(VerifyError error))verify
                   success:(void (^)(id responseObj))success
                   failure:(void (^)(NSError *error))failure;

/**
 *  忘记密码接口
 *
 *  @param account  账号
 *  @param type     账号类型
 *  @param password 密码
 *  @param code     验证码
 *  @param verify   验证回调
 *  @param success  成功回调
 *  @param failure  失败回调
 */
+(void)forgetWithAccount:(NSString *)account
             accountType:(AccountType)type
                password:(NSString *)password
                    code:(NSString *)code
                  verify:(void (^)(VerifyError error))verify
                 success:(void (^)(id responseObj))success
                 failure:(void (^)(NSError *error))failure;

/**
 *  修改密码接口
 *
 *  @param account     账号
 *  @param type        账号类型
 *  @param password    旧密码
 *  @param newpassword 新密码
 *  @param verify      验证回调
 *  @param success     成功回调
 *  @param failure     失败回调
 */
+(void)changePwdWithAccount:(NSString *)account
             accountType:(AccountType)type
                password:(NSString *)password
             newPassword:(NSString *)newpassword
                  verify:(void (^)(VerifyError error))verify
                 success:(void (^)(id responseObj))success
                 failure:(void (^)(NSError *error))failure;

/**
 *  修改用户信息接口
 *
 *  @param account  账号
 *  @param type     账号类型
 *  @param password 密码
 *  @param ext      扩展：昵称，头像
 *  @param verify   验证回调
 *  @param success  成功回调
 *  @param failure  失败回调
 */
+(void)changeInfoWithAccount:(NSString *)account
                 accountType:(AccountType)type
                    password:(NSString *)password
                   extension:(NSDictionary *)ext
                      verify:(void (^)(VerifyError error))verify
                     success:(void (^)(id responseObj))success
                     failure:(void (^)(NSError *error))failure;

/**
 *  获取短信验证码接口
 *
 *  @param phone   手机号码
 *  @param verify  验证回调
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+(void)getNoteCodeWithPhone:(NSString *)phone
                  extension:(NSDictionary *)ext
                     verify:(void (^)(VerifyError error))verify
                    success:(void (^)(id responseObj))success
                    failure:(void (^)(NSError *error))failure;

/**
 *  获取图片验证码接口
 *
 *  @param account 账号
 *  @param verify  验证回调
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+(void)getImageCodeWithAccount:(NSString *)account
                   accountType:(AccountType)type
                        verify:(void (^)(VerifyError error))verify
                       success:(void (^)(id responseObj))success
                       failure:(void (^)(NSError *error))failure;

/**
 *  检测验证码接口
 *
 *  @param account 账号
 *  @param type    账号类型
 *  @param code    验证码
 *  @param verify  验证回调
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+(void)verifyCodeWithAccount:(NSString *)account
                 accountType:(AccountType)type
                        code:(NSString *)code
                   extension:(NSDictionary *)ext
                      verify:(void (^)(VerifyError error))verify
                     success:(void (^)(id responseObj))success
                     failure:(void (^)(NSError *error))failure;


//第三方登录(暂时不鸟) -TODO



/**
 检测账号是否正确

 @param account 账号
 @param type 账号类型
 @return yes or no
 */
+(BOOL)verifyWithAccount:(NSString *)account type:(AccountType)type;

@end


@interface LoginTimer : NSObject

@property (nonatomic , strong) dispatch_source_t timer;

/**
 倒计时函数
 
 @param time 倒计时总时间
 @param timeBK 回调
 */
-(void)startTime:(int)time timeBackBlock:(void (^)(int time))timeBK;


/**
 停止倒计时
 */
-(void)stopTime;
@end

typedef void (^EncodeCustomBlock)(NSMutableDictionary *dic,void(^callback)(NSDictionary *encodedic));
typedef void (^NetworkCustomBlcok)(NSString *url,NSDictionary *params,void(^success)(id responseObj),void(^failure)(NSError *error));

@interface LoginCustomManager : NSObject


/**
 初始化管理单例

 @return self
 */
+(id)shareMangaer;


/**
 加密Block
 */
@property (nonatomic ,copy) EncodeCustomBlock encodeBK;

/**
 网络Block
 */
@property (nonatomic ,copy) NetworkCustomBlcok networkBK;


@end
