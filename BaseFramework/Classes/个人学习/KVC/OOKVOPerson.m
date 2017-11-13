//
//  OOKVOPerson.m
//  BaseFramework
//
//  Created by Beelin on 17/4/6.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import "OOKVOPerson.h"

@implementation OOKVOPerson
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    BOOL automatic = YES;
    if ([key isEqualToString:@"name"]) {
        automatic = NO;
    }else {
        [super automaticallyNotifiesObserversForKey:key];
    }
    return automatic;
}

- (void)setName:(NSString *)name {
    if (_name != name) {
        [self willChangeValueForKey:@"name"];
        _name = name;
        [self didChangeValueForKey:@"name"];
    }
}

//定义依赖关系
- (NSString *)introl {
    return [NSString stringWithFormat:@"我是%@", self.name];
}
//重写/这个方法返回的是一个集合对象，包含了那些影响key指定的属性依赖的属性所对应的字符串。
+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    if ([key isEqualToString:@"introl"]) {
        keyPaths = [keyPaths setByAddingObject:@"name"];
    }
    return keyPaths;
}

@end
