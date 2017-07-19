//
//  ZHNCountDownView.m
//
//  Created by zhn on 2017/5/13.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import "ZHNCountDownView.h"
#import "ZHNTimer.h"

@interface ZHNCountDownView()
@property (nonatomic,copy) NSString *reloaZHNitle;
@property (nonatomic,copy) NSString *countFormatter;
@property (nonatomic,copy) ZHNCountDownHandleBlock handle;
@property (nonatomic,copy) ZHNCountDownEndBlock countDownEndAction;
@property (nonatomic,copy) ZHNCountDownStartBlock countDownStartAction;
@property (nonatomic,strong) ZHNTimer *timer;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *backGroundImageView;
@property (nonatomic,assign) int needReloaZHNime;
@property (nonatomic,assign) int tempTime;
@property (nonatomic,assign) BOOL isCountDowning;
@end

@implementation ZHNCountDownView
#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.backGroundImageView];
        [self addSubview:self.titleLabel];
        UITapGestureRecognizer *clickGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction)];
        [self addGestureRecognizer:clickGesture];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(p_startTimer) name:KZHNCountDownStartCountingNotification object:nil];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backGroundImageView.frame = self.bounds;
    self.titleLabel.frame = self.bounds;
}


+ (ZHNCountDownView *)ZHN_countDownWithStartTitle:(NSString *)startTitle reloadTitle:(NSString *)reloadTitle countingFormatter:(NSString *)fromatter Timeinterval:(int)time handler:(ZHNCountDownHandleBlock)handle {
    return [ZHNCountDownView ZHN_countDownWithStartTitle:startTitle reloadTitle:reloadTitle countingFormatter:fromatter Timeinterval:time handler:handle countDownStartAction:nil countdownEndAction:nil];
}

+ (ZHNCountDownView *)ZHN_countDownWithStartTitle:(NSString *)startTitle reloadTitle:(NSString *)reloadTitle countingFormatter:(NSString *)fromatter Timeinterval:(int)time handler:(ZHNCountDownHandleBlock)handle countDownStartAction:(ZHNCountDownStartBlock)coutDownStartAction countdownEndAction:(ZHNCountDownEndBlock)countDownEndAction {
    ZHNCountDownView *countView = [[ZHNCountDownView alloc]init];
    countView.countDownEndAction = countDownEndAction;
    countView.countDownStartAction = coutDownStartAction;
    countView.titleLabel.text = startTitle;
    countView.reloaZHNitle = reloadTitle;
    countView.countFormatter = fromatter;
    countView.needReloaZHNime = time;
    countView.tempTime = time;
    countView.handle = handle;
    return countView;
}

- (void)frozen {
    self.isCountDowning = NO;
    if (self.countDownEndAction) {
        self.countDownEndAction();
    }
    [self p_enZHNimer];
}

#pragma mark - target action


#pragma mark - pravite methods
- (void)p_startTimer {
    self.isCountDowning = YES;
    if (self.countDownStartAction) {
        self.countDownStartAction();
    }
    __weak __typeof__(self) weakSelf = self;
    self.titleLabel.text = [NSString stringWithFormat:self.countFormatter,self.tempTime];
    self.timer = [ZHNTimer zhn_timerWIthTimeInterval:1 repeats:YES handler:^{
        weakSelf.tempTime--;
        weakSelf.titleLabel.text = [NSString stringWithFormat:weakSelf.countFormatter,weakSelf.tempTime];
        if (weakSelf.tempTime == 0) {
            [weakSelf p_enZHNimer];
            weakSelf.isCountDowning = NO;
            if (weakSelf.countDownEndAction) {
                weakSelf.countDownEndAction();
            }
            return;
        }
    }];
    [self.timer fire];
}

- (void)p_enZHNimer {
    [self.timer frozen];
    self.timer = nil;
    self.titleLabel.text = self.reloaZHNitle;
    self.tempTime = self.needReloaZHNime;
}

- (void)dealloc {
    [self.timer invalidate];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - target action
- (void)clickAction {
    if (self.isCountDowning) {return;}
    if (self.handle) {
        if (!self.handle()) {
            return;
        }
    }
    [self p_startTimer];
}

#pragma mark - setters
- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    self.backGroundImageView.image = backgroundImage;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.titleLabel.textColor = textColor;
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    self.titleLabel.font = textFont;
}

#pragma mark - getters
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImageView *)backGroundImageView {
    if (_backGroundImageView == nil) {
        _backGroundImageView = [[UIImageView alloc]init];
    }
    return _backGroundImageView;
}
@end
