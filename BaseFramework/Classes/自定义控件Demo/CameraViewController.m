//
//  CameraViewController.m
//  BaseFramework
//
//  Created by Gatlin on 16/10/17.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "CameraViewController.h"

#import "UIActionSheet+camera.h"
@interface CameraViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        btn.frame = CGRectMake(100, 100, 30, 30);
        [btn addTarget:self action:@selector(showAction) forControlEvents:UIControlEventTouchDown];
        btn;
    })];
}

- (void)showAction
{
    UIActionSheet *cameraActionSheet = [UIActionSheet showCameraActionSheet];
    cameraActionSheet.targer = self;
    
    [cameraActionSheet showInView:self.view];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
        
        //压缩图片
        NSData *imageNewData = UIImageJPEGRepresentation(image, 0.5);
        //request
        [self requestCommitImageData:imageNewData];

        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

/** 取消相机 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Request
- (void)requestCommitImageData:(NSData *)imageNewData{
    //业务逻辑
}
@end
