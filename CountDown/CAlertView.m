//
//  CAlertView.m
//  CAlertView
//
//  Created by bamq on 15/7/26.
//  Copyright (c) 2015年 bamq. All rights reserved.
//

#import "CAlertView.h"
#import <QuartzCore/QuartzCore.h>
#define WIDTH 200
@interface CAlertView()
@property(nonatomic,strong)UIWindow *alertWindow;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *messageLabel;
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UIWindow *window;
@end
@implementation CAlertView
-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    if (self) {
        self =[super init];
        _window =[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.windowLevel =UIWindowLevelAlert;
        _window.backgroundColor =[UIColor colorWithWhite:0 alpha:0.15];
        _titleLabel =[[UILabel alloc] initWithFrame:CGRectMake(20, 0, WIDTH, 40)];
        _titleLabel.textAlignment =NSTextAlignmentCenter;
        _titleLabel.text =title;
        _messageLabel =[[UILabel alloc] init];
        _messageLabel.numberOfLines =0;
        _messageLabel.textAlignment =NSTextAlignmentCenter;
        _messageLabel.text =message;
        _messageLabel.font =[UIFont systemFontOfSize:14];
        _messageLabel.lineBreakMode =NSLineBreakByWordWrapping;
        
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//        NSDictionary *attributes = @{NSFontAttributeName:_messageLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
      CGSize size =[message sizeWithFont:_messageLabel.font constrainedToSize:CGSizeMake(WIDTH, MAXFLOAT) lineBreakMode:_messageLabel.lineBreakMode];
        size.height =ceil(size.height);
        _messageLabel.frame =CGRectMake(20, CGRectGetMaxY(_titleLabel.frame), WIDTH, size.height);
        
        UIButton *cancelBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.backgroundColor =[UIColor blueColor];
        cancelBtn.layer.cornerRadius =2.5;
        cancelBtn.layer.masksToBounds =YES;
        [cancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
        if (!otherButtonTitles) {
            cancelBtn.frame =CGRectMake(20, CGRectGetMaxY(_messageLabel.frame)+20, WIDTH, 34);
        }else{
             cancelBtn.frame =CGRectMake(20, CGRectGetMaxY(_messageLabel.frame)+20, WIDTH/2-3, 34);
            UIButton *otherBtn =[UIButton buttonWithType:UIButtonTypeCustom];
            [otherBtn setTitle:otherButtonTitles forState:UIControlStateNormal];
            otherBtn.backgroundColor =[UIColor blueColor];
            otherBtn.layer.cornerRadius =2.5;
            otherBtn.layer.masksToBounds =YES;
            otherBtn.frame =CGRectMake(CGRectGetMaxX(cancelBtn.frame)+6, CGRectGetMaxY(_messageLabel.frame)+20, WIDTH/2-3, 34);
            [otherBtn addTarget:self action:@selector(otherBtnAction) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:otherBtn];
        }
        [self addSubview:cancelBtn];
        self.frame =CGRectMake(0, 0, WIDTH+40, CGRectGetMaxY(cancelBtn.frame)+10);
        self.center =_window.center;
        [self addSubview:_titleLabel];
        [self addSubview:_messageLabel];
        self.backgroundColor =[UIColor greenColor];
        self.layer.cornerRadius =2.5;
        self.layer.masksToBounds =YES;
//        CGSize size =[message boundingRectWithSize:<#(CGSize)#> options:<#(NSStringDrawingOptions)#> attributes:<#(NSDictionary *)#> context:<#(NSStringDrawingContext *)#>]
        
  
        [_window addSubview:self];
    }
    return self;
}
-(void)show{
    [self.window makeKeyAndVisible];
    [self showAnimation];
}
-(void)showAnimation{
    CAKeyframeAnimation *showAnimation =[CAKeyframeAnimation animationWithKeyPath:@"transform"];
    showAnimation.duration =1;
    showAnimation.values =@[[NSValue valueWithCATransform3D:CATransform3DMakeScale(.01f, .01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)]];
    showAnimation.keyTimes =@[@0.01,@0.1,@0.2];
    [self.layer addAnimation:showAnimation forKey:nil];
}
-(void)cancelBtnAction{
    if (_cancelBlock) {
        _cancelBlock();
    }
    [self dismiss];
}
-(void)otherBtnAction{
    if (_otherBlock) {
        _otherBlock();
    }
    [self dismiss];
}
-(void)dismiss{
    _cancelBlock =nil;
    _otherBlock =nil;
//    _window =nil;
//    [_window resignKeyWindow];
    [self removeFromSuperview];
}
-(void)dealloc{
    NSLog(@"dealloc");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
