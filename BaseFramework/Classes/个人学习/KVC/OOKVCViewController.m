//
//  OOKVCViewController.m
//  BaseFramework
//
//  Created by Beelin on 17/3/28.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import "OOKVCViewController.h"

#import "OOKVOPerson.h"
#import <objc/runtime.h>
@interface OOKVCViewController () 
@property (nonatomic, strong) OOKVOPerson *person;
@end

@implementation OOKVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.person = [[OOKVOPerson alloc] init];
   // [p setValue:@"beelin" forKey:@"name"];

    //OOLog(@"未监听前 isa：%@",p->isa);
   // OOLog(@"未监听前 class: %@",p.class);
    
    [self.person addObserver:self forKeyPath:@"introl" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
       // [self.person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
   
    self.person.name = @"beelin";
  
   // self.person.age = 10;
    
}

- (void)dealloc {
    [self.person removeObserver:self forKeyPath:@"introl"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"name"]) {
        
    }else if ([keyPath isEqualToString:@"age"]) {
        
    }
     OOLog(@"%@ 对象的 %@ 属性改变了：%@", object, keyPath, change);
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.person.name = @"abc";
}


@end
