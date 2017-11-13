//
//  OONSCacheController.m
//  BaseFramework
//
//  Created by Beelin on 16/12/10.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "OONSCacheController.h"

@interface OONSCacheController ()<NSCacheDelegate>
@property (nonatomic, strong) NSCache *cache;
@end

@implementation OONSCacheController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     NSLog(@"%@", [self.cache objectForKey:@"123"]);
}


#pragma mark - Getter
- (NSCache *)cache{
    if (!_cache) {
        _cache = [[NSCache alloc] init];
        /**  NSCache类以下几个属性用于限制成本
         NSUInteger totalCostLimit  "成本" 限制，默认是0（没有限制）
         NSUInteger countLimit  数量的限制  默认是0 （没有限制）
         
         // 设置缓存的对象，同时指定限制成本
         -(void)setObject:(id) obj  forKey:(id) key cost:(NSUInteger) g
         */
        
        // 设置数量限额。一旦超出限额，会自动删除之前添加的东西
        _cache.countLimit = 30;  // 设置了存放对象的最大数量
        _cache.delegate = self;
    }
    return _cache;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    for (int i =0 ; i< 100; i++) {
//        // 向缓存中添加对象
//        NSString *str = [NSString stringWithFormat:@"hello - %d", i];
//        [self.cache setObject:str forKey:@(i)];
//    }
//    for (int i=0 ; i< 100; i++) {
//        NSLog(@"%@", [self.cache objectForKey:@(i)]);
//    }
    
    [self.cache setObject:@"beelin" forKey:@"123"];
    NSLog(@"%@", [self.cache objectForKey:@"123"]);
}


// NSCache的代理方法只有一个
//  告诉即将要被删除的对象
-(void)cache:(NSCache *)cache willEvictObject:(id)obj
{
    // 此代理方法主要用于程序员的测试
    NSLog(@"要删除的对象obj-------------%@", obj);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
