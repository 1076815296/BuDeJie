//
//  ZWJLoginViewController.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/7.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJLoginViewController.h"
#import "ZWJLogInRegisterView.h"

/*
    复杂界面
    1.划分层次结构,按业务逻辑划分
    2.3层,每一个结构对应一个占位视图
    3.一个结构一个结构去做
 */

@interface ZWJLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *longinRegisterView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadCons;


@end

@implementation ZWJLoginViewController




- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickRegister:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    self.leadCons.constant = self.leadCons.constant == 0?-ZWJScreenW : 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
        xib使用注意点
        1. 一个控件从xib加载,需要去设置尺寸? 默认根xib尺寸已有
        2. 一个控件从xib加载,需要再次去确定尺寸
        3. 在viewDidLoad中,去设置尺寸,参照为屏幕不会有问题,参考控制器的view的子控件就会有问题
        3.1 在viewDidLoad中这个时候,还不会执行约束
        3.2 viewDidLayoutSubviews
     */
    ZWJLogInRegisterView *loginVC = [ZWJLogInRegisterView LogInView];
    
    [self.longinRegisterView addSubview:loginVC];
    
    
    ZWJLogInRegisterView *registerVC = [ZWJLogInRegisterView RegisterView];
    
    
    [self.longinRegisterView addSubview:registerVC];
    
    
    
    
}

//计算好所有子控件的位置完成的时候调用
- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    //设置登录
    ZWJLogInRegisterView *loginVC = self.longinRegisterView.subviews[0];
    loginVC.frame = CGRectMake(0, 0, self.longinRegisterView.frame.size.width *0.5, self.longinRegisterView.frame.size.height);
    
    //设置注册
    ZWJLogInRegisterView *registerVC = self.longinRegisterView.subviews[1];
    registerVC.frame = CGRectMake(self.longinRegisterView.frame.size.width *0.5, 0, self.longinRegisterView.frame.size.width *0.5, self.longinRegisterView.frame.size.height);
    
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
