//
//  ImagePickerViewController.m
//  BaseFramework
//
//  Created by Gatlin on 16/10/27.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "ImagePickerViewController.h"

#import "TZImagePickerController.h"
@interface ImagePickerViewController ()<TZImagePickerControllerDelegate>

@end

@implementation ImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"调用相机，选择多张照片";
    [self.view addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        btn.frame = CGRectMake(100, 100, 30, 30);
        [btn addTarget:self action:@selector(showAction) forControlEvents:UIControlEventTouchDown];
        btn;
    })];
}

- (void)showAction{
    //核心代码
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];}


@end
