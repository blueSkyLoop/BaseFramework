//
//  OOStepViewController.m
//  BaseFramework
//
//  Created by Beelin on 17/3/14.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import "OOStepViewController.h"

#import <CoreMotion/CoreMotion.h>
@interface OOStepViewController ()
{
    CMPedometer *_pedometer;
}
@end

@implementation OOStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"计步器";
    
    if (![CMPedometer isStepCountingAvailable]) return;
    _pedometer = [[CMPedometer alloc] init];
}

- (void)startPedometer{
    [_pedometer startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if (error) OOLog(@"计步错误");
        OOLog(@"已走%@步",pedometerData.numberOfSteps);
        OOLog(@"已走%@距离",pedometerData.distance);
            
    }];
}

- (void)queryPedometer{
    NSDate *fromDate = [NSDate dateWithTimeIntervalSinceNow:-60*60*24];
    [_pedometer queryPedometerDataFromDate:fromDate toDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if (error) OOLog(@"查询计步错误");
        OOLog(@"查询已走%@步",pedometerData.numberOfSteps);
        OOLog(@"查询已走%@距离",pedometerData.distance);
    }];
}
@end
