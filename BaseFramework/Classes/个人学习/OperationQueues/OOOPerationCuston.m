//
//  OOOPerationCuston.m
//  BaseFramework
//
//  Created by Beelin on 17/3/22.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import "OOOPerationCuston.h"

@implementation OOOPerationCuston
/*
 自定义main方法执行你的任务
 默认情况下，该operation在当前调用start的线程中执行.其实如果我们创建多个自定义的ZCNoCurrentOperation，并放入NSOperationQueue中，这些任务也是并发执行的，只不过因为我们没有处理并发情况下，线程执行完，KVO等操作，因此不建议在只实现main函数的情况下将其加入NSOperationQueue，只实现main一般只适合自定义非并发的。
 */

/*
- (void)main {
    //捕获异常
    @try {
        //在这里我们要创建自己的释放池，因为这里我们拿不到主线程的释放池
        @autoreleasepool {
            
            BOOL isDone = NO;
            
            //正确的响应取消事件
            while(![self isCancelled] && !isDone)
            {
                //在这里执行自己的任务操作
                NSLog(@"执行自定义非并发NSOperation");
                NSThread *thread = [NSThread currentThread];
                NSLog(@"%@",thread);
                
                //任务执行完成后将isDone设为YES
                isDone = YES;
            }
        }
        
    }
    @catch (NSException *exception) {
        
    }
    
}
*/


/*
 *自定义并发的NSOperation需要以下步骤：
 1.start方法：该方法必须实现，
 2.main:该方法可选，如果你在start方法中定义了你的任务，则这个方法就可以不实现，但通常为了代码逻辑清晰，通常会在该方法中定义自己的任务
 3.isExecuting  isFinished 主要作用是在线程状态改变时，产生适当的KVO通知
 4.isConcurrent :必须覆盖并返回YES;
 */
{
    BOOL executing;
    BOOL finished;
}
- (id)init {
    if(self = [super init])
    {
        executing = NO;
        finished = NO;
    }
    return self;
}
- (BOOL)isConcurrent {
    
    return YES;
}
- (BOOL)isExecuting {
    
    return executing;
}
- (BOOL)isFinished {
    
    return finished;
}

- (void)start {
    
    //第一步就要检测是否被取消了，如果取消了，要实现相应的KVO
    if ([self isCancelled]) {
        
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    //如果没被取消，开始执行任务
    [self willChangeValueForKey:@"isExecuting"];
    
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)main2 {
    @try {
        
        @autoreleasepool {
            //在这里定义自己的并发任务
            NSLog(@"自定义并发操作NSOperation");
            NSThread *thread = [NSThread currentThread];
            NSLog(@"%@",thread);
            
            //任务执行完成后要实现相应的KVO
            [self willChangeValueForKey:@"isFinished"];
            [self willChangeValueForKey:@"isExecuting"];
            
            executing = NO;
            finished = YES;
            
            [self didChangeValueForKey:@"isExecuting"];
            [self didChangeValueForKey:@"isFinished"];
        }
    }
    @catch (NSException *exception) {
        
    }
    
}
@end
