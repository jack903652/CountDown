//
//  TokenView_layer.m
//  CountDown
//
//  Created by bamq on 15/8/1.
//  Copyright (c) 2015年 bamq. All rights reserved.
//

#import "TokenView_layer.h"
@interface TokenView_layer()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)CAShapeLayer *clayer;
@end
@implementation TokenView_layer
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        //
        self.layer.borderColor =[UIColor lightGrayColor].CGColor;
        self.layer.borderWidth =1;
        self.layer.cornerRadius =2.5;
        self.layer.masksToBounds =YES;
        _titleLabel =[[UILabel alloc] initWithFrame:
                      CGRectMake(10, 10, CGRectGetWidth(frame)-10*2, 30)];
        _titleLabel.textAlignment =NSTextAlignmentCenter;
        _titleLabel.layer.borderColor =[UIColor lightGrayColor].CGColor;
        _titleLabel.layer.borderWidth =1;
        _titleLabel.layer.cornerRadius =2.5;
        _titleLabel.layer.masksToBounds =YES;
        [self addSubview:_titleLabel];
        
        CAShapeLayer *backLayer =[CAShapeLayer layer];
        UIBezierPath *backPath =[UIBezierPath bezierPath];
        [backPath moveToPoint:CGPointMake(12, CGRectGetMaxY(_titleLabel.frame)+5)];
        [backPath addLineToPoint:CGPointMake(CGRectGetMaxX(_titleLabel.frame)-2, CGRectGetMaxY(_titleLabel.frame)+5)];
        backLayer.path =backPath.CGPath;
        backLayer.lineCap =kCALineCapRound;
        backLayer.lineWidth =3;
        backLayer.fillColor =[UIColor clearColor].CGColor;
        backLayer.strokeColor =[UIColor lightGrayColor].CGColor;
        backLayer.strokeEnd =1.0;
        [self.layer addSublayer:backLayer];
        
        _clayer =[CAShapeLayer layer];
        _clayer.path =backPath.CGPath;
        _clayer.lineCap =kCALineCapRound;
        _clayer.lineWidth =3;
        _clayer.fillColor =[UIColor clearColor].CGColor;
        _clayer.strokeColor =[UIColor greenColor].CGColor;
        _clayer.strokeEnd =1.0;
        [self.layer addSublayer:_clayer];
        [self startTimer:5 interval:10];
        [self setToken:@"first" tl:5 time:10];
    }
    return self;
}
-(void)setToken:(NSString *)string tl:(float)tl time:(float)time{
    _titleLabel.attributedText =[self getAttributedString:string];
    CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration =tl;
    animation.fromValue =@(1-tl/time);
    animation.toValue =@1.0;
    [_clayer addAnimation:animation forKey:nil];
}

-(void)startTimer:(float)delta interval:(float)interval{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, NSEC_PER_SEC * delta),interval*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(/* DISABLES CODE */ (1)){
            dispatch_async(dispatch_get_main_queue(), ^{
                int x =(arc4random() % +100000000)+10000000;
                [self setToken:[NSString stringWithFormat:@"%d",x] tl:10 time:10];
            });
        }else{
            dispatch_source_cancel(_timer);
        }
    });
    dispatch_resume(_timer);
}

-(NSAttributedString *)getAttributedString:(NSString *)string{
    NSMutableParagraphStyle *para =[[NSMutableParagraphStyle alloc] init];
    para.firstLineHeadIndent =20;
    para.headIndent =20;
//    para.tailIndent =-20;
    para.alignment =NSTextAlignmentCenter;
    NSAttributedString *str =[[NSAttributedString alloc] initWithString:
                              string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],
                                                  NSForegroundColorAttributeName:[UIColor blackColor],NSKernAttributeName:@(20),
                                                  NSParagraphStyleAttributeName:para}];
    return str;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
