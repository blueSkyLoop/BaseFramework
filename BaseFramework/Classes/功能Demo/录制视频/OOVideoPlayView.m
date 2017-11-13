//
//  OOVideoPlayView.m
//  BaseFramework
//
//  Created by Beelin on 17/2/22.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import "OOVideoPlayView.h"

#import <AVFoundation/AVFoundation.h>

@interface OOVideoPlayView (){
    CGRect _porVertical;
    CGRect _porCross;
    CGRect _lanVertical;
    CGRect _lanCross;
}
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayerItem *playerItem;

@end

#define VIDEO_CROSS_HEIGHT 200*(SCREEN_HEIGHT/480.0)
@implementation OOVideoPlayView

#pragma mark - life Cycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _porVertical = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _porCross = CGRectMake(SCREEN_HEIGHT/2.0 - VIDEO_CROSS_HEIGHT/2.0, 0, VIDEO_CROSS_HEIGHT, SCREEN_WIDTH);
        _lanVertical = CGRectMake(0, SCREEN_HEIGHT/2.0 - VIDEO_CROSS_HEIGHT/2.0, SCREEN_WIDTH, VIDEO_CROSS_HEIGHT);
        _lanCross = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH);
       
        self.frame = _porVertical;
        self.backgroundColor = [UIColor blackColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playbackFinished:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:nil];
        //监听设备旋转
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(orientationChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
    }
    return self;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:nil];
}

#pragma mark - Notification Implementation
- (void)playbackFinished:(NSNotification *)notification{
    if (notification.object == _playerItem) {
        [_player seekToTime:kCMTimeZero];
        [_player play];
    }
}

//获取设备的旋转方向,然后进行判断如何旋转UI
-(void)orientationChanged:(NSNotification *)notification{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];

    //根据监测到的旋转方向,进行旋转
    switch (orientation) {
        case UIDeviceOrientationPortrait:
            if(_videoOrientation == OOVideoOrientationPortrait){
                self.playerLayer.frame = _porVertical;
            
            }else{
                self.playerLayer.frame = _lanVertical;
            }
            self.frame = _porVertical;
            break;
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
            if(self.videoOrientation == OOVideoOrientationPortrait){
                self.playerLayer.frame = _porCross;
            }else{
                self.playerLayer.frame = _lanCross;
            }
            self.frame = _lanCross;
            break;
        default:
            break;
    }
}


#pragma mark - Public Method
- (void)play{
    [_player play];
}

- (void)pause{
    _playerItem = nil;
    [_player pause];
    _player = nil;
    [_playerLayer removeFromSuperlayer];
    _playerLayer = nil;
}

#pragma mark - Setter
- (void)setVideoUrl:(NSURL *)videoUrl{
    _videoUrl = videoUrl;
   
    [self.layer addSublayer:self.playerLayer];
}

#pragma mark - Getter
- (AVPlayer *)player{
    if (!_player) {
        _player = [AVPlayer playerWithPlayerItem:self.playerItem];
    }
    return _player;
}

- (AVPlayerItem *)playerItem{
    if (!_playerItem) {
        _playerItem = [AVPlayerItem playerItemWithURL:self.videoUrl];
    }
    return _playerItem;
}

- (AVPlayerLayer *)playerLayer{
    if (!_playerLayer) {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        if (self.videoOrientation == OOVideoOrientationPortrait) {
            _playerLayer.frame = _porVertical;
            
        }else{
            _playerLayer.frame = _lanVertical;
        }
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return _playerLayer;
}
@end
