//
//  OOCoreTextView.m
//  BaseFramework
//
//  Created by Beelin on 16/11/29.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "OOCoreTextView.h"
#import <CoreText/CoreText.h>
@implementation OOCoreTextView

- (void)drawRect:(CGRect)rect {
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    //flip the coordinate system
    CGContextSetTextMatrix(con, CGAffineTransformIdentity);
    CGContextTranslateCTM(con, 0, self.bounds.size.height);
    CGContextScaleCTM(con, 1.0, -1.0);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, rect);
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"古墨林"];
    
    CTFramesetterRef setRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)att);
    CTFrameRef frameRef = CTFramesetterCreateFrame(setRef, CFRangeMake(0, att.length), path, NULL);
    CTFrameDraw(frameRef, con);
    
    CFRelease(setRef);
    CFRelease(frameRef);
    CGPathRelease(path);
}


@end
