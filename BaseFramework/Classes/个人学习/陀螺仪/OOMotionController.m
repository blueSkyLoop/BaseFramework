//
//  OOMotionController.m
//  BaseFramework
//
//  Created by Beelin on 17/3/14.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import "OOMotionController.h"

#import "OOMotionManagerController.h"
#import "OOStepViewController.h"
#import "OOShakeController.h"

@interface OOMotionController ()
@property (nonatomic, strong) NSArray *arrayName;
@property (nonatomic, strong) NSArray *arrayViewController;
@end

@implementation OOMotionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"陀螺仪";
    _arrayName = @[NSStringFromClass([OOMotionManagerController class]),
                   NSStringFromClass([OOStepViewController class]),
                   NSStringFromClass([OOShakeController class])
                   ];
}

- (void)viewWillAppear:(BOOL)animated{
    self.arrayViewController = nil;
    [super viewWillAppear:animated];
}

#pragma mark - TableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayName.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.arrayName[indexPath.row];
    return cell;
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = self.arrayViewController[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:self.arrayViewController[indexPath.row] animated:YES];
}

#pragma mark - Getter
- (NSArray *)arrayViewController{
    if (!_arrayViewController) {
        _arrayViewController = @[[[OOMotionManagerController alloc] init],
                                 [[OOStepViewController alloc] init],
                                 [[OOShakeController alloc] init]
                                 ];
    }
    return _arrayViewController;
}


@end
