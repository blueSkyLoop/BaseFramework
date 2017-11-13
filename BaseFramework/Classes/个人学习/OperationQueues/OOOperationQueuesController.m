//
//  OOOperationQueuesController.m
//  BaseFramework
//
//  Created by Beelin on 17/2/16.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import "OOOperationQueuesController.h"

@interface OOOperationQueuesController ()

@end

@implementation OOOperationQueuesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self start];
    [self operationQueue];
}

- (NSInvocationOperation *)invocationOperation{
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(doSomething) object:nil];
    return operation;
}

/*
 注意:只要NSBlockOperation封装的操作数 > 1,就会异步执行操作 
 */
- (NSBlockOperation *)blockOperation{
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        [self doSomething];
    }];
    [operation addExecutionBlock:^{
        [self doSomething];
    }];
    return operation;
}


/*
 操作对象默认在主线程中执行，只有添加到队列中才会开启新的线程。即默认情况下，如果操作没有放到队列中queue中，都是同步执行
 */
- (void)start{
    [[self invocationOperation] start];
    [[self blockOperation] start];
}
/*
 NSOperationQueue的作⽤：NSOperation可以调⽤start⽅法来执⾏任务,但默认是同步执行的
 如果将NSOperation添加到NSOperationQueue(操作队列)中,系统会自动异步执行NSOperation中的操作
 添加操作到NSOperationQueue中，自动执行操作，自动开启线程
 */
- (void)operationQueue{
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    [q addOperation:[self invocationOperation]];
    [q addOperation:[self blockOperation]];
    
    //取消队列的所有操作.也可以调用NSOperation的- (void)cancel⽅法取消单个操作
    [q cancelAllOperations];
    // YES代表暂停队列,NO代表恢复队列
    [q setSuspended:YES];
    //当前状态
    [q isSuspended];
    //暂停和恢复的适用场合：在tableview界面，开线程下载远程的网络界面，对UI会有影响，使用户体验变差。那么这种情况，就可以设置在用户操作UI（如滚动屏幕）的时候，暂停队列（不是取消队列），停止滚动的时候，恢复队列。
}


- (void)doSomething{
    NSLog(@"Start executing %@ with, mainThread: %@, currentThread: %@", NSStringFromSelector(_cmd), [NSThread mainThread], [NSThread currentThread]);
    sleep(3);
}

/*
 // 回到主线程进行显示
 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
 self.imageView.image = image;
 }];
 */

/** 队列优先级
 （1）设置NSOperation在queue中的优先级,可以改变操作的执⾏优先级
 
 - (NSOperationQueuePriority)queuePriority;
 - (void)setQueuePriority:(NSOperationQueuePriority)p;
 
 （2）优先级的取值
 
 NSOperationQueuePriorityVeryLow = -8L,
 
 NSOperationQueuePriorityLow = -4L,
 
 NSOperationQueuePriorityNormal = 0,
 
 NSOperationQueuePriorityHigh = 4,
 
 NSOperationQueuePriorityVeryHigh = 8
 
 说明：优先级高的任务，调用的几率会更大。
 */

/*
 操作的监听
 可以监听一个操作的执行完毕
 
 - (void (^)(void))completionBlock;
 - (void)setCompletionBlock:(void (^)(void))block;
 */
@end
