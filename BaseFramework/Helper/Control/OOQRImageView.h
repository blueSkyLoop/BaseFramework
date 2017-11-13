//
//  DWDQRImageView.h
//  EduChat
//
//  Created by Gatlin on 16/1/29.
//  Copyright © 2016年 dwd. All rights reserved.
//  生成二维码 ImageView

#import <UIKit/UIKit.h>

@interface OOQRImageView : UIImageView

/** 生成一张纯二维码的图片 **/
- (instancetype)initWithQRImageForString:(NSString *)string;

/** 生成一张二维码与中间带头像的图片 **/
- (instancetype)initWithQRImageForString:(NSString *)string avatar:(UIImage *)avatar;
@end
