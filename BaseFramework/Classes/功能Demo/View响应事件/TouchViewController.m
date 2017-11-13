//
//  TouchViewController.m
//  BaseFramework
//
//  Created by Gatlin on 16/9/14.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "TouchViewController.h"
#import "TwoViewController.h"
#import "OOCircleView.h"
@interface TouchViewController ()

@end

@implementation TouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:({
        OOCircleView *view = [[OOCircleView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        view.backgroundColor = [UIColor redColor];
        view;
    })];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(100, 100, 40, 40);
    [btn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
}

- (void)show{
    TwoViewController *vc = [[TwoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
