//
//  TwoViewController.m
//  BaseFramework
//
//  Created by Mantis-man on 16/1/16.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "TwoViewController.h"
#import "OneViewController.h"
#import "ScrollMianViewController.h"
#import "OOPopOneViewController.h"
#import "OOTextFiledCustomController.h"
#import "OOVideoController.h"
#import "OOFingerprintLockController.h"
#import "OOLocalPushController.h"
@interface TwoViewController()
@property (nonatomic, strong) NSArray *arrayName;
@property (nonatomic, strong) NSArray *arrayViewController;
@end

@implementation TwoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _arrayName = @[NSStringFromClass([ScrollMianViewController class]),
                   NSStringFromClass([OOPopOneViewController class]),
                   NSStringFromClass([OOTextFiledCustomController class]),
                   NSStringFromClass([OOVideoController class]),
                   NSStringFromClass([OOFingerprintLockController class]),
                   NSStringFromClass([OOLocalPushController class])
                   ];
    
    [self.view addSubview:self.tableView];
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
    if (indexPath.row == 3) {
        [self presentViewController:self.arrayViewController[indexPath.row] animated:YES completion:nil];
        return;
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:self.arrayViewController[indexPath.row] animated:YES];
}

#pragma mark - Getter
- (NSArray *)arrayViewController{
    if (!_arrayViewController) {
        _arrayViewController = @[[[ScrollMianViewController alloc] init],
                                 [[OOPopOneViewController alloc] init],
                                 [[OOTextFiledCustomController alloc] init],
                                 [[OOVideoController alloc] init],
                                 [[OOFingerprintLockController alloc] init],
                                 [[OOLocalPushController alloc] init]
                                 ];
    }
    return _arrayViewController;
}
@end
