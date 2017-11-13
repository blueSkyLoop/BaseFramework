//
//  OOCachePerson.m
//  BaseFramework
//
//  Created by Beelin on 17/4/4.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import "OOCachePerson.h"

@implementation OOCachePerson 

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self) {
        _name = [coder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
