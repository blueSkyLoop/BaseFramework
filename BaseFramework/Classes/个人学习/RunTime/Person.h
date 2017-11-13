//
//  Person.h
//  runtime
//
//  Created by Mantis on 16/5/11.
//  Copyright © 2016年 Mr.Black. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    NSArray  *array;
    NSString *name;
}
@property (nonatomic, copy) NSString *name;

- (void)run;
- (void)eat:(NSString *)string array:(NSArray *)array;


- (instancetype)ha;
- (NSString *)s;
+ (instancetype)eat;
@end
