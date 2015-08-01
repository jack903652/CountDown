//
//  CircleView_layer.h
//  CountDown
//
//  Created by bamq on 15/8/1.
//  Copyright (c) 2015年 bamq. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickBlock)();
@interface CircleView_layer : UIControl
@property(nonatomic,assign)float duration;
@property(nonatomic,assign)int score;
@property(nonatomic,copy)ClickBlock clickBlock;
@end
