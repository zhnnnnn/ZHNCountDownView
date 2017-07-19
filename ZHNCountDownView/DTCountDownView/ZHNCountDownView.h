//
//  ZHNCountDownView.h
//
//  Created by zhn on 2017/5/13.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KZHNCountDownStartCountingNotification @"KZHNCountDownStartCountingNotification"
#define ZHN_Start_Counting [[NSNotificationCenter defaultCenter]postNotificationName:KZHNCountDownStartCountingNotification object:nil]
typedef BOOL(^ZHNCountDownHandleBlock)();
typedef void(^ZHNCountDownEndBlock)();
typedef void(^ZHNCountDownStartBlock)();
@interface ZHNCountDownView : UIView

/**
 生成倒计时view

 @param startTitle 未点击状态的文字
 @param reloadTitle 倒计时结束时的文字
 @param fromatter 倒计时执行中的文字的formatter 例如@"%d秒后重新获取"
 @param time 倒计时执行的秒数
 @param handle 点击的事件 (return YES代表开始倒计时,如果说你需要在获取到发送验证码成功再开始倒计时,你需要在请求成功的回调里 写上ZHN_Start_Counting这句话)
 @return 倒计时view
 */
+ (ZHNCountDownView *)ZHN_countDownWithStartTitle:(NSString *)startTitle
                                    reloadTitle:(NSString *)reloadTitle
                              countingFormatter:(NSString *)fromatter
                                   Timeinterval:(int)time
                                        handler:(ZHNCountDownHandleBlock)handle;

/**
 生成倒计时view
 
 @param startTitle 未点击状态的文字
 @param reloadTitle 倒计时结束时的文字
 @param fromatter 倒计时执行中的文字的formatter 例如@"%d秒后重新获取"
 @param time 倒计时执行的秒数
 @param handle 点击的事件
 @param coutDownStartAction 倒计时开始的时候需要的操作 (比如背景的改变)
 @param countDownEndAction 倒计时结束的时候需要的操作 (比如背景的改变)
 @return 倒计时view
 */
+ (ZHNCountDownView *)ZHN_countDownWithStartTitle:(NSString *)startTitle
                                    reloadTitle:(NSString *)reloadTitle
                              countingFormatter:(NSString *)fromatter
                                   Timeinterval:(int)time
                                        handler:(ZHNCountDownHandleBlock)handle
                           countDownStartAction:(ZHNCountDownStartBlock)coutDownStartAction
                             countdownEndAction:(ZHNCountDownEndBlock)countDownEndAction;

/**
 清空倒计时
 */
- (void)frozen;

/** 背景图片 */
@property (nonatomic,strong) UIImage *backgroundImage;
/** 标题字体颜色 */
@property (nonatomic,strong) UIColor *textColor;
/** 标题的字体大小 */
@property (nonatomic,strong) UIFont *textFont;
@end
