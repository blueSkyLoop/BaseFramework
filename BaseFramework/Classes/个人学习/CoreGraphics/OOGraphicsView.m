//
//  OOGraphicsView.m
//  BaseFramework
//
//  Created by Beelin on 16/11/24.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "OOGraphicsView.h"

@implementation OOGraphicsView

- (void)drawRect:(CGRect)rect {
    
    [self drawShow];
    
//    [self drawCircleAtX:100 Y:50];
  
    
}

/** 绘制圆形 */
//以指定中心点绘制圆弧
- (void)drawCircleAtX:(float)x Y:(float)y {
    
    // 获取当前图形，视图推入堆栈的图形，相当于你所要绘制图形的图纸
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 创建一个新的空图形路径。
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    
    /**
     *  @brief 在当前路径添加圆弧 参数按顺序说明
     *
     *  @param c           当前图形
     *  @param x           圆弧的中心点坐标x
     *  @param y           曲线控制点的y坐标
     *  @param radius      指定点的x坐标值
     *  @param startAngle  弧的起点与正X轴的夹角，
     *  @param endAngle    弧的终点与正X轴的夹角
     *  @param clockwise   指定1创建一个顺时针的圆弧，或是指定0创建一个逆时针圆弧
     *
     */
    CGContextAddArc(ctx, x, y, 20, 0, 2 * M_PI, 1);
    
    //绘制当前路径区域
    CGContextFillPath(ctx);
}
/** 实心圆 */
- (void)drawEllipse{
     // 1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.画图
    CGContextAddEllipseInRect(ctx, CGRectMake(0,0,100,100));
    
//    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    //CGContextSetRGBFillColor(con, 0.5, 0.5, 0.5, 1);
    
     // 3.渲染
//     CGContextFillPath(ctx);
    CGContextStrokePath(ctx);
}

- (void)drawLine{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, 100, 100);
    CGContextAddLineToPoint(ctx, 150, 100);
    CGContextClosePath(ctx);
    
    CGContextSetLineWidth(ctx, 2.0f); // 线的宽度
//    CGContextSetLineCap(ctx, kCGLineCapRound); // 起点和重点圆角
    CGContextSetLineJoin(ctx, kCGLineJoinRound); // 转角圆角
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokePath(ctx); // 渲染（直线只能绘制空心的，不能调用CGContextFillPath(ctx);）
    
//    CGContextSetRGBFillColor(ctx, 0.2, 0.3, 0.4, 1);
//    CGContextFillPath(ctx);
}

/** 绘制曲线 */
- (void)drawCurve {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    /**
     *  @brief 在指定点开始一个新的子路径 参数按顺序说明
     *
     *  @param c 当前图形
     *  @param x 指定点的x坐标值
     *  @param y 指定点的y坐标值
     *
     */
    CGContextMoveToPoint(ctx, 50, 150);
    /**
     *  @brief 在指定点追加二次贝塞尔曲线，通过控制点和结束点指定曲线。
     *         关于曲线的点的控制见下图说明，图片来源苹果官方网站。参数按顺序说明
     *  @param c   当前图形
     *  @param cpx 曲线控制点的x坐标
     *  @param cpy 曲线控制点的y坐标
     *  @param x   指定点的x坐标值
     *  @param y   指定点的y坐标值
     *
     */
    CGContextAddQuadCurveToPoint(ctx, 100, 0, 150, 200);
    CGContextSetStrokeColorWithColor(ctx, [UIColor greenColor].CGColor);
    CGContextSetLineWidth(ctx, 3);
    CGContextStrokePath(ctx);
}

/** 阴影 */
- (void)drawShow{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddRect(ctx, CGRectMake(20, 20, 50, 50));
    CGContextSetFillColorWithColor(ctx, [UIColor orangeColor].CGColor);
    CGContextSetShadowWithColor(ctx, CGSizeMake(5, 5), 10, [UIColor greenColor].CGColor);
    CGContextFillPath(ctx);
}


/** 绘画字符串 */
- (void)drawString:(CGRect)rect{
    NSString *string = @"string";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor redColor]; // 文字颜色
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:14]; // 字体
    
    [string drawInRect:rect withAttributes:dict];
}
@end
