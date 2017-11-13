//
//  OOMotionManagerController.m
//  BaseFramework
//
//  Created by Beelin on 17/3/14.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import "OOMotionManagerController.h"

#import <CoreMotion/CoreMotion.h>
@interface OOMotionManagerController ()
{
    CMMotionManager *_motionManager;
}
@property (nonatomic, strong) UIImageView *imv;
@end

@implementation OOMotionManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"motionManager";
    _motionManager = [[CMMotionManager alloc] init];
    if (!_motionManager.isDeviceMotionAvailable) {
        return;
    }
    [self.view addSubview:self.imv];
    
    [self goBack];
    //[self rotation];
}

- (void)goBack{
    __weak typeof(self) weakSelf = self;
    _motionManager.deviceMotionUpdateInterval = 0.01f;
    [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        if (error) {
            OOLog(@"have error");
        }
        if(motion.userAcceleration.x < -0.5f){
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}
- (void)rotation{
    __weak typeof(self) weakSelf = self;
    _motionManager.deviceMotionUpdateInterval = 0.01f;
    [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        double rotation = atan2(motion.gravity.x, motion.gravity.y) - M_PI;
        weakSelf.imv.transform = CGAffineTransformMakeRotation(rotation);
    }];
    
}

- (void)stop{
    [_motionManager stopMagnetometerUpdates];
}
#pragma mark - Getter
- (UIImageView *)imv{
    if (!_imv) {
        _imv = [[UIImageView alloc] init];
        _imv.frame = self.view.bounds;
        _imv.image = [UIImage imageNamed:@"bee"];
    }
    return _imv;
}
@end
