//
//  QRImageViewController.m
//  BaseFramework
//
//  Created by Gatlin on 16/10/18.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "QRImageViewController.h"

#import "OOQRImageView.h"
@interface QRImageViewController ()

@end

@implementation QRImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        btn.frame = CGRectMake(100, 100, 30, 30);
        [btn addTarget:self action:@selector(showAction) forControlEvents:UIControlEventTouchDown];
        btn;
    })];

}

- (void)showAction{
    OOQRImageView *view = [[OOQRImageView alloc] initWithQRImageForString:@"123"];
    view.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:view];
}

@end
