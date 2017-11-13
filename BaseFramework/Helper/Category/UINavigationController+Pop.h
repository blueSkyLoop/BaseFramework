//
//  UINavigationController+Pop.h
//  test
//
//  Created by Beelin on 16/5/21.
//  Copyright © 2016年 Mr.Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UINavigationControllerShouldPop <NSObject>

- (BOOL)navigationControllerShouldPop:(UINavigationController *)navigationController;

@end
@interface UINavigationController (Pop)<UIGestureRecognizerDelegate>

@end
