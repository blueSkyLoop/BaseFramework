//
//  OOProxy.h
//  BaseFramework
//
//  Created by Beelin on 17/2/20.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OOProxy : NSProxy
/**
 The proxy target.
 */
@property (nullable, nonatomic, weak, readonly) id target;

/**
 Creates a new weak proxy for target.
 
 @param target Target object.
 
 @return A new proxy object.
 */
- (_Nullable instancetype)initWithTarget:(_Nullable id)target;

/**
 Creates a new weak proxy for target.
 
 @param target Target object.
 
 @return A new proxy object.
 */
+ (_Nullable instancetype)proxyWithTarget:(_Nullable id)target;
@end
