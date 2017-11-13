//
//  ZPTabBarController.m
//  BaseFramework
//
//  Created by Mantis-man on 16/1/16.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "OOTabBarController.h"
#import "OONavigationController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "OOMyStudyViewController.h"
@implementation OOTabBarController

- (instancetype)init{
    if (self = [super init]) {
       
        OneViewController *one = [[OneViewController alloc]init];
        [self setupChildVc:one title:@"自定义控件demo" image:nil selectedImage:nil];
        
        TwoViewController *two = [[TwoViewController alloc]init];
        [self setupChildVc:two title:@"功能demo" image:nil selectedImage:nil];
        
        ThreeViewController *three = [[ThreeViewController alloc]init];
        [self setupChildVc:three title:@"第三方Demo" image:nil selectedImage:nil];

        OOMyStudyViewController *four = [[OOMyStudyViewController alloc]init];
        [self setupChildVc:four title:@"个人学习" image:nil selectedImage:nil];
        
    }
    return self;
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.title = title;
    
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    OONavigationController *nav = [[OONavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
@end
