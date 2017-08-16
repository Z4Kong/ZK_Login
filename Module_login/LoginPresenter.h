//
//  LoginPresenter.h
//  Module_Login
//
//  Created by ios on 2017/6/22.
//  Copyright © 2017年 qian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModuleConstant.h"
#import "LoginWork.h"

@class LoginPresenter;
@protocol LoginPresenterDelegate <NSObject>



/**
 验证失败提示

 @param presenter self
 @param error 验证错误类型
 @param msg 消息
 */
-(void)loginModulePresenter:(LoginPresenter *)presenter verifyWithVerifyError:(VerifyError)error  message:(NSString *)msg;

/**
 开始行动之前

 @param presenter self
 @param action 动作类型
 */
-(void)loginModulePresenter:(LoginPresenter *)presenter beginWithActionType:(ActionType)action;

/**
 成功行动之后

 @param presenter self
 @param action 动作类型
 @param responseObj 返回参数
 */
-(void)loginModulePresenter:(LoginPresenter *)presenter endSuccessWithActionType:(ActionType)action response:(id )responseObj;

/**
 失败行动之后

 @param presenter self
 @param action 动作类型
 @param responseObj 返回参数
 */
-(void)loginModulePresenter:(LoginPresenter *)presenter endFailureWithActionType:(ActionType)action response:(id )responseObj;


@optional

/**
 倒计时回调

 @param presenter self
 @param time 时间
 */
-(void)loginModulePresenter:(LoginPresenter *)presenter playingWithTime:(int)time;

/**
 toast提示
 
 @param presenter self
 @param msg 提示的消息
 */
-(void)loginModulePresenter:(LoginPresenter *)presenter toastMessage:(NSString *)msg;


@end

@protocol LoginPresenterDataSource <NSObject>


/**
 获取账号参数

 @param presenter self
 @return 账号
 */
-(NSString *)loginModuleAccountWithPresenter:(LoginPresenter *)presenter actionType:(ActionType)action;

/**
 获取账号类型参数

 @param presenter self
 @return 账号类型
 */
-(AccountType)loginModuleAccountTypeWithPresenter:(LoginPresenter *)presenter actionType:(ActionType)action;

@optional

/**
 获取密码参数

 @param presenter self
 @return 密码
 */
-(NSString *)loginModulePasswordWithPresenter:(LoginPresenter *)presenter actionType:(ActionType)action;

/**
 获取新密码参数

 @param presenter self
 @return 新密码
 */
-(NSString *)loginModuleNewPasswordWithPresenter:(LoginPresenter *)presenter actionType:(ActionType)action;

/**
 获取验证码参数

 @param presenter self
 @return 验证码
 */
-(NSString *)loginModuleCodeWithPresenter:(LoginPresenter *)presenter actionType:(ActionType)action;

/**
 获取扩展数据

 @param presenter self
 @return 扩展数据
 */
-(NSDictionary *)loginModuleExtensionWithPresenter:(LoginPresenter *)presenter actionType:(ActionType)action;

@end

@interface LoginPresenter : NSObject

@property (nonatomic , assign) id<LoginPresenterDelegate> delegate;
@property (nonatomic , assign) id<LoginPresenterDataSource> datasource;

@property (nonatomic , strong) LoginTimer *timer;

/**
 *  错误编码字典
 */
@property (nonatomic , strong) NSDictionary *errorDic;


/**
    动作字符串数组
 */
@property (nonatomic , strong) NSDictionary *actionDic;


/**
    消息提示数组
 */
@property (nonatomic , strong) NSDictionary *messageDic;

/**
 初始化

 @param delegate 代理类
 @return self
 */
-(instancetype)initWithDelegate:(id)delegate;

/**
 密码登录
 */
-(void)loginIn4Pwd;

/**
 验证码登录
 */
-(void)loginIn4Code;

/**
 退出登录
 */
-(void)loginOut;

/**
 注册
 */
-(void)register4;

/**
 忘记密码
 */
-(void)forgetPwd;

/**
 修改密码
 */
-(void)changePwd;

/**
 修改信息
 */
-(void)changeInfo;

/**
 获取短信验证码

 @param time 倒计时时间
 */
-(void)getNoteCodeWithTime:(int)time;

/**
 获取图片验证码

 @param time 倒计时时间
 */
-(void)getImageCodeWithTime:(int)time;


/**
 检验验证码接口
 */
-(void)verifyCode;

@end
