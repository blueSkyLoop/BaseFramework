//
//  StretchTableHeaderViewController.m
//  BaseFramework
//
//  Created by Gatlin on 16/10/18.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "StretchTableHeaderViewController.h"

#import "OOStretchTableHeaderView.h"

#import "UIImage+Extend.h"
@interface StretchTableHeaderViewController ()
@property (nonatomic, strong) OOStretchTableHeaderView *stretchTableHeaderView;
@end

@implementation StretchTableHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /* addsubview 无法调用 viewDidLayoutSubviews
        原因 addsubview的话，滚动tableView, self.tableView变化，会调用viewDidLayoutSubviews，
     而self.view没变化，故 viewDidLayoutSubviews 不执行，最好就是将Self.tableView赋值给self.view*/
    self.view = self.tableView;

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:ColorMain] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:ColorMain]];
}

- (void)viewDidLayoutSubviews{
    [self.stretchTableHeaderView resizeView];
}

#pragma Getter
- (OOStretchTableHeaderView *)stretchTableHeaderView{
    if (!_stretchTableHeaderView) {
        UIImageView *imv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bee"]];
        imv.frame  = CGRectMake(0, 0, self.view.bounds.size.width, 200);
        _stretchTableHeaderView = [OOStretchTableHeaderView stretchHeaderForTableView:self.tableView withView:imv];
    }
    return _stretchTableHeaderView;
}


#pragma mark - TableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    return cell;
}

#pragma mark - ScorllView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.stretchTableHeaderView scrollViewDidScroll:scrollView];
    
    //导航样、变色
    if (self.tableView.contentOffset.y > (200 - 64)) {
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:nil];
    }else if (self.tableView.contentOffset.y >= 0 && self.tableView.contentOffset.y <= (200 - 64)){
        
        float alp = self.tableView.contentOffset.y / (200 - 64);
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGBColor_alpha(90, 136, 231, 1- alp)] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:ColorMain] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        
    }

}
@end
