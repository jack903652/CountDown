//
//  ViewController.m
//  CountDown
//
//  Created by bamq on 15/8/1.
//  Copyright (c) 2015年 bamq. All rights reserved.
//

#import "ViewController.h"
#import "CircleView_layer.h"
#import "TokenView_layer.h"
@interface ViewController ()
//@property(nonatomic,strong)CAShapeLayer *circleLayer;
@property(nonatomic,strong)CircleView_layer *circleView;
@end

@implementation ViewController
- (IBAction)action:(id)sender {
//    _circleView.score =69;
//    CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    animation.duration =5;
//    animation.fromValue =@0.5f;
//    animation.toValue =@0.2;
//    
//    _circleLayer.strokeEnd =0.2;
//    [_circleLayer addAnimation:animation forKey:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _circleView =[[CircleView_layer alloc] initWithFrame:CGRectMake(30, 200, 300, 300)];
    _circleView.score =60;
    __block typeof(self) wself =self;
    _circleView.clickBlock =^{
        wself.circleView.score =arc4random() %101;
    };
    [self.view addSubview:_circleView];
    
    TokenView_layer *tokenView =[[TokenView_layer alloc]initWithFrame:CGRectMake(10, 200, CGRectGetWidth(self.view.frame)-20, 58)];
    [self.view addSubview:tokenView];
//    [tokenView setToken:@"89808979" tl:5 time:10];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
