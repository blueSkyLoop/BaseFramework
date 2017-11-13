//
//  OOCaptureView.m
//  BaseFramework
//
//  Created by Beelin on 17/2/21.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import "OOVideoRecordView.h"

#import <AVFoundation/AVFoundation.h>

@interface OOVideoRecordView ()<AVCaptureFileOutputRecordingDelegate>
/**
 *  AVCaptureSession对象来执行输入设备和输出设备之间的数据传递
 */
@property (nonatomic, strong) AVCaptureSession *session;
/**
 *  视频输入设备
 */
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;
/**
 *  声音输入
 */
@property (nonatomic, strong) AVCaptureDeviceInput *audioInput;
/**
 *  视频输出流
 */
@property(nonatomic,strong)AVCaptureMovieFileOutput *movieFileOutput;

/**
 *  照片输出流
 */
@property (nonatomic, strong) AVCaptureStillImageOutput* stillImageOutput;

/**
 *  预览图层
 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

/*------------------------------------------------------*/
/** 录制按钮 */
@property (nonatomic, strong) UIButton *recorderBtn;

/** 前/后摄像头 */
@property (nonatomic, strong) UIButton *cameraLensBtn;

/** 光圈可以点击范围view */
@property (nonatomic, strong) UIView *focusCircleView;
/** 光圈 */
@property (nonatomic, strong) UIImageView *focusCircle;

@property (nonatomic, strong) NSURL *fileUrl;


@end


@implementation OOVideoRecordView

#pragma mark - Life Cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        [self initAVCaptureSession];
        [self addSubview:self.focusCircleView];
        [self addSubview:self.recorderBtn];
        [self addSubview:self.cameraLensBtn];

       
    }
    return self;
}

- (void)initAVCaptureSession{
    //初始化session
    self.session = [[AVCaptureSession alloc] init];
    //设置分辨率
    self.session.sessionPreset = AVCaptureSessionPreset640x480;
    
    [self addVideoDevice];
    [self addAudioDevice];
    [self initMovieFileOutput];
    [self initStillImageOutput];
    [self setupAVCaptureConnection];
    [self initPreviewLayer];
    [self addGenstureRecognizer];
    
}

/** 添加摄像设备 */
- (void)addVideoDevice{
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //更改这个设置的时候必须先锁定设备，修改完后再解锁，否则崩溃
    [videoDevice lockForConfiguration:nil];
    //设置闪光灯为自动
    [videoDevice setFlashMode:AVCaptureFlashModeAuto];
    [videoDevice unlockForConfiguration];
    
    //初始化设备视频输入对象
    NSError *error;
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:videoDevice error:&error];
    
    //将视频输入对象添加到会话
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
}

/** 添加音频设备 */
- (void)addAudioDevice{
    NSError *error;
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    //初始化设备音频输入对象
    self.audioInput = [[AVCaptureDeviceInput alloc] initWithDevice:audioDevice error:&error];
    
    //将音频输入对象添加到会话
    if ([self.session canAddInput:self.audioInput]) {
        [self.session addInput:self.audioInput];
    }
}

/** 初始化视频输出设备对象，用户获取输出数据 */
- (void)initMovieFileOutput{
    self.movieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    
    //将输出对象添加到会话
    if ([self.session canAddOutput:self.movieFileOutput]) {
        [self.session addOutput:self.movieFileOutput];
    }
}

/** 初始化照片输出设备对象，用户获取输出数据 */
- (void)initStillImageOutput{
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    //输出设置。AVVideoCodecJPEG   输出jpeg格式图片
    NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    //将照片输入对象添加到会话
    if ([self.session canAddOutput:self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];
    }
}

/** 设置 AVCaptureConnection*/
- (void)setupAVCaptureConnection{
    AVCaptureConnection *movieConnection = [self.movieFileOutput connectionWithMediaType:AVMediaTypeVideo];
    
    // 开启视频防抖模式
    AVCaptureVideoStabilizationMode stabilizationMode = AVCaptureVideoStabilizationModeCinematic;
    if ([self.videoInput.device.activeFormat isVideoStabilizationModeSupported:stabilizationMode]) {
        [movieConnection setPreferredVideoStabilizationMode:stabilizationMode];
    }
    
    //视频方向设置
    AVCaptureVideoOrientation avcaptureOrientation = AVCaptureVideoOrientationPortrait;
    [movieConnection setVideoOrientation:avcaptureOrientation];
    [movieConnection setVideoScaleAndCropFactor:1.0];

}

/** 初始化预览图层 */
- (void)initPreviewLayer{
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    self.previewLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.layer.masksToBounds = YES;
    [self.previewLayer addSublayer:self.recorderBtn.layer];
    [self.layer addSublayer:self.previewLayer];
    
}

/** 光圈设置 */
-(void)addGenstureRecognizer{
    
    UITapGestureRecognizer *singleTapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
    singleTapGesture.numberOfTapsRequired = 1;
    singleTapGesture.delaysTouchesBegan = YES;
    
    UITapGestureRecognizer *doubleTapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    doubleTapGesture.delaysTouchesBegan = YES;
    
    [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
    [self.focusCircleView addGestureRecognizer:singleTapGesture];
    [self.focusCircleView addGestureRecognizer:doubleTapGesture];
}

#pragma mark - AVCaptureFileOutputRecordingDelegate
/** 完成录制 */
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    OOLog(@"---- 录制结束 ---%@-%@ ",outputFileURL,captureOutput.outputFileURL);
    
    if (outputFileURL.absoluteString.length == 0 && captureOutput.outputFileURL.absoluteString.length == 0 ) {
        OOLog(@"录制视频保存地址出错");
        return;
    }
    
    //获取视频路径播放
    if (self.delegate && [self.delegate respondsToSelector:@selector(videoRecordView:didStopRecorderWithVideoUrl:)]) {
        [self.delegate videoRecordView:self didStopRecorderWithVideoUrl:outputFileURL];
    }
    
    //恢复录制按钮事件
    self.recorderBtn.userInteractionEnabled = YES;
    
}


#pragma mark - Public Method
- (void)startSession{
    if (![self.session isRunning]) {
        [self.session startRunning];
    }
}

- (void)stopSession{
    if ([self.session isRunning]) {
        [self.session stopRunning];
    }
}

#pragma mark - 相关方法与设置
/* 获取摄像头-->前/后 */
- (void)changeCamera{
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    if (cameraCount > 1) {
        NSError *error;
        //给摄像头的切换添加翻转动画
        CATransition *animation = [CATransition animation];
        animation.duration = .5f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"oglFlip";
        
        AVCaptureDevice *newCamera = nil;
        AVCaptureDeviceInput *newInput = nil;
        //拿到另外一个摄像头位置
        AVCaptureDevicePosition position = [[self.videoInput device] position];
        if (position == AVCaptureDevicePositionFront){
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
            animation.subtype = kCATransitionFromLeft;//动画翻转方向
        }
        else {
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
            animation.subtype = kCATransitionFromRight;//动画翻转方向
        }
        //生成新的输入
        newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
        [self.previewLayer addAnimation:animation forKey:nil];
        if (newInput != nil) {
            [self.session beginConfiguration];
            [self.session removeInput:self.videoInput];
            if ([self.session canAddInput:newInput]) {
                [self.session addInput:newInput];
                self.videoInput = newInput;
                
            } else {
                [self.session addInput:self.videoInput];
            }
            [self.session commitConfiguration];
            
        } else if (error) {
            
        }
    }
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position ){
            return device;
        }
    return nil;
}



-(void)singleTap:(UITapGestureRecognizer *)tapGesture{
    
    CGPoint point= [tapGesture locationInView:self];
    CGPoint convertPoint = [self convertPoint:point toView:[UIApplication sharedApplication].keyWindow];
    //将UI坐标转化为摄像头坐标,摄像头聚焦点范围0~1
    CGPoint cameraPoint= [self.previewLayer captureDevicePointOfInterestForPoint:convertPoint];
    
    [self setFocusCursorAnimationWithPoint:point];
    OOLog(@"-------------------x=%f,y=%f",convertPoint.x,convertPoint.y);
    OOLog(@"+++++++++++++++++++x=%f,y=%f",cameraPoint.x,cameraPoint.y);
    [self changeDevicePropertySafety:^(AVCaptureDevice *captureDevice) {
        
        /*
         @constant AVCaptureFocusModeLocked 锁定在当前焦距
         Indicates that the focus should be locked at the lens' current position.
         
         @constant AVCaptureFocusModeAutoFocus 自动对焦一次,然后切换到焦距锁定
         Indicates that the device should autofocus once and then change the focus mode to AVCaptureFocusModeLocked.
         
         @constant AVCaptureFocusModeContinuousAutoFocus 当需要时.自动调整焦距
         Indicates that the device should automatically focus when needed.
         */
        //聚焦
        if ([captureDevice isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
            //聚焦点的位置
            if ([captureDevice isFocusPointOfInterestSupported]) {
                [captureDevice setFocusPointOfInterest:cameraPoint];
            }
            [captureDevice setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
            OOLog(@"聚焦模式修改为%zd",AVCaptureFocusModeContinuousAutoFocus);
        }else{
            OOLog(@"聚焦模式修改失败");
        }
        
        /*
         @constant AVCaptureExposureModeLocked  曝光锁定在当前值
         Indicates that the exposure should be locked at its current value.
         
         @constant AVCaptureExposureModeAutoExpose 曝光自动调整一次然后锁定
         Indicates that the device should automatically adjust exposure once and then change the exposure mode to AVCaptureExposureModeLocked.
         
         @constant AVCaptureExposureModeContinuousAutoExposure 曝光自动调整
         Indicates that the device should automatically adjust exposure when needed.
         
         @constant AVCaptureExposureModeCustom 曝光只根据设定的值来
         Indicates that the device should only adjust exposure according to user provided ISO, exposureDuration values.
         */
        
        //曝光模式
        if ([captureDevice isExposureModeSupported:AVCaptureExposureModeAutoExpose]) {
            //曝光点的位置
            if ([captureDevice isExposurePointOfInterestSupported]) {
                [captureDevice setExposurePointOfInterest:cameraPoint];
            }
            [captureDevice setExposureMode:AVCaptureExposureModeAutoExpose];
        }else{
            OOLog(@"曝光模式修改失败");
        }
    }];
}

/** 设置焦距 */
-(void)doubleTap:(UITapGestureRecognizer *)tapGesture{
    [self changeDevicePropertySafety:^(AVCaptureDevice *captureDevice) {
        if (captureDevice.videoZoomFactor == 1.0) {
            CGFloat current = 2.5;
            if (current < captureDevice.activeFormat.videoMaxZoomFactor) {
                [captureDevice rampToVideoZoomFactor:current withRate:10];
            }
        }else{
            [captureDevice rampToVideoZoomFactor:1.0 withRate:10];
        }
    }];
}

//光圈动画
-(void)setFocusCursorAnimationWithPoint:(CGPoint)point{
    self.focusCircle.center = point;
    self.focusCircle.transform = CGAffineTransformIdentity;
    self.focusCircle.alpha = 0.2;
    
    [UIView animateKeyframesWithDuration:0.8 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:2/8.0 animations:^{
            self.focusCircle.transform=CGAffineTransformMakeScale(0.5, 0.5);
            self.focusCircle.alpha = 1.0;
        }];
        [UIView addKeyframeWithRelativeStartTime:3/8.0 relativeDuration:1/8.0 animations:^{
            self.focusCircle.alpha = 0.5;
        }];
        [UIView addKeyframeWithRelativeStartTime:4/8.0 relativeDuration:1/8.0 animations:^{
            self.focusCircle.alpha = 1.0;
        }];
        [UIView addKeyframeWithRelativeStartTime:5/8.0 relativeDuration:1/8.0 animations:^{
            self.focusCircle.alpha = 0.5;
        }];
        [UIView addKeyframeWithRelativeStartTime:6/8.0 relativeDuration:1/8.0 animations:^{
            self.focusCircle.alpha = 1.0;
        }];
        [UIView addKeyframeWithRelativeStartTime:7/8.0 relativeDuration:1/8.0 animations:^{
            self.focusCircle.alpha = 0.0;
        }];
    } completion:^(BOOL finished) {
        
    }];
}


//更改设备属性前一定要锁上
-(void)changeDevicePropertySafety:(void (^)(AVCaptureDevice *captureDevice))propertyChange{
    //也可以直接用_videoDevice,但是下面这种更好
    AVCaptureDevice *captureDevice= [self.videoInput device];
    NSError *error;
    //注意改变设备属性前一定要首先调用lockForConfiguration:调用完之后使用unlockForConfiguration方法解锁,意义是---进行修改期间,先锁定,防止多处同时修改
    BOOL lockAcquired = [captureDevice lockForConfiguration:&error];
    if (!lockAcquired) {
        OOLog(@"锁定设备过程error，错误信息：%@",error.localizedDescription);
    }else{
        [self.session beginConfiguration];
        propertyChange(captureDevice);
        [captureDevice unlockForConfiguration];
        [self.session commitConfiguration];
    }
}




#pragma mark - Event
/** 录制视频 */
- (void)takeVideoButtonPress:(UILongPressGestureRecognizer *)sender {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
        return;
    }
    
    //判断用户是否允许访问麦克风权限
    authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
        //无权限
        return;
    }
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            [self startVideoRecorder];
            break;
        case UIGestureRecognizerStateCancelled:
            [self stopVideoRecorder];
            break;
        case UIGestureRecognizerStateEnded:
            [self stopVideoRecorder];
            break;
        case UIGestureRecognizerStateFailed:
            [self stopVideoRecorder];
            break;
        default:
            break;
    }
    
}

/** 拍照*/
- (void)takePhotoButtonClick:(UILongPressGestureRecognizer *)sender {
    
    AVCaptureConnection *conntion = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!conntion) {
    OOLog(@"拍照失败!");
        return;
    }
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:conntion completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == nil) {
            return ;
        }
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.delegate && [self.delegate respondsToSelector:@selector(videoRecordView:didPlayWithImageData:)]) {
                [self.delegate videoRecordView:self didPlayWithImageData:imageData];
            }
        });
        //UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:imageData], self,NULL, NULL);
    }];
}

- (void)startVideoRecorder{
    // 设置视频输出的文件路径，这里设置为 temp 文件
    NSURL *videoUrl = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"movie.mov"]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:videoUrl.path]) {
        [[NSFileManager defaultManager] removeItemAtURL:videoUrl error:nil];
    }
    
    // 往路径的 URL 开始写入录像 Buffer ,边录边写
    [self.movieFileOutput startRecordingToOutputFileURL:videoUrl recordingDelegate:self];
    
}

- (void)stopVideoRecorder{
    //禁止录制按钮事件
    self.recorderBtn.userInteractionEnabled = NO;
    
    //停止录制
    [self.movieFileOutput stopRecording];
}

#pragma mark - Getter
- (UIButton *)recorderBtn{
    if (!_recorderBtn) {
        _recorderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _recorderBtn.frame = CGRectMake(140, 400, 50, 50);
        [_recorderBtn setTitle:@"录制" forState:UIControlStateNormal];
        [_recorderBtn addGestureRecognizer:({
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(takePhotoButtonClick:)];
            gesture;
        })];
        [_recorderBtn addGestureRecognizer:({
            UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(takeVideoButtonPress:)];
            gesture;
        })];
    }
    return _recorderBtn;
}

- (UIButton *)cameraLensBtn{
    if (!_cameraLensBtn) {
        _cameraLensBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cameraLensBtn.frame = CGRectMake(200, 50, 70, 70);
        [_cameraLensBtn setTitle:@"前/后" forState:UIControlStateNormal];
        [_cameraLensBtn addTarget:self action:@selector(changeCamera) forControlEvents:UIControlEventTouchDown];
    }
    return _cameraLensBtn;
}

- (UIView *)focusCircleView{
    if (!_focusCircleView) {
        _focusCircleView = [[UIView alloc] init];
        _focusCircleView.frame = CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT - 150);
        _focusCircleView.backgroundColor = [UIColor clearColor];
    }
    return _focusCircleView;
}

- (UIImageView *)focusCircle{
    if (!_focusCircle) {
        _focusCircle = [[UIImageView alloc] init];
        _focusCircle.frame = CGRectMake(0, 0, 120.0, 120.0);
        _focusCircle.image = [UIImage imageNamed:@"video_enlarge"];
        [self.focusCircleView addSubview:_focusCircle];
    }
    return _focusCircle;
}
@end
