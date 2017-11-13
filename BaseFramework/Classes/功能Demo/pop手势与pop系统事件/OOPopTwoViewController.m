//
//  OOPopTwoViewController.m
//  BaseFramework
//
//  Created by Beelin on 16/11/28.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "OOPopTwoViewController.h"
#import "OOPopThreeViewController.h"
@interface OOPopTwoViewController ()

@end

@implementation OOPopTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        btn.frame = CGRectMake(100, 100, 30, 30);
        [btn addTarget:self action:@selector(showAction) forControlEvents:UIControlEventTouchDown];
        btn;
    })];
    
}

- (void)showAction{
    OOPopThreeViewController *vc = [[OOPopThreeViewController alloc] init];
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
