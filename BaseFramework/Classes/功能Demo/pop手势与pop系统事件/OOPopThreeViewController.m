//
//  OOPopThreeViewController.m
//  BaseFramework
//
//  Created by Beelin on 16/11/28.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "OOPopThreeViewController.h"
#import "UINavigationController+Pop.h"
@interface OOPopThreeViewController ()<UINavigationControllerShouldPop>

@end

@implementation OOPopThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    BOOL b = [self test];
}

- (BOOL)navigationControllerShouldPop:(UINavigationController *)navigationController
{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//    return NO;
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
    return NO;
}



- (BOOL)test{
    return YES;
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
