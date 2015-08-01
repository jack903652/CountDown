//
//  CircleView_layer.m
//  CountDown
//
//  Created by bamq on 15/8/1.
//  Copyright (c) 2015年 bamq. All rights reserved.
//

#import "CircleView_layer.h"
@interface CircleView_layer()
@property(nonatomic,strong)CAShapeLayer *circleLayer;
@property(nonatomic,strong)UILabel *titlelLabel;
@end
@implementation CircleView_layer
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor lightGrayColor];
        float radius =CGRectGetWidth(self.bounds)/2;
        CGPoint center =CGPointMake(radius, radius);
        self.layer.borderWidth =6;
        self.layer.borderColor =[UIColor greenColor].CGColor;
        self.layer.cornerRadius =radius;
        self.layer.masksToBounds =YES;
        
        _titlelLabel =[[UILabel alloc] initWithFrame:self.bounds];
        _titlelLabel.textAlignment =NSTextAlignmentCenter;
        _titlelLabel.numberOfLines =0;
        self.duration =5;
        
        
        UIBezierPath *backGroundPath =[UIBezierPath bezierPathWithArcCenter:center radius:radius-16 startAngle:-M_PI_2 endAngle:-M_PI_2-M_PI*2 clockwise:NO];
        CAShapeLayer *backGroundLayer =[CAShapeLayer layer];
        backGroundLayer.path =backGroundPath.CGPath;
        backGroundLayer.fillColor =[UIColor clearColor].CGColor;
        backGroundLayer.lineWidth =3;
        backGroundLayer.strokeColor =[UIColor whiteColor].CGColor;
        backGroundLayer.strokeEnd =1.0;
        [self.layer addSublayer:backGroundLayer];
        
        
        UIBezierPath *path =[UIBezierPath bezierPath];
        [path addArcWithCenter:center radius:radius-16 startAngle:-M_PI_2 endAngle:-M_PI*2-M_PI_2 clockwise:NO];
        _circleLayer =[CAShapeLayer layer];
        _circleLayer.path =path.CGPath;
        _circleLayer.fillColor =[UIColor clearColor].CGColor;
        _circleLayer.lineWidth =3;
        _circleLayer.strokeColor =[UIColor blueColor].CGColor;
        _circleLayer.lineCap =kCALineCapRound;
        CABasicAnimation *animation =[self animationwithFrom:0.0 to:1.0 duration:0.01];
        _circleLayer.strokeEnd =1.0;
        [self.layer addSublayer:_circleLayer];
        [_circleLayer addAnimation:animation forKey:nil];
        [self addSubview:_titlelLabel];
        [self addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)clickAction{
    if (_clickBlock) {
        _clickBlock();
    }
}
-(CABasicAnimation *)animationwithFrom:(float)from to:(float)to duration:(float)duration{
    CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration =duration;
    animation.fromValue =@(from);
    animation.toValue =@(to);
    return animation;
}
-(void)setScore:(int)score{
    _score =score;
    float percent =_score/100.0f;
    [self countDown:score];
    CABasicAnimation *animation =[self animationwithFrom:1.0 to:percent duration:_duration*(1-percent)];
    _circleLayer.strokeEnd =percent;
    [_circleLayer addAnimation:animation forKey:nil];
}

-(NSAttributedString *)attrbutedString:(int)score{
    NSMutableAttributedString *string =[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d",score] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:80],NSForegroundColorAttributeName:[UIColor greenColor]}];
    if (score <70) {
        NSAttributedString *temp =[[NSAttributedString alloc] initWithString:@"\n\n账号有风险" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
        NSAttributedString *temp1 =[[NSAttributedString alloc] initWithString:@"\n请进入账号管理" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor blackColor]}];
        [string appendAttributedString:temp];
        [string appendAttributedString:temp1];
    }
    return string;
}

-(void)countDown:(int)tscore{
    __block int temp =100;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),0.05*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(temp >=tscore){
            dispatch_async(dispatch_get_main_queue(), ^{
                self.titlelLabel.attributedText =[self attrbutedString:temp];
                temp--;
            });
        }else{
            dispatch_source_cancel(_timer);
        }
    });
    dispatch_resume(_timer);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
