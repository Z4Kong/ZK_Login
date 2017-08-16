//
//  LoginModuleConstant.m
//  Module_Login
//
//  Created by ios on 2017/6/28.
//  Copyright © 2017年 qian. All rights reserved.
//
#import <Foundation/Foundation.h>

//NSString * const URL_LoginIn4Pwd    =@"http://192.168.0.54/app/Login/login4pwd.php";
//NSString * const URL_LoginIn4Code   =@"http://192.168.0.54/app/Login/login4code.php";
//NSString * const URL_LoginOut       =@"http://192.168.0.54/app/Login/loginout.php";
//NSString * const URL_Register       =@"http://192.168.0.54/app/Login/register.php";
//NSString * const URL_Forget         =@"http://192.168.0.54/app/Login/forget.php";
//NSString * const URL_ChangePwd      =@"http://192.168.0.54/app/Login/changepwd.php";
//NSString * const URL_ChangeInfo     =@"http://192.168.0.54/app/Login/changeinfo.php";
//NSString * const URL_Code2Note      =@"http://192.168.0.54/app/Login/code2note.php";
//NSString * const URL_Code2Image     =@"http://192.168.0.54/app/Login/code2image.php";
//NSString * const URL_VerifyCode     =@"http://192.168.0.54/app/Login/verifycode.php";

NSString * const URL_LoginIn4Pwd    =@"http://192.168.0.20:8888/Account/Login";
NSString * const URL_LoginIn4Code   =@"http://192.168.0.20:8888/Account/LoginUseSMS";
NSString * const URL_LoginOut       =@"http://192.168.0.20:8888/Account/LoginOut";
NSString * const URL_Register       =@"http://192.168.0.20:8888/Account/SetPassword";
NSString * const URL_Forget         =@"http://192.168.0.20:8888/Account/SetPassword";
NSString * const URL_ChangePwd      =@"";
NSString * const URL_ChangeInfo     =@"";
NSString * const URL_Code2Note      =@"http://192.168.0.20:8888/Common/PostSMS";
NSString * const URL_Code2Image     =@"";
NSString * const URL_VerifyCode     =@"";
NSString * const URL_VerifyRegister =@"http://192.168.0.20:8888/Account/Register";
NSString * const URL_VerifyForget   =@"http://192.168.0.20:8888/Account/ForgetPassword";

NSString * const Match_isPhone      =@"^1[3|4|5|7|8][0-9]\\d{8}$";
NSString * const Match_isEmail      =@"^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$";
NSString * const Match_isUserName   =@"/[a-zA-Z0-9_]{3,16}/";
NSString * const Match_isPassword   =@"^(?![0-9]+$)(?![a-zA-Z]+$)[\\x20-\\x7e]{6,16}$";
NSString * const Match_isCode       =@"^[0-9]{6}$";

NSString * const Params_Account     =@"telephoneNumber";
NSString * const Params_Password    =@"password";
NSString * const Params_NewPassword =@"newpassword";
NSString * const Params_Code        =@"sms";

NSString * const Notification_PlayTime =@"PlayTime";
