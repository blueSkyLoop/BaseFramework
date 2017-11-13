//
//  OOGraphicsImage.m
//  BaseFramework
//
//  Created by Beelin on 16/11/25.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "OOGraphicsImage.h"

@implementation OOGraphicsImage

- (void)drawRect:(CGRect)rect {

    
    [self drawImage];
}


/** 复制图片 */
- (void)drawCopyImage{
    UIImage *image = [UIImage imageNamed:@"placeholder"];
    CGSize size = image.size;
    
    UIGraphicsBeginImageContextWithOptions((CGSize){size.width *2, size.height}, NO, 0);
    [image drawAtPoint:CGPointMake(0, 0)];
    [image drawAtPoint:CGPointMake(size.width, 0)];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imv = [[UIImageView alloc] initWithImage:img];
    [self addSubview:imv];
}

/** 缩放图片 */
- (void)drawSalceImage{
    UIImage* mars = [UIImage imageNamed:@"placeholder"];
    CGSize sz = [mars size];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width*2, sz.height*2), NO, 0);
    [mars drawInRect:CGRectMake(0,0,sz.width*2,sz.height*2)];
    [mars drawInRect:CGRectMake(sz.width/2.0, sz.height/2.0, sz.width, sz.height) blendMode:kCGBlendModeMultiply alpha:1.0];
    UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imv = [[UIImageView alloc] initWithImage:img];
    [self addSubview:imv];
}

//CGImage常用的绘图操作
- (void)drawCGImage:(CGRect)rect{
    UIImage *image = [UIImage imageNamed:@"placeholder"];
    CGImageRef cgImage = [image CGImage] ;
    
    CGSize cgSize = CGSizeMake(CGImageGetWidth(cgImage), CGImageGetHeight(cgImage));
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, 0, cgSize.width, cgSize.height));
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextDrawImage(ctx, CGRectMake(0, 0, cgSize.width, cgSize.height), imageRef);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 记得释放内存，ARC在这里无效
    CGImageRelease(imageRef);
   
    UIImageView *imv = [[UIImageView alloc] initWithImage:img];
    [self addSubview:imv];
    
}

//绘画图像圆角
- (void)drawImage{
    CGRect rect = CGRectMake(0, 0, 50, 50);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    
    UIImage *image = [UIImage imageNamed:@"placeholder"];
    [image drawInRect:CGRectMake(0,0,rect.size.width,rect.size.height)];

    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imv = [[UIImageView alloc] init];
    imv.frame = rect;
    imv.image = img;
    [self addSubview:imv];
}
@end
