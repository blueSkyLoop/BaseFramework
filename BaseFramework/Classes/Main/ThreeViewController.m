//
//  ThreeViewController.m
//  BaseFramework
//
//  Created by Gatlin on 16/10/17.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "ThreeViewController.h"
#import "KxMenuItemViewController.h"
#import "ProgressHUDViewController.h"
#import "PhotoBrowserViewController.h"
#import "ImagePickerViewController.h"
#import "YYCacheController.h"
@interface ThreeViewController ()
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *arrayViewController;
@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第三方Demo";
    
    _dataSource = @[NSStringFromClass([KxMenuItemViewController class]),
                    NSStringFromClass([ProgressHUDViewController class]),
                    NSStringFromClass([PhotoBrowserViewController class]),
                    NSStringFromClass([ImagePickerViewController class]),
                    NSStringFromClass([YYCacheController class])];
    
    
    [self.view addSubview:self.tableView];
    
}
- (void)viewWillAppear:(BOOL)animated{
    self.arrayViewController = nil;
    [super viewWillAppear:animated];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
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
        _arrayViewController = @[[[KxMenuItemViewController alloc] init],
                                 [[ProgressHUDViewController alloc] init],
                                 [[PhotoBrowserViewController alloc] init],
                                 [[ImagePickerViewController alloc] init],
                                 [[YYCacheController alloc] init]];
    }
    return _arrayViewController;
}
@end
