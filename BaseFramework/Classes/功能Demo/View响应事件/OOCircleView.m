//
//  OOCircleView.m
//  BaseFramework
//
//  Created by Gatlin on 16/9/14.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "OOCircleView.h"
@interface OOCircleView ()
@property (nonatomic, strong) UIButton *greenBtn;

@end

@implementation OOCircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = frame.size.height/2;
        [self addSubview:({
            _greenBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
            _greenBtn.backgroundColor = [UIColor greenColor];
            [_greenBtn addTarget:self action:@selector(touchGreenAction) forControlEvents:UIControlEventTouchDown];
            _greenBtn;
        })];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    //返回当前point,参数为nil,返回
    CGPoint point = [touch locationInView:self];
    NSLog(@"point: %@",NSStringFromCGPoint(point));
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle: nil message: @"点击圆形视图" delegate: nil cancelButtonTitle: @"确认" otherButtonTitles: nil];
//    [alert show];
}


//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    return _greenBtn;
//}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    return [path containsPoint:point];
}


- (void)touchGreenAction
{
    NSLog(@"点中我了。。。");
}
@end
