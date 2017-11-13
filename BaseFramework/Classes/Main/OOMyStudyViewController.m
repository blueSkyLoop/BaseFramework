//
//  OOMyStudyViewController.m
//  BaseFramework
//
//  Created by Beelin on 16/11/24.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "OOMyStudyViewController.h"
#import "OOCoreGraphicsViewController.h"
#import "OOCoreTextViewController.h"
#import "OOAttributedStringViewController.h"
#import "OONSCacheController.h"
#import "OOTextKitController.h"
#import "OONSURLSessionController.h"
#import "OOOperationQueuesController.h"
#import "OORunloopController.h"
#import "OOMotionController.h"
#import "OOCoreAnimationViewController.h"
#import "OOKVCViewController.h"
#import "OOTableViewDataSourceSeparateController.h"

@interface OOMyStudyViewController ()
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *arrayViewController;
@end

@implementation OOMyStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人学习";
    
    _dataSource = @[NSStringFromClass([OOCoreGraphicsViewController class]),
                    NSStringFromClass([OOCoreTextViewController class]),
                    NSStringFromClass([OOAttributedStringViewController class]),
                    NSStringFromClass([OONSCacheController class]),
                    NSStringFromClass([OOTextKitController class]),
                    NSStringFromClass([OONSURLSessionController class]),
                    NSStringFromClass([OOOperationQueuesController class]),
                    NSStringFromClass([OORunloopController class]),
                    NSStringFromClass([OOMotionController class]),
                    NSStringFromClass([OOCoreAnimationViewController class]),
                    NSStringFromClass([OOKVCViewController class]),
                    NSStringFromClass([OOTableViewDataSourceSeparateController class])
                    ];
    
  
    
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
        _arrayViewController = @[[[OOCoreGraphicsViewController alloc] init],
                                 [[OOCoreTextViewController alloc] init],
                                 [[OOAttributedStringViewController alloc] init],
                                 [[OONSCacheController alloc] init],
                                 [[OOTextKitController alloc] init],
                                 [[OONSURLSessionController alloc] init],
                                 [[OOOperationQueuesController alloc] init],
                                 [[OORunloopController alloc] init],
                                 [[OOMotionController alloc] init],
                                 [[OOCoreAnimationViewController alloc] init],
                                 [[OOKVCViewController alloc] init],
                                 [[OOTableViewDataSourceSeparateController alloc] init]
                                 ];
    }
    return _arrayViewController;
}
@end
