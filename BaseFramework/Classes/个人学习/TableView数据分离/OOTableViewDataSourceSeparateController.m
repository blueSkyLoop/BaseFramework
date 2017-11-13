//
//  OOTableViewDataSourceSeparateControllerViewController.m
//  BaseFramework
//
//  Created by Beelin on 17/4/6.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import "OOTableViewDataSourceSeparateController.h"
#import "OOTableViewDataSource.h"

@interface OOTableViewDataSourceSeparateController ()
@property (nonatomic, strong) OOTableViewDataSource *source;
@end

@implementation OOTableViewDataSourceSeparateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.source = [[OOTableViewDataSource alloc] init];
    self.tableView.dataSource = self.source;
    self.tableView.delegate = self.source;
    [self.view addSubview: self.tableView];
}


@end
