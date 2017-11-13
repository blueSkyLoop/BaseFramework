//
//  OOVideoController.m
//  BaseFramework
//
//  Created by Beelin on 17/2/21.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import "OOVideoController.h"
#import <AVFoundation/AVFoundation.h>

#import "OOVideoRecordView.h"
#import "OOVideoPlayView.h"

#import "OOVVIFileManager.h"

static CGFloat const kBtnWidth = 70.0;
static CGFloat const kBtnHeight = kBtnWidth;

/** 定义类型 */
typedef NS_ENUM(NSInteger) {
    OOMediaTypeImage,
    OOMediaTypeVideo
}OOMediaType;

@interface OOVideoController ()<OOVideoRecordViewDelegate>

@property (nonatomic, strong) OOVideoRecordView *videoRecordView;
@property (nonatomic, strong) OOVideoPlayView *videoPlayView;
@property (nonatomic, strong) UIImageView *imv;

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *reRecordBtn;    //重新录制
@property (nonatomic, strong) UIButton *finishBtn;      //完成

@property (nonatomic, assign) OOMediaType mediaType;

@property (nonatomic, strong) NSURL *videoUrl;
@end

@implementation OOVideoController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"视频录制与播放";
    
    [self.view addSubview:self.videoRecordView];
    [self.view addSubview:self.backBtn];
    [self.videoRecordView startSession];

    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

}

#pragma mark - OOVideoRecordViewDelegate
- (void)videoRecordView:(OOVideoRecordView *)videoRecordView didStopRecorderWithVideoUrl:(NSURL *)videoUrl{
    self.mediaType = OOMediaTypeVideo;
    
    self.videoUrl = videoUrl;
    
    [self.view.layer addSublayer:self.videoPlayView.layer];
    self.videoPlayView.videoUrl = videoUrl;
    [self.videoPlayView play];
    
    [self.view addSubview:self.reRecordBtn];
    [self.view addSubview:self.finishBtn];
}

- (void)videoRecordView:(OOVideoRecordView *)videoRecordView didPlayWithImageData:(NSData *)imageData{
    self.mediaType = OOMediaTypeImage;
    
    [self.view addSubview:self.imv];
    self.imv.image = [UIImage imageWithData:imageData];
    
    [self.view addSubview:self.reRecordBtn];
    [self.view addSubview:self.finishBtn];

}


#pragma mark - Event 
- (void)backAction{
    [self.videoRecordView stopSession];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)reRecordAction{
    if (self.mediaType == OOMediaTypeImage) {
        [self.imv removeFromSuperview];
    }else{
        [self.videoPlayView pause];
        [self.videoPlayView removeFromSuperview];
    }
    
    [self.reRecordBtn removeFromSuperview];
    [self.finishBtn removeFromSuperview];
}

- (void)finishAction{
    if (self.mediaType == OOMediaTypeImage) {
       
    }else{
        //方法执行后，通过OOVVIFileManagerDelegate返回视频URL与缩略图
        [[OOVVIFileManager sharedManager] compressedVideoToMFileTypeMPEG4WithVideoUrl:self.videoUrl didFinishCompressed:^(NSURL *videoUrl, UIImage *thumb) {
            OOLog(@"videoUrl: %@",videoUrl);
        }];
    }
}

#pragma mark - Getter
- (OOVideoRecordView *)videoRecordView{
    if (!_videoRecordView) {
        _videoRecordView = [[OOVideoRecordView alloc] init];
        _videoRecordView.delegate = self;
        _videoRecordView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return _videoRecordView;
}

- (OOVideoPlayView *)videoPlayView{
    if (!_videoPlayView) {
        _videoPlayView = [[OOVideoPlayView alloc] init];
//        _videoPlayView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _videoPlayView.videoOrientation = OOVideoOrientationLandscape;
    }
    return _videoPlayView;
}

- (UIImageView *)imv{
    if (!_imv) {
        _imv = [[UIImageView alloc] init];
        _imv.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return _imv;
}
- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(50, 400, kBtnWidth, kBtnHeight);
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIButton *)reRecordBtn{
    if (!_reRecordBtn) {
        _reRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _reRecordBtn.frame = CGRectMake(50, 300, kBtnWidth, kBtnHeight);
        [_reRecordBtn setTitle:@"重摄" forState:UIControlStateNormal];
        [_reRecordBtn addTarget:self action:@selector(reRecordAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reRecordBtn;
}

- (UIButton *)finishBtn{
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _finishBtn.frame = CGRectMake(SCREEN_WIDTH - 50 - kBtnWidth, 300, kBtnWidth, kBtnHeight);
        [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_reRecordBtn addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishBtn;
}



@end
