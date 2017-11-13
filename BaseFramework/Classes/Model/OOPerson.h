//
//  OOPerson.h
//  BaseFramework
//
//  Created by Beelin on 17/3/16.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OOPerson : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) void(^callBlock)();
@end
