//
//  OOCoreAnimationViewController.m
//  BaseFramework
//
//  Created by Beelin on 17/3/15.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import "OOCoreAnimationViewController.h"
#import "OOPerson.h"
@interface OOCoreAnimationViewController ()
{
    NSTimer *_timer;
}
@property (nonatomic, strong) UIView *v;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) OOPerson *person;
@end

@implementation OOCoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.v];
    [self.view addSubview:self.btn];
    
   // _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    
    
}
- (void)dealloc{
    NSLog(@"dealloc");
}
- (void)timeAction{
    NSLog(@"...");
}

- (void)transaction{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setValue:@5 forKey:kCATransactionAnimationDuration];
    self.v.layer.backgroundColor = [UIColor blueColor].CGColor;
    [CATransaction commit];
}

- (void)test1{
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 200, 200)];
    [CATransaction begin];
    CAKeyframeAnimation *ka = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ka.path = path.CGPath;
    ka.duration = 5;
    ka.removedOnCompletion = NO;
    ka.fillMode = kCAFillModeForwards;
    ka.repeatCount = MAXFLOAT;
    [self.v.layer addAnimation:ka forKey:nil];
}

- (void)test2{
    UIView *view1 = [[UIView alloc] init];
    view1.frame = CGRectMake(100, 100, 5, 5);
    view1.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] init];
    view2.frame = CGRectMake(120, 80, 5, 5);
    view2.backgroundColor = [UIColor redColor];
    [self.view addSubview:view2];
    
    UIView *view3 = [[UIView alloc] init];
    view3.frame = CGRectMake(140, 100, 5, 5);
    view3.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view3];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 100)];
    [path addArcWithCenter:CGPointMake(120, 100) radius:20 startAngle:0 endAngle:M_PI *2 clockwise:YES];
    [path moveToPoint:CGPointMake(100, 100)];

    
    UIBezierPath *path2 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake( 120, 80, 40, 40)];
    UIBezierPath *path3 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake( 140, 100, 40, 40)];
    
    CAKeyframeAnimation *ani1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ani1.path = path.CGPath;
    ani1.duration = 4.0f;
    ani1.repeatCount = MAXFLOAT;
    ani1.fillMode = kCAFillModeForwards;
    ani1.removedOnCompletion = YES;
    
    CAKeyframeAnimation *ani2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ani2.path = path2.CGPath;
    ani2.duration = 4;
    ani2.repeatCount = MAXFLOAT;
    ani2.fillMode = kCAFillModeForwards;
    ani2.removedOnCompletion = YES;
    
    CAKeyframeAnimation *ani3 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ani3.path = path3.CGPath;
    ani3.duration = 4;
    ani3.repeatCount = MAXFLOAT;
    ani3.fillMode = kCAFillModeForwards;
    ani3.removedOnCompletion = NO;
    
    [view1.layer addAnimation:ani1 forKey:@"1"];
    [view3.layer addAnimation:ani3 forKey:nil];
    [view2.layer addAnimation:ani2 forKey:@"2"];
    
}

- (void)test3{
//    CASpringAnimation *anim = [CASpringAnimation animation];
//    anim.keyPath = @"position.x";
//    anim.fromValue =@(self.v.center.x);
//    anim.toValue = @(self.v.center.x+50);
//     anim.mass = 30;
//    anim.stiffness = 90;
//     anim.damping = 10;
//     anim.initialVelocity = 4;
//    anim.duration = anim.settlingDuration;
//    [self.v.layer addAnimation:anim forKey:nil];
    
    CASpringAnimation *anim = [CASpringAnimation animation];
    anim.keyPath = @"bounds";
    
    
    anim.mass = 30;
    anim.stiffness = 90;
    anim.damping = 10;
    anim.initialVelocity = 4;
    anim.duration = anim.settlingDuration;
        [self.v.layer addAnimation:anim forKey:nil];
}
- (UIView *)v{
    if (!_v) {
        _v = [[UIView alloc] init];
        _v.frame = CGRectMake(100, 100, 20, 20);
        _v.backgroundColor = [UIColor greenColor];
    }
    return _v;
}

- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(0, 300, 30, 30);
        _btn.backgroundColor = [UIColor redColor];
        [_btn addTarget:self action:@selector(test3) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}
@end
