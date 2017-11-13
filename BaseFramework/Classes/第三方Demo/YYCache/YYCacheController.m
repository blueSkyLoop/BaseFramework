//
//  YYCacheController.m
//  BaseFramework
//
//  Created by Beelin on 17/4/4.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import "YYCacheController.h"

#import "OOCachePerson.h"

#import <YYCache.h>

@interface YYCacheController ()
@property (nonatomic, strong) YYCache *cache;
@end

@implementation YYCacheController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cache = [[YYCache alloc] initWithName:@"mydb"];
    [self testCache];
    //[self memoryCache];
     OOLog(@"cache objects : %@", [_cache objectForKey:@"name"]);
}

- (void)testCache {
    NSString *name = @"cache is granduncle";
    [_cache setObject:name forKey:@"name"];
   
}
- (void)memoryCache {
    YYMemoryCache *mc = [[YYMemoryCache alloc] init];
    
    OOCachePerson *p = [[OOCachePerson alloc] init];
    p.name = @"beelin";
    [mc setObject:p.name forKey:@"name"];
    
    NSString *getname = [mc objectForKey:@"name"];
    OOLog(@"memory cache : %@", getname);
    
    [mc removeObjectForKey:@"name"];
    
    NSString *getname1 = [mc objectForKey:@"name"];
    OOLog(@"memory cache : %@", getname1);
}

@end
