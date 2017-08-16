//
//  LoginWork.m
//  Module_Login
//
//  Created by qian on 17/6/20.
//  Copyright © 2017年 qian. All rights reserved.
//

#import "LoginWork.h"

@implementation LoginWork


+(void)loginInWithAccount:(NSString *)account accountType:(AccountType)type password:(NSString *)password verify:(void (^)(VerifyError error))verify success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    [LoginWork postWithURL:URL_LoginIn4Pwd action:ActionTypeLoginIn4Pwd account:account type:type password:password newPassword:nil code:nil extension:nil verify:verify success:success failure:failure];
}

+(void)loginInWithAccount:(NSString *)account accountType:(AccountType)type code:(NSString *)code verify:(void (^)(VerifyError error))verify success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    [LoginWork postWithURL:URL_LoginIn4Code action:ActionTypeLoginIn4Code account:account type:type password:nil newPassword:nil code:code extension:nil verify:verify success:success failure:failure];
}

+(void)loginOutWithAccount:(NSString *)account accountType:(AccountType)type verify:(void (^)(VerifyError error))verify success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    [LoginWork postWithURL:URL_LoginOut action:ActionTypeLoginOut account:account type:type password:nil newPassword:nil code:nil extension:nil verify:verify success:success failure:failure];
}

+(void)registerWithAccount:(NSString *)account accountType:(AccountType)type password:(NSString *)password code:(NSString *)code extension:(NSDictionary *)ext verify:(void (^)(VerifyError error))verify success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    [LoginWork postWithURL:URL_Register action:ActionTypeRegister account:account type:type password:password newPassword:nil code:code extension:ext verify:verify success:success failure:failure];
}

+(void)forgetWithAccount:(NSString *)account accountType:(AccountType)type password:(NSString *)password code:(NSString *)code verify:(void (^)(VerifyError error))verify success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    [LoginWork postWithURL:URL_Forget action:ActionTypeForget account:account type:type password:password newPassword:nil code:code extension:nil verify:verify success:success failure:failure];
}

+(void)changePwdWithAccount:(NSString *)account accountType:(AccountType)type password:(NSString *)password newPassword:(NSString *)newpassword verify:(void (^)(VerifyError error))verify success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    [LoginWork postWithURL:URL_ChangePwd action:ActionTypeChangePwd account:account type:type password:password newPassword:newpassword code:nil extension:nil verify:verify success:success failure:failure];
}

+(void)changeInfoWithAccount:(NSString *)account accountType:(AccountType)type password:(NSString *)password extension:(NSDictionary *)ext verify:(void (^)(VerifyError))verify success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [LoginWork postWithURL:URL_ChangeInfo action:ActionTypeChangeInfo account:account type:type password:password newPassword:nil code:nil extension:ext verify:verify success:success failure:failure];
}

+(void)getNoteCodeWithPhone:(NSString *)phone extension:(NSDictionary *)ext verify:(void (^)(VerifyError))verify success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [LoginWork postWithURL:URL_Code2Note action:ActionTypeCode2Node account:phone type:AccountTypePhone password:nil newPassword:nil code:nil extension:ext verify:verify success:success failure:failure];
}

+(void)getImageCodeWithAccount:(NSString *)account accountType:(AccountType)type verify:(void (^)(VerifyError))verify success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [LoginWork postWithURL:URL_Code2Image action:ActionTypeCode2Image account:account type:type password:nil newPassword:nil code:nil extension:nil verify:verify success:success failure:failure];
}

+(void)verifyCodeWithAccount:(NSString *)account accountType:(AccountType)type code:(NSString *)code extension:(NSDictionary *)ext verify:(void (^)(VerifyError))verify success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [LoginWork postWithURL:URL_VerifyCode action:ActionTypeVerifyCode account:account type:type password:nil newPassword:nil code:code extension:ext verify:verify success:success failure:failure];
}

#pragma mark -内部方法-


#pragma mark -验证模块

+(BOOL)verifyWithAccount:(NSString *)account type:(AccountType)type
{
    if (account.length<=0||!account) {
        return NO;
    }
    NSDictionary *dic =@{@(AccountTypePhone):@([LoginWork verifyAnyWithMatches:Match_isPhone object:account]),
                         @(AccountTypeEmail):@([LoginWork verifyAnyWithMatches:Match_isEmail object:account]),
                         @(AccountTypeUsername):@([LoginWork verifyAnyWithMatches:Match_isUserName object:account])};
    
    return [dic[@(type)] boolValue];
}

+(BOOL)verifyWithPassword:(NSString *)password action:(ActionType)action
{
    if (action ==ActionTypeLoginOut &&!password) {
        return YES;
    }
    if (action ==ActionTypeCode2Node &&!password) {
        return YES;
    }
    if (action ==ActionTypeCode2Image &&!password) {
        return YES;
    }
    if (action ==ActionTypeLoginIn4Code &&!password) {
        return YES;
    }
    if (action ==ActionTypeVerifyCode &&!password) {
        return YES;
    }
    if (password.length <=0 || !password) {
        return NO;
    }
    return [LoginWork verifyAnyWithMatches:Match_isPassword object:password];
}

+(BOOL)verifyWithCode:(NSString *)code
{
    if (code.length<=0) {
        return NO;
    }
    return [LoginWork verifyAnyWithMatches:Match_isCode object:code];
}

//公用验证方法
+(BOOL)verifyAnyWithMatches:(NSString *)matches object:(id)object
{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",matches];
    return [pre evaluateWithObject:object];
}

#pragma mark -网络模块
+(void)postWithURL:(NSString *)url action:(ActionType)action account:(NSString *)account type:(AccountType)type password:(NSString *)password newPassword:(NSString *)newpassword  code:(NSString *)code extension:(NSDictionary *)ext verify:(void (^)(VerifyError error))verify success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    //1.验证账号是否正确
    BOOL isok = [LoginWork verifyWithAccount:account type:type];
    if (!isok) {
        if (verify) {
            verify(VerifyErrorAccount);
        }
        return;
    }
    //2.验证密码是否正确
    isok =[LoginWork verifyWithPassword:password action:action];
    if (!isok) {
        if (verify) {
            verify(VerifyErrorPassword);
        }
        return;
    }
    //3.验证验证码是否正确
    if (code) {
        isok =[LoginWork verifyWithCode:code];
        if (!isok) {
            if (verify) {
                verify(VerifyErrorCode);
            }
            return;
        }
    }
    //4.验证新密码是否正确
    if (newpassword) {
        isok =[LoginWork verifyWithPassword:password action:action];
        if (!isok) {
            if (verify) {
                verify(VerifyErrorNewPassword);
            }
            return;
        }
    }
    //other:检查昵称，头像地址等
    
    //5.处理数据为空
    account =account ? :@"";
    password =password ? :@"";
    newpassword =newpassword ? :@"";
    code =code ? :@"";
    //6.密码加密
    LoginCustomManager *mgr =[LoginCustomManager shareMangaer];
    NSAssert(mgr.encodeBK,@"请自定义加密encodeBK!");
    if (mgr.encodeBK) {//这里替换成自己的加密方式
        NSMutableDictionary *dic =[NSMutableDictionary dictionary];
        [dic setValue:password forKey:Params_Password];
        [dic setValue:newpassword forKey:Params_NewPassword];
        mgr.encodeBK(dic, ^(NSDictionary *encodedic) {
            //这里获取到自定义加密后的数据
            
            //7.发送请求
            NSMutableDictionary *params =[NSMutableDictionary dictionary];
            [params setObject:account forKey:Params_Account];
            [params setObject:encodedic[Params_Password] forKey:Params_Password];
            [params setObject:encodedic[Params_NewPassword] forKey:Params_NewPassword];
            [params setObject:code forKey:Params_Code];
            if (ext) {
                [params addEntriesFromDictionary:ext];
            }
            NSAssert(mgr.networkBK, @"请自定义网络networkBK!");
            if (mgr.networkBK) {
                mgr.networkBK(url, params, success, failure);
            }
        });
    }
}

@end

@implementation LoginTimer

-(void)startTime:(int)time timeBackBlock:(void (^)(int))timeBK
{
    __block NSInteger timeOut=time;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeOut<=0){
            dispatch_source_cancel(_timer);
            _timer =nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (timeBK) {
                    timeBK(0);
                }
            });
        }else{
            int seconds = timeOut % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (timeBK) {
                    timeBK(seconds);
                }
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

-(void)stopTime
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer =nil;
    }
}


@end

static LoginCustomManager *customMgr =nil;

@implementation LoginCustomManager

+(id)shareMangaer
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (customMgr == nil) {
            customMgr = [[LoginCustomManager alloc] init];
        }
    });
    return customMgr;
}

@end
