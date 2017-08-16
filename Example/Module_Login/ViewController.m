//
//  ViewController.m
//  Module_Login
//
//  Created by qian on 17/6/20.
//  Copyright © 2017年 qian. All rights reserved.
//

#import "ViewController.h"
#import "LoginModule.h"

#import <SVProgressHUD.h>
#import <UIView+Toast.h>


@interface ViewController ()<LoginPresenterDataSource,LoginPresenterDelegate>
@property (nonatomic , strong) LoginPresenter *pre;
@property (nonatomic , copy) NSString *code;
@property (nonatomic , strong) UIButton *loginBtn;

@property (nonatomic , copy) NSString *account;
@property (nonatomic , copy) NSString *password;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pre =[[LoginPresenter alloc] initWithDelegate:self];
    
//    _code =@"123456";
//    [_pre verifyCode];
    
    //    [_pre loginIn4Pwd];
    
        [_pre getNoteCodeWithTime:60];
    
//    [_pre getImageCodeWithTime:60];
    //
    //    [_pre loginIn4Code];
    //    [_pre register4];
    //    [_pre forgetPwd];
    //    [_pre changePwd];
    //    [_pre changeInfo];
    
    
    //下面是列举的方法
    
    //    NSString *account = [_pre getAccount];
    //    NSString *password =[_pre getPassword];
    //    Account *accountInfo = [_pre getAccountInfo];
    //    BOOL isExist =[_pre isExistAccount];
    //    [_pre removeAccount];
    
}

#pragma mark - LoginModuleDelegate

-(void)loginModulePresenter:(LoginPresenter *)presenter beginWithActionType:(ActionType)action
{
    self.loginBtn.userInteractionEnabled =NO;
    NSLog(@"========================开始 %@ 开始========================",getActionStrByType(action));
}

-(void)loginModulePresenter:(LoginPresenter *)presenter endSuccessWithActionType:(ActionType)action response:(NSDictionary *)responseObj
{
    
    [self.view makeToast:responseObj[@"msg"] duration:1.0 position:CSToastPositionCenter];
    self.loginBtn.userInteractionEnabled =YES;
    switch (action) {
        case ActionTypeCode2Node:
            _code =@"123456";
            break;
        case ActionTypeLoginIn4Pwd:
            //保存用户信息
//            [Account saveAccount:_account password:_password modelDic:responseObj[@"user"]];
            break;
        default:
            break;
    }
    
    NSLog(@"========================成功 %@ 成功========================",getActionStrByType(action));
}

-(void)loginModulePresenter:(LoginPresenter *)presenter endFailureWithActionType:(ActionType)action response:(NSDictionary *)responseObj
{
    NSLog(@"网络失败原因::::%d,%@",action,responseObj[@"msg"]);
    
    [self.view makeToast:responseObj[@"msg"] duration:1.0 position:CSToastPositionCenter];
    self.loginBtn.userInteractionEnabled =YES;
    
    NSLog(@"========================失败 %@ 失败========================",getActionStrByType(action));
}

-(void)loginModulePresenter:(LoginPresenter *)presenter playingWithTime:(int)time
{
    NSLog(@"倒计时::::%d",time);
}

-(void)loginModulePresenter:(LoginPresenter *)presenter verifyWithVerifyError:(VerifyError)error message:(NSString *)msg
{
    NSLog(@"验证错误原因::::%@",msg);
    [self.view makeToast:msg duration:1.0 position:CSToastPositionCenter];
    NSLog(@"========================验证失败 %@ 验证失败========================",getMessageStrByType(error));
}

#pragma mark - LoginModuleDataSource

-(NSString *)loginModuleAccountWithPresenter:(LoginPresenter *)presenter actionType:(ActionType)action
{
    return @"15967106725";
}

-(AccountType)loginModuleAccountTypeWithPresenter:(LoginPresenter *)presenter actionType:(ActionType)action
{
    return AccountTypePhone;
}

-(NSString *)loginModulePasswordWithPresenter:(LoginPresenter *)presenter actionType:(ActionType)action
{
    return @"qian110";
}

-(NSString *)loginModuleNewPasswordWithPresenter:(LoginPresenter *)presenter actionType:(ActionType)action
{
    return @"qian120";
}

-(NSString *)loginModuleCodeWithPresenter:(LoginPresenter *)presenter actionType:(ActionType)action
{
    return _code;
}

-(NSDictionary *)loginModuleExtensionWithPresenter:(LoginPresenter *)presenter actionType:(ActionType)action
{
    NSDictionary *dic =@{@"nickname":@"大便",@"imgurl":@"123"};
    return dic;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
