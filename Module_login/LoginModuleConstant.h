//
//  LoginModuleConstant.h
//  Module_Login
//
//  Created by ios on 2017/6/28.
//  Copyright © 2017年 qian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    AccountTypePhone,
    AccountTypeEmail,
    AccountTypeUsername
}AccountType;

typedef enum{
    ActionTypeLoginIn4Pwd,
    ActionTypeLoginIn4Code,
    ActionTypeLoginOut,
    ActionTypeRegister,
    ActionTypeForget,
    ActionTypeChangePwd,
    ActionTypeChangeInfo,
    ActionTypeCode2Node,
    ActionTypeCode2Image,
    ActionTypeVerifyCode
}ActionType;

typedef enum{
    VerifyErrorAccount,
    VerifyErrorPassword,
    VerifyErrorNewPassword,
    VerifyErrorCode,
    VerifyErrorOther
}VerifyError;

FOUNDATION_EXPORT NSString * const URL_LoginIn4Pwd;
FOUNDATION_EXPORT NSString * const URL_LoginIn4Code;
FOUNDATION_EXPORT NSString * const URL_LoginOut;
FOUNDATION_EXPORT NSString * const URL_Register;
FOUNDATION_EXPORT NSString * const URL_Forget;
FOUNDATION_EXPORT NSString * const URL_ChangePwd;
FOUNDATION_EXPORT NSString * const URL_ChangeInfo;
FOUNDATION_EXPORT NSString * const URL_Code2Note;
FOUNDATION_EXPORT NSString * const URL_Code2Image;
FOUNDATION_EXPORT NSString * const URL_VerifyCode;

FOUNDATION_EXPORT NSString * const Match_isPhone;
FOUNDATION_EXPORT NSString * const Match_isEmail;
FOUNDATION_EXPORT NSString * const Match_isUserName;
FOUNDATION_EXPORT NSString * const Match_isPassword;
FOUNDATION_EXPORT NSString * const Match_isCode;

//0.1.1-todo:添加静态字符串
FOUNDATION_EXPORT NSString * const Params_Account;
FOUNDATION_EXPORT NSString * const Params_Password;
FOUNDATION_EXPORT NSString * const Params_NewPassword;
FOUNDATION_EXPORT NSString * const Params_Code;

FOUNDATION_EXPORT NSString * const Notification_PlayTime;


#define getActionStrByType(type) kActionDic[@(type)]

#define kActionDic @{@(ActionTypeLoginIn4Pwd):@"ActionTypeLoginIn4Pwd",\
                     @(ActionTypeLoginIn4Code):@"ActionTypeLoginIn4Code",\
                     @(ActionTypeLoginOut):@"ActionTypeLoginOut",\
                     @(ActionTypeRegister):@"ActionTypeRegister",\
                     @(ActionTypeForget):@"ActionTypeForget",\
                     @(ActionTypeChangePwd):@"ActionTypeChangePwd",\
                     @(ActionTypeChangeInfo):@"ActionTypeChangeInfo",\
                     @(ActionTypeCode2Node):@"ActionTypeCode2Node",\
                     @(ActionTypeCode2Image):@"ActionTypeCode2Image",\
                     @(ActionTypeVerifyCode):@"ActionTypeVerifyCode"}

#define getMessageStrByType(type) kMessageDic[@(type)]
#define kMessageDic @{@(VerifyErrorAccount):@"账号填写错误！",\
                      @(VerifyErrorPassword):@"密码填写错误！",\
                      @(VerifyErrorNewPassword):@"新密码填写错误！",\
                      @(VerifyErrorCode):@"验证码填写错误！",\
                      @(VerifyErrorOther):@"其他填写错误！"}


//获取网络错误字典
#define getErrorParamsByError(error) @{@"msg":getErrorStrByType(error.code)}

#define getErrorStrByType(type) kErrorDic[@(type)]
#define kErrorDic @{@(NSURLErrorUnknown):@"未知错误",\
                    @(NSURLErrorCancelled):@"网络取消",\
                    @(NSURLErrorBadURL):@"链接无效",\
                    @(NSURLErrorTimedOut):@"请求超时",\
                    @(NSURLErrorUnsupportedURL):@"链接不支持",\
                    @(NSURLErrorCannotFindHost):@"未能发现主机地址",\
                    @(NSURLErrorCannotConnectToHost):@"未能连接上主机",\
                    @(NSURLErrorNetworkConnectionLost):@"网络连接丢失",\
                    @(NSURLErrorDNSLookupFailed):@"DNS解析错误",\
                    @(NSURLErrorHTTPTooManyRedirects):@"请求重定向",\
                    @(NSURLErrorResourceUnavailable):@"资源获取失败",\
                    @(NSURLErrorNotConnectedToInternet):@"未能连接上网络",\
                    @(NSURLErrorRedirectToNonExistentLocation):@"重定向不存在的地址",\
                    @(NSURLErrorBadServerResponse):@"服务器返回失败",\
                    @(NSURLErrorUserCancelledAuthentication):@"用户取消授权",\
                    @(NSURLErrorUserAuthenticationRequired):@"用户未授权",\
                    @(NSURLErrorZeroByteResource):@"资源为空",\
                    @(NSURLErrorCannotDecodeRawData):@"未能解码原始数据",\
                    @(NSURLErrorCannotDecodeContentData):@"未能解码内容数据",\
                    @(NSURLErrorCannotParseResponse):@"未能解析返回数据",\
                    @(NSURLErrorAppTransportSecurityRequiresSecureConnection):@"必须加密传输",\
                    @(NSURLErrorFileDoesNotExist):@"文件不存在",\
                    @(NSURLErrorFileIsDirectory):@"文件是个目录",\
                    @(NSURLErrorNoPermissionsToReadFile):@"没有权限读取文件",\
                    @(NSURLErrorDataLengthExceedsMaximum):@"数据长度超过最大限制"}


