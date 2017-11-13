//
//  Cat.m
//  runtime
//
//  Created by Gatlin on 16/5/19.
//  Copyright © 2016年 Mr.Black. All rights reserved.
//

#import "Cat.h"
#import <objc/runtime.h>
void jump (id self, SEL cmd);
@implementation Cat

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if ([NSStringFromSelector(sel) isEqualToString:@"jump"]) {
        class_addMethod(self, sel, (IMP)jump, "v@:");
        return YES;
    }
    
    return [super resolveClassMethod:sel];
}


void jump(id self, SEL cmd)
{
    NSLog(@"%@ jump",self);
}

@end
