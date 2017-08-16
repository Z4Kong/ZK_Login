//
//  LoginPresenter.m
//  Module_Login
//
//  Created by ios on 2017/6/22.
//  Copyright © 2017年 qian. All rights reserved.
//

#import "LoginPresenter.h"

@implementation LoginPresenter


-(instancetype)initWithDelegate:(id)delegate
{
    self =[super self];
    if (self) {
        self.delegate =delegate;
        self.datasource =delegate;
        self.errorDic = kErrorDic;
        self.actionDic = kActionDic;
        self.messageDic = kMessageDic;
        self.timer =[[LoginTimer alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playingWithTime:) name:Notification_PlayTime object:nil];
    }
    return self;
}


-(void)loginIn4Pwd
{
    [self beginWithActionType:ActionTypeLoginIn4Pwd];
    
    __block typeof(self) weakself =self;
    [LoginWork loginInWithAccount:[self.datasource loginModuleAccountWithPresenter:self actionType:ActionTypeLoginIn4Pwd] accountType:[self.datasource loginModuleAccountTypeWithPresenter:self actionType:ActionTypeLoginIn4Pwd] password:[self.datasource loginModulePasswordWithPresenter:self actionType:ActionTypeLoginIn4Pwd] verify:^(VerifyError error) {
        [weakself verifyWithError:error];
    } success:^(id responseObj) {
        [weakself successWithActionType:ActionTypeLoginIn4Pwd response:responseObj];
    } failure:^(NSError *error) {
        [weakself failureWithActionType:ActionTypeLoginIn4Pwd response:getErrorParamsByError(error)];
    }];
}

-(void)loginIn4Code
{
    [self beginWithActionType:ActionTypeLoginIn4Code];
    
    __block typeof(self) weakself =self;
    [LoginWork loginInWithAccount:[self.datasource loginModuleAccountWithPresenter:self actionType:ActionTypeLoginIn4Code] accountType:[self.datasource loginModuleAccountTypeWithPresenter:self actionType:ActionTypeLoginIn4Code] code:[self.datasource loginModuleCodeWithPresenter:self actionType:ActionTypeLoginIn4Code] verify:^(VerifyError error) {
        [weakself verifyWithError:error];
    } success:^(id responseObj) {
        [weakself successWithActionType:ActionTypeLoginIn4Code response:responseObj];
    } failure:^(NSError *error) {
        [weakself failureWithActionType:ActionTypeLoginIn4Code response:getErrorParamsByError(error)];
    }];
}

-(void)loginOut
{
    [self beginWithActionType:ActionTypeLoginOut];
    
    __block typeof(self) weakself =self;
    [LoginWork loginOutWithAccount:[self.datasource loginModuleAccountWithPresenter:self actionType:ActionTypeLoginOut] accountType:[self.datasource loginModuleAccountTypeWithPresenter:self actionType:ActionTypeLoginOut] verify:^(VerifyError error) {
        [weakself verifyWithError:error];
    } success:^(id responseObj) {
        [weakself successWithActionType:ActionTypeLoginOut response:responseObj];
    } failure:^(NSError *error) {
        [weakself failureWithActionType:ActionTypeLoginOut response:getErrorParamsByError(error)];
    }];
}

-(void)register4
{
    [self beginWithActionType:ActionTypeRegister];
    
    __block typeof(self) weakself =self;
    [LoginWork registerWithAccount:[self.datasource loginModuleAccountWithPresenter:self actionType:ActionTypeRegister] accountType:[self.datasource loginModuleAccountTypeWithPresenter:self actionType:ActionTypeRegister] password:[self.datasource loginModulePasswordWithPresenter:self actionType:ActionTypeRegister] code:[self.datasource loginModuleCodeWithPresenter:self actionType:ActionTypeRegister] extension:[self.datasource loginModuleExtensionWithPresenter:self actionType:ActionTypeRegister] verify:^(VerifyError error) {
        [weakself verifyWithError:error];
    } success:^(id responseObj) {
        [weakself successWithActionType:ActionTypeRegister response:responseObj];
    } failure:^(NSError *error) {
        [weakself failureWithActionType:ActionTypeRegister response:getErrorParamsByError(error)];
    }];
}

-(void)forgetPwd
{
    [self beginWithActionType:ActionTypeForget];
    
    __block typeof(self) weakself =self;
    [LoginWork forgetWithAccount:[self.datasource loginModuleAccountWithPresenter:self actionType:ActionTypeForget] accountType:[self.datasource loginModuleAccountTypeWithPresenter:self actionType:ActionTypeForget] password:[self.datasource loginModulePasswordWithPresenter:self actionType:ActionTypeForget] code:[self.datasource loginModuleCodeWithPresenter:self actionType:ActionTypeForget] verify:^(VerifyError error) {
        [weakself verifyWithError:error];
    } success:^(id responseObj) {
        [weakself successWithActionType:ActionTypeForget response:responseObj];
    } failure:^(NSError *error) {
        [weakself failureWithActionType:ActionTypeForget response:getErrorParamsByError(error)];
    }];
}

-(void)changePwd
{
    [self beginWithActionType:ActionTypeChangePwd];
    
    __block typeof(self) weakself =self;
    [LoginWork changePwdWithAccount:[self.datasource loginModuleAccountWithPresenter:self actionType:ActionTypeChangePwd] accountType:[self.datasource loginModuleAccountTypeWithPresenter:self actionType:ActionTypeChangePwd] password:[self.datasource loginModulePasswordWithPresenter:self actionType:ActionTypeChangePwd] newPassword:[self.datasource loginModuleNewPasswordWithPresenter:self actionType:ActionTypeChangePwd] verify:^(VerifyError error) {
        [weakself verifyWithError:error];
    } success:^(id responseObj) {
        [weakself successWithActionType:ActionTypeChangePwd response:responseObj];
    } failure:^(NSError *error) {
        [weakself failureWithActionType:ActionTypeChangePwd response:getErrorParamsByError(error)];
    }];
}

-(void)changeInfo
{
    [self beginWithActionType:ActionTypeChangeInfo];
    
    __block typeof(self) weakself =self;
    [LoginWork changeInfoWithAccount:[self.datasource loginModuleAccountWithPresenter:self actionType:ActionTypeChangeInfo] accountType:[self.datasource loginModuleAccountTypeWithPresenter:self actionType:ActionTypeChangeInfo] password:[self.datasource loginModulePasswordWithPresenter:self actionType:ActionTypeChangeInfo] extension:[self.datasource loginModuleExtensionWithPresenter:self actionType:ActionTypeChangeInfo] verify:^(VerifyError error) {
        [weakself verifyWithError:error];
    } success:^(id responseObj) {
        [weakself successWithActionType:ActionTypeChangeInfo response:responseObj];
    } failure:^(NSError *error) {
        [weakself failureWithActionType:ActionTypeChangeInfo response:getErrorParamsByError(error)];
    }];
}

-(void)getNoteCodeWithTime:(int)time
{
    [self beginWithActionType:ActionTypeCode2Node];
    //验证账号是否正确
    BOOL isok = [LoginWork verifyWithAccount:[self.datasource loginModuleAccountWithPresenter:self actionType:ActionTypeCode2Node] type:[self.datasource loginModuleAccountTypeWithPresenter:self actionType:ActionTypeCode2Node]];
    if (!isok) {
        [self verifyWithError:VerifyErrorAccount];
        return;
    }
    //倒计时
    if (!_timer.timer) {
        [_timer startTime:time timeBackBlock:^(int time) {
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_PlayTime object:@(time)];
        }];
    }
    
    __block typeof(self) weakself =self;
    [LoginWork getNoteCodeWithPhone:[self.datasource loginModuleAccountWithPresenter:self actionType:ActionTypeCode2Node] extension:[self.datasource loginModuleExtensionWithPresenter:self actionType:ActionTypeCode2Node] verify:^(VerifyError error) {
        [weakself verifyWithError:error];
    } success:^(id responseObj) {
        [weakself successWithActionType:ActionTypeCode2Node response:responseObj];
    } failure:^(NSError *error) {
        [weakself failureWithActionType:ActionTypeCode2Node response:getErrorParamsByError(error)];
    }];
}

-(void)getImageCodeWithTime:(int)time
{
    [self beginWithActionType:ActionTypeCode2Image];
    //验证账号是否正确
    BOOL isok = [LoginWork verifyWithAccount:[self.datasource loginModuleAccountWithPresenter:self actionType:ActionTypeCode2Node] type:[self.datasource loginModuleAccountTypeWithPresenter:self actionType:ActionTypeCode2Node]];
    if (!isok) {
        [self verifyWithError:VerifyErrorAccount];
        return;
    }
    //倒计时
    if (!_timer.timer) {
        [_timer startTime:time timeBackBlock:^(int time) {
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_PlayTime object:@(time)];
        }];
    }
    
    __block typeof(self) weakself =self;
    [LoginWork getImageCodeWithAccount:[self.datasource loginModuleAccountWithPresenter:self actionType:ActionTypeCode2Image] accountType:[self.datasource loginModuleAccountTypeWithPresenter:self actionType:ActionTypeCode2Image] verify:^(VerifyError error) {
        [weakself verifyWithError:error];
    } success:^(id responseObj) {
        [weakself successWithActionType:ActionTypeCode2Image response:responseObj];
    } failure:^(NSError *error) {
        [weakself failureWithActionType:ActionTypeCode2Image response:getErrorParamsByError(error)];
    }];
}

-(void)verifyCode
{
    [self beginWithActionType:ActionTypeVerifyCode];
    
    __block typeof(self) weakself =self;
    [LoginWork verifyCodeWithAccount:[self.datasource loginModuleAccountWithPresenter:self actionType:ActionTypeVerifyCode] accountType:[self.datasource loginModuleAccountTypeWithPresenter:self actionType:ActionTypeVerifyCode] code:[self.datasource loginModuleCodeWithPresenter:self actionType:ActionTypeVerifyCode] extension:[self.datasource loginModuleExtensionWithPresenter:self actionType:ActionTypeVerifyCode] verify:^(VerifyError error) {
        [weakself verifyWithError:error];
    } success:^(id responseObj) {
        [weakself successWithActionType:ActionTypeVerifyCode response:responseObj];
    } failure:^(NSError *error) {
        [weakself failureWithActionType:ActionTypeVerifyCode response:getErrorParamsByError(error)];
    }];
}

#pragma mark - private

-(void)playingWithTime:(NSNotification *)notification
{
    int time =[notification.object intValue];
    if ([self.delegate respondsToSelector:@selector(loginModulePresenter:playingWithTime:)]) {
         [self.delegate loginModulePresenter:self playingWithTime:time];
    }
}

-(void)beginWithActionType:(ActionType)action
{
    [self.delegate loginModulePresenter:self beginWithActionType:action];
}

-(void)verifyWithError:(VerifyError)error
{
    [self.delegate loginModulePresenter:self verifyWithVerifyError:error message:getMessageStrByType(error)];
}

-(void)successWithActionType:(ActionType)action response:(id )responseObj
{
    [self.delegate loginModulePresenter:self endSuccessWithActionType:action response:responseObj];
}

-(void)failureWithActionType:(ActionType)action response:(id )responseObj
{
    [self.delegate loginModulePresenter:self endFailureWithActionType:action response:responseObj];
}

-(void)dealloc
{
    [_timer stopTime];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//TODO-预留
-(NSDictionary *)errorParamsByErrorCode:(NSError *)error
{
    NSDictionary *params =@{@"msg":getErrorStrByType(error.code)};
    return params;
}
@end
