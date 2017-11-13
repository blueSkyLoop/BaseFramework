//
//  ProgressHUDViewController.m
//  BaseFramework
//
//  Created by Gatlin on 16/10/18.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "ProgressHUDViewController.h"

#import "MBProgressHUD+MJ.h"
@interface ProgressHUDViewController ()

@end

@implementation ProgressHUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showMessage:@"111" toView:nil];
    [MBProgressHUD hideHUD];
}

@end
