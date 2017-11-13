//
//  OOCoreTextViewController.m
//  BaseFramework
//
//  Created by Beelin on 16/11/29.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "OOCoreTextViewController.h"
#import "OOCoreTextView.h"
@interface OOCoreTextViewController ()

@end

@implementation OOCoreTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    OOCoreTextView *v = [[OOCoreTextView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];

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
