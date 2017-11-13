//
//  OOTextFiledCustomController.m
//  BaseFramework
//
//  Created by Beelin on 17/2/17.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import "OOTextFiledCustomController.h"
#import "UIImage+GIF.h"
@interface OOTextFiledCustomController ()

@end

@implementation OOTextFiledCustomController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *v = [[UIImageView alloc] init];
    v.frame = CGRectMake(0, 0, 200, 200);
    v.image = [UIImage sd_animatedGIFNamed:@"lAHOqJGKQc0C7s0C7g_750_750"];

    v.animationDuration = 1;

    [self.view addSubview:v];

    
    
}



@end
