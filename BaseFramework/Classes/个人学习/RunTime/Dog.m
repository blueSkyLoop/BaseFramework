//
//  Dog.m
//  runtime
//
//  Created by Gatlin on 16/5/19.
//  Copyright © 2016年 Mr.Black. All rights reserved.
//

#import "Dog.h"
#import "Cat.h"
@implementation Dog
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if (aSelector == @selector(jump)) {
        return [[Cat alloc] init];
    }
    return [super forwardingTargetForSelector:aSelector];
}
@end
