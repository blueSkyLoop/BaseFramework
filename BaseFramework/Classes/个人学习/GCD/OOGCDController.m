//
//  OOGCDController.m
//  BaseFramework
//
//  Created by Beelin on 17/3/20.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//  学习博客 http://www.jianshu.com/p/d56064507fb8

#import "OOGCDController.h"

@interface OOGCDController ()

@end

@implementation OOGCDController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/** 全局队列 */
- (void)globalQueue{
    //全局队列的四种类型
    DISPATCH_QUEUE_PRIORITY_HIGH;
    DISPATCH_QUEUE_PRIORITY_DEFAULT;
    DISPATCH_QUEUE_PRIORITY_LOW;
    DISPATCH_QUEUE_PRIORITY_BACKGROUND;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

/** 串行队列 */
- (void)serialQueue{
    //dispatch_queue_attr_t设置成NULL的时候默认代表串行
    dispatch_queue_t queue = dispatch_queue_create("com.example.SerialQueue", NULL);
}

/** 并行队列 */
- (void)concurrentQueue{
    dispatch_queue_t queue = dispatch_queue_create("com.example.Concurrent", DISPATCH_QUEUE_CONCURRENT);
}

/** 并发执行迭代循环
 dispatch_apply函数是没有异步版本的。解决的方法是只要用dispatch_async函数将所有代码推到后台就行了。
 */
- (void)apply{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    int count = 10;
    dispatch_apply(count, queue, ^(size_t i) {
        NSLog(@"%zu",i);
    });
}

/** 挂起和恢复队列
 执行挂起操作不会对已经开始执行的任务起作用，它仅仅只会阻止将要进行但是还未开始的任务。
 */
- (void)suspendAndResume{
    dispatch_queue_t myQueue;
    myQueue = dispatch_queue_create("com.example.MyCustomQueue", NULL);
    //挂起队列
    dispatch_suspend(myQueue);
    //恢复队列
    dispatch_resume(myQueue);
}

/** 组队列 */
- (void)groupQueue{
    dispatch_group_t groupQueue = dispatch_group_create();
    dispatch_group_async(groupQueue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       NSLog(@"并行任务1");
    });
    
    dispatch_group_async(groupQueue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       NSLog(@"并行任务2");
    });
   
    //dispatch_group_enter(groupQueue);
//    dispatch_group_leave(groupQueue);
    
    dispatch_group_notify(groupQueue, dispatch_get_main_queue(), ^{
        NSLog(@"groupQueue中的任务 都执行完成,回到主线程更新UI");
    });
    
    
}

/** 栅栏
 先执行barrier之前任务，再执行barrier之后任务
 */
- (void)barrier{
    //barrier 不能用全局队列
    dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        OOLog(@"并行任务1");
    });
    dispatch_async(queue, ^{
        OOLog(@"并行任务2");
    });

    dispatch_barrier_async(queue, ^{
        OOLog(@"---barrier---");
    });
    
    dispatch_async(queue, ^{
        OOLog(@"并行任务3");
    });
    dispatch_async(queue, ^{
        OOLog(@"并行任务4");
    });
}
@end
