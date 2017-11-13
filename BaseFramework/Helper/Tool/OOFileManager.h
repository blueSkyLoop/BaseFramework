//
//  OOFileManager.h
//  BaseFramework
//
//  Created by Beelin on 17/3/2.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OOFileManager : NSObject
+ (id)sharedManager;
/** 
 检测文件是否存在本地
 存在则返回文件本地url路径*/
- (void)isExistFileName:(NSString *)fileName exist:(void(^)(NSURL *))existBlock nonExist:(void(^)())nonExistBlock;

- (NSURL *)getFileUrlWtihFileName:(NSString *)fileName;
@end
