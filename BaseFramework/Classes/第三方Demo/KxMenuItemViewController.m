//
//  OOKxMenuItemViewController.m
//  BaseFramework
//
//  Created by Gatlin on 16/10/17.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "KxMenuItemViewController.h"

#import "KxMenu.h"
@interface KxMenuItemViewController ()

@end

@implementation KxMenuItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"KxMenuItem";
    
    [self.view addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        btn.frame = CGRectMake(100, 100, 30, 30);
        [btn addTarget:self action:@selector(showAction: event:) forControlEvents:UIControlEventTouchDown];
        btn;
    })];

}

- (void)showAction:(UIButton *)sender event:(UIEvent *)event{
    KxMenuItem *item1 = [KxMenuItem menuItem:@"1" image:nil target:self action:@selector(item1_Action)];
    KxMenuItem *item2 = [KxMenuItem menuItem:@"2" image:nil target:self action:@selector(item2_Action)];
    KxMenuItem *item3 = [KxMenuItem menuItem:@"3" image:nil target:self action:@selector(item3_Action)];
    NSArray *array = @[item1,item2,item3];
    
//    CGRect frame = [[event allTouches]anyObject].view.frame;  若不是button,可以用此方法
    [KxMenu showMenuInView:self.view fromRect:sender.frame menuItems:array];
}

- (void)item1_Action{
    OOLogFunc;
}
- (void)item2_Action{
    OOLogFunc;
}
- (void)item3_Action{
    OOLogFunc;
}
@end
