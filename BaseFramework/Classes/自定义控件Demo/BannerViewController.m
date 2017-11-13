//
//  BannerViewController.m
//  BaseFramework
//
//  Created by Gatlin on 16/10/18.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "BannerViewController.h"

#import "OOBannerView.h"
@interface BannerViewController ()
@property (nonatomic, strong) OOBannerView *bannerView;
@end

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.bannerView];
    
    OOBannerModel *model1 = [[OOBannerModel alloc] init];
    model1.imageName = @"one";
    OOBannerModel *model2 = [[OOBannerModel alloc] init];
    model2.imageName = @"two";
    OOBannerModel *model3 = [[OOBannerModel alloc] init];
    model3.imageName = @"three";

    NSArray *dataSource = @[model1,model2,model3];
    self.bannerView.dataSource = dataSource;
    
    //call back
    self.bannerView.clickImageBlock = ^(OOBannerModel *model){
        OOLog(@"imageName: %@",model.imageName);
    };
}

#pragma mark - Getter
- (OOBannerView *)bannerView{
    if (!_bannerView) {
        _bannerView = [[OOBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/375.0 * 155)];
        _bannerView.backgroundColor = [UIColor greenColor];
    }
    return _bannerView;
}

@end
