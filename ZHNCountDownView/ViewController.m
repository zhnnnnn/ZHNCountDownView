//
//  ViewController.m
//  ZHNCountDownView
//
//  Created by zhn on 2017/7/19.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import "ViewController.h"
#import "ZHNCountDownView.h"

@interface ViewController ()
@property (nonatomic,strong) ZHNCountDownView *coutDownView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.coutDownView];
    self.coutDownView.frame = CGRectMake(50, 200, 200, 50);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ZHNCountDownView *)coutDownView {
    if (_coutDownView == nil) {
        _coutDownView = [ZHNCountDownView ZHN_countDownWithStartTitle:@"点击发送验证码" reloadTitle:@"重新获取验证码" countingFormatter:@"%d秒后重新获取" Timeinterval:10 handler:^BOOL{
//            正常的逻辑应该如下面的伪代码
//            if (正则校验短信不过) {
//                return NO;
//            }
            
//            [xxxnetwork sendSmsCodeSuccess^{
//                if (判断成功了) {
//                    DT_Start_Counting;
//                }
//            }error^{
//            
//            }];
//            return NO;
            
            
            
//            return yes 为了测试倒计时
            return YES;
        }];
    }
    _coutDownView.backgroundColor = [UIColor redColor];
    return _coutDownView;
}

@end
