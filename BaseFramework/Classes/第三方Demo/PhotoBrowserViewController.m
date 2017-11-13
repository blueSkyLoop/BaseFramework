//
//  PhotoBrowserViewController.m
//  BaseFramework
//
//  Created by Gatlin on 16/10/25.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "PhotoBrowserViewController.h"
#import <IDMPhotoBrowser.h>
#import "MBProgressHUD+MJ.h"
@interface PhotoBrowserViewController ()<IDMPhotoBrowserDelegate>
@property (nonatomic, strong) NSArray *photos;
@end

@implementation PhotoBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"仿微信多图浏览";
    
    [self.view addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        btn.frame = CGRectMake(100, 100, 30, 30);
        [btn addTarget:self action:@selector(showAction) forControlEvents:UIControlEventTouchDown];
        btn;
    })];
}

- (void)showAction{
    //核心代码
    NSArray *images = @[[UIImage imageNamed:@"bee"],[UIImage imageNamed:@"two"],[UIImage imageNamed:@"one"]];
    _photos = [IDMPhoto photosWithImages:images];
    IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:self.photos];
    browser.delegate = self;
    browser.actionButtonTitles = @[@"发给朋友", @"保存图片", @"收藏"];//不实现，则无长按功能
    [self presentViewController:browser animated:YES completion:nil];
}


/** 代理 实现长按回调 */
- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didDismissActionSheetWithButtonIndex:(NSUInteger)buttonIndex photoIndex:(NSUInteger)photoIndex{
    switch (buttonIndex) {
        case 0:
            [MBProgressHUD showSuccess:@"发给朋友成功"];
            break;
        case 1:
            [MBProgressHUD showSuccess:@"保存图片成功"];
            break;
        case 2:
            [MBProgressHUD showSuccess:@"收藏成功"];
            break;
            
        default:
            break;
    }
}

/** 代理、自定义view */
/*
 - (IDMCaptionView *)photoBrowser:(IDMPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
 UIView *captionView = [[UIView alloc] init];
 captionView.backgroundColor = [UIColor redColor];
 captionView.frame = CGRectMake(0, 0, 100, 30);
 return (IDMCaptionView *)captionView;
 }
 */
@end
