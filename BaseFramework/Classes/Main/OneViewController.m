//
//  OneViewController.m
//  BaseFramework
//
//  Created by Mantis-man on 16/1/16.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "OneViewController.h"
#import "TouchViewController.h"
#import "SegmentedControlViewController.h"
#import "CameraViewController.h"
#import "QRImageViewController.h"
#import "StretchTableHeaderViewController.h"
#import "LaunchViewController.h"
#import "BannerViewController.h"
#import "FPSController.h"
@interface OneViewController()
@property (nonatomic, strong) NSArray *arrayName;
@property (nonatomic, strong) NSArray *arrayViewController;

@end

@implementation OneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    _arrayName = @[NSStringFromClass([TouchViewController class]),
                   NSStringFromClass([SegmentedControlViewController class]),
                   NSStringFromClass([QRImageViewController class]),
                   NSStringFromClass([StretchTableHeaderViewController class]),
                   NSStringFromClass([LaunchViewController class]),
                   NSStringFromClass([BannerViewController class]),
                   NSStringFromClass([CameraViewController class]),
                   NSStringFromClass([FPSController class])];
    
    _arrayViewController = @[[[TouchViewController alloc] init],
                             [[SegmentedControlViewController alloc] init],
                             [[QRImageViewController alloc] init],
                             [[StretchTableHeaderViewController alloc] init],
                             [[LaunchViewController alloc] init],
                             [[BannerViewController alloc] init],
                             [[CameraViewController alloc] init],
                             [[FPSController alloc] init]];
    
    [self.view addSubview:self.tableView];

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
    if([vc isKindOfClass:[LaunchViewController class]]){
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    [self.navigationController pushViewController:self.arrayViewController[indexPath.row] animated:YES];
}
@end
