//
//  CAlertView.h
//  CAlertView
//
//  Created by bamq on 15/7/26.
//  Copyright (c) 2015年 bamq. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CancelBlock)();
@interface CAlertView : UIView
-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;
-(void)show;
@property(nonatomic,copy)CancelBlock cancelBlock;
@property(nonatomic,copy)CancelBlock otherBlock;
@end
