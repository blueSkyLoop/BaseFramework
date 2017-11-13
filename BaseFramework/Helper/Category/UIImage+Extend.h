//
//  UIImage+Extend.h
//  BaseFramework
//
//  Created by Mantis-man on 16/1/16.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extend)

/** 将颜色转成图片 **/
+ (UIImage *)imageWithColor:(UIColor *)color;

/** 截图 **/
+ (instancetype)captureWithView:(UIView *)view;


@end
