//
//  FPSController.m
//  BaseFramework
//
//  Created by Beelin on 17/2/20.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import "FPSController.h"
#import "FPSLabel.h"

@interface FPSController ()
@property (nonatomic, strong) FPSLabel *pfslab;
@end

@implementation FPSController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.pfslab = [[FPSLabel alloc] initWithFrame:CGRectMake(20, 100, 70, 20)];
    [[UIApplication sharedApplication].keyWindow addSubview:self.pfslab];
}

- (void)dealloc{
    [self.pfslab removeFromSuperview];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
     [self.pfslab removeFromSuperview];
    self.pfslab = nil;
}

#pragma mark - TableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = @"asd";
    return cell;
}

@end
