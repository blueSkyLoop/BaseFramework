//
//  Chicken.m
//  runtime
//
//  Created by Gatlin on 16/5/19.
//  Copyright © 2016年 Mr.Black. All rights reserved.
//

#import "Chicken.h"
#import "Cat.h"
@implementation Chicken
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if (aSelector == @selector(jump)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    //改变目标调用
    [anInvocation invokeWithTarget:[[Cat alloc] init]];
    
    //改换选择子
    anInvocation.selector = @selector(fly);
    [anInvocation invokeWithTarget:self];
}

- (void)fly
{
    NSLog(@"fly");
}
@end
