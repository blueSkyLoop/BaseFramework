//
//  SegmentedControlViewController.m
//  BaseFramework
//
//  Created by Gatlin on 16/10/17.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "SegmentedControlViewController.h"

#import "OOSegmentedControl.h"
@interface SegmentedControlViewController ()

@end

@implementation SegmentedControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    OOSegmentedControl *control = [OOSegmentedControl segmentedControlWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) Titles:@[@"1", @"2"] index:0];
    control.clickButtonBlock = ^(NSInteger tag){
      //do something
    };
    [self.view addSubview:control];
}



@end
