//
//  OOShakeController.m
//  BaseFramework
//
//  Created by Beelin on 17/3/14.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import "OOShakeController.h"

@interface OOShakeController ()

@end

@implementation OOShakeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"摇一摇";
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
     OOLog(@"began shake");
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake) {
        OOLog(@"ended shake");
    }
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
}
@end
