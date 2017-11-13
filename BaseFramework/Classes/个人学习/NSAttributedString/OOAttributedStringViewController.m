//
//  OOAttributedStringViewController.m
//  BaseFramework
//
//  Created by Beelin on 16/12/1.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "OOAttributedStringViewController.h"

@interface OOAttributedStringViewController ()

@end

@implementation OOAttributedStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(100, 500, 200, 40)];
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
    
    NSString * str = @"¥150元/位";
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:str];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
    
    [att addAttribute:NSBackgroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(1, 1)];
    
    lab.attributedText = att;
}



@end
