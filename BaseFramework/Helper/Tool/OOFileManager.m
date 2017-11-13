//
//  OOFileManager.m
//  BaseFramework
//
//  Created by Beelin on 17/3/2.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import "OOFileManager.h"
//获取沙盒 Libaray目录的Cache
#define PATH_CACHE [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
@implementation OOFileManager

+ (id)sharedManager
{
    static OOFileManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[OOFileManager alloc] init];
    });
    return manager;
}


- (void)isExistFileName:(NSString *)fileName exist:(void(^)(NSURL *))existBlock nonExist:(void(^)())nonExistBlock{
   NSURL *filrUrl = [self getFileUrlWtihFileName:fileName];
    
    NSFileManager *f = [NSFileManager defaultManager];
    if ([f fileExistsAtPath:filrUrl.path]) {
        existBlock(filrUrl);
    }else{
        nonExistBlock();
    }
}

- (NSURL *)getFileUrlWtihFileName:(NSString *)fileName{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", PATH_CACHE, fileName];
    return [NSURL fileURLWithPath:filePath];
}
@end
