# ZHNCountDownView
一句话搞定短信的倒计时功能

#### 如何使用

+ 1.把DTCountDownView文件夹导入到你的项目里


+ 2.一句话来创建一个倒计时view，具体逻辑如下面的伪代码。然后把这个view加到具体的位置就👌了。

```
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
```

+ 3.如果你需要在开始和结束的时候做一些特殊的操作，当然也没问题。我这里还提供了一个方法供你选择。
```
+ (ZHNCountDownView *)ZHN_countDownWithStartTitle:(NSString *)startTitle
                                    reloadTitle:(NSString *)reloadTitle
                              countingFormatter:(NSString *)fromatter
                                   Timeinterval:(int)time
                                        handler:(ZHNCountDownHandleBlock)handle
                           countDownStartAction:(ZHNCountDownStartBlock)coutDownStartAction
                             countdownEndAction:(ZHNCountDownEndBlock)countDownEndAction;
```

+ 4.如果你还有一些字体大小等等的需求，这里也提供了一些参数供你修改。

##### have fun ~



