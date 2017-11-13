//
//  UINavigationController+Pop.m
//  test
//
//  Created by Gatlin on 16/5/21.
//  Copyright © 2016年 Mr.Black. All rights reserved.
//

#import "UINavigationController+Pop.h"
#import "SwizzlingDefine.h"
#import <objc/runtime.h>
@implementation UINavigationController (Pop)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = [self class];
        
        SEL originalSelector = @selector(viewDidLoad);
        SEL swizzledSelector = @selector(oo_viewDidLoad);
        swizzling_exchangeMethod(cls, originalSelector, swizzledSelector);

        
        SEL originalPopSelector = @selector(navigationBar:shouldPopItem:);
        SEL swizzledPopSelector = @selector(oo_navigationBar:shouldPopItem:);
        swizzling_exchangeMethod(cls, originalPopSelector, swizzledPopSelector);
    });
}

- (void)oo_viewDidLoad
{
    [self oo_viewDidLoad];
    
    objc_setAssociatedObject(self, @selector(oo_viewDidLoad), self.interactivePopGestureRecognizer.delegate, OBJC_ASSOCIATION_ASSIGN);
    
    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (BOOL)oo_navigationBar:(UINavigationBar *)bar shouldPopItem:(UINavigationItem *)item
{
    UIViewController *vc = self.topViewController;
    if (item != vc.navigationItem) {
        return YES;
    }
    
    if ([vc conformsToProtocol:@protocol(UINavigationControllerShouldPop)]) {
        if ([(id<UINavigationControllerShouldPop>)vc navigationControllerShouldPop:self])
        {
            return [self oo_navigationBar:bar shouldPopItem:item];
        }
        else
        {
            return NO;
        }
        
    }
    else
    {
        return [self oo_navigationBar:bar shouldPopItem:item];
    }
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        
        UIViewController *vc = self.topViewController;
        
        if ([vc conformsToProtocol:@protocol(UINavigationControllerShouldPop)]) {
            if (![(id<UINavigationControllerShouldPop>)vc navigationControllerShouldPop:self])
            {
                return NO;
            }
        }
        id<UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, @selector(oo_viewDidLoad));
        return [originDelegate gestureRecognizerShouldBegin:gestureRecognizer];
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
   if (gestureRecognizer == self.interactivePopGestureRecognizer)
   {
       id<UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, @selector(oo_viewDidLoad));
       return [originDelegate gestureRecognizer:gestureRecognizer shouldReceiveTouch:touch];
 
   }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer)
    {
        id<UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, @selector(oo_viewDidLoad));
        return [originDelegate gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
        
    }
    return YES;
 
}
@end
