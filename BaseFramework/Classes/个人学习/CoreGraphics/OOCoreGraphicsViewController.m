//
//  OOCoreGraphicsViewController.m
//  BaseFramework
//
//  Created by Beelin on 16/11/24.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "OOCoreGraphicsViewController.h"

#import "OOGraphicsView.h"
#import "OOGraphicsImage.h"
@interface OOCoreGraphicsViewController ()

@end

@implementation OOCoreGraphicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    OOGraphicsView *v = [[OOGraphicsView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:v];
    
//    OOGraphicsImage *v = [[OOGraphicsImage alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:v];
}



@end
