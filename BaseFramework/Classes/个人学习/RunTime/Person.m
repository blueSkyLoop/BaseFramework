//
//  Person.m
//  runtime
//
//  Created by Mantis on 16/5/11.
//  Copyright © 2016年 Mr.Black. All rights reserved.
//

#import "Person.h"

@implementation Person


- (void)run
{
    NSLog(@"%@, %p", self, _cmd);
}
- (void)eat:(NSString *)string array:(NSArray *)array
{
    
}

- (instancetype)ha
{
    return 0;
}
- (NSString *)s
{
    return @"a";
}
+ (instancetype)eat
{
    Person *person  = [[Person alloc] init];
    
    
    return person;
}


@end
