//
//  OORunloopController.m
//  BaseFramework
//
//  Created by Beelin on 17/3/7.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import "OORunloopController.h"

@interface OORunloopController ()<UIScrollViewDelegate>
{
    CFRunLoopRef runloopRef;
    CFRunLoopSourceRef source;
    __weak NSArray *weakArray;
    
    NSTimer *_timer;
}

@property (nonatomic, assign, getter=isFinish) BOOL finish;
@end

@implementation OORunloopController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = [NSArray array];
    weakArray = array;
    
//    [self testDisPatch];
//    [self willWorkWithOutSource];
 //   [self inputSource];
    
    //场景模拟
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(thirdTest) object:nil];
    //        [thread start];
    //    });
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(firstTest) object:nil];
    [thread start];
}

- (void)willWorkWithOutSource {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        [self commonTimer];
//        [[NSRunLoop currentRunLoop] run];
        NSLog(@"1");
    });
}

- (void)testDisPatch {
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"1");
//    });
    
        dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"1");
                });
    
}

- (void)testTimer{
    UIScrollView *myScroll = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    myScroll.contentSize = CGSizeMake(375, 10000);
    [self.view addSubview:myScroll];
    myScroll.backgroundColor = [UIColor redColor];
    myScroll.delegate = self;
    [self defalutTimer];//defalult mode 下的timer
    [self commonTimer];//common modes中的timer
    
}
- (void)defalutTimer {
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(doTime)
                                   userInfo:nil repeats:YES];//这个timer会默认加到default
}
- (void)commonTimer {
    NSTimer *timer =[NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(doTime)
                                          userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)doTime {
    OOLog(@"%@",[NSRunLoop currentRunLoop].currentMode);
    OOLog(@"timer--");
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    OOLog(@"%@",[NSRunLoop currentRunLoop].currentMode);
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%p",&weakArray);
//    CFRunLoopSourceSignal(source);
//    CFRunLoopWakeUp(runloopRef);
//}

//配置基于端口的输入源
- (void)inputSource {
    //    NSPort *myPort = [NSMachPort port];
    //    [myPort setDelegate:self];//处理了port的传递
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //
    //        [[NSRunLoop currentRunLoop] addPort:myPort forMode:NSDefaultRunLoopMode];
    //        [[NSRunLoop currentRunLoop] run];
    //        NSLog(@"1");
    //    });
    ////    [TestMachPort getPortMessageWithPort:myPort];
    //
    ////    NSPortMessage * message1;
    //
    ////    NSLog(@"%@",MyBlock());
    //   static CFRunLoopRef a;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CFRunLoopSourceContext context = {0,NULL,NULL,NULL,NULL,NULL,NULL,&isadd,&isCancel,&perfor};
        runloopRef = CFRunLoopGetCurrent();
        source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
        CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
        
        NSInteger bb =  CFRunLoopRunInMode(  (__bridge CFStringRef)NSDefaultRunLoopMode, 3, YES) ;
        NSLog(@"%ld",bb);
        
        
        
    });
}
void isadd() {
    NSLog(@"add");
}
void isCancel (){
    NSLog(@"cancel");
}
void perfor () {
    NSLog(@"perform");
}


/** 场景一 不让线程自动退出 */
- (void)firstTest{
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    [loop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    while (!self.finish) {
        @autoreleasepool {
            [loop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3]];
        }
    }
    OOLog(@"loop1 结束");
}

/** 场景二 线程与app生命周期相同 */
- (void)secondTest {
    @autoreleasepool {
        NSRunLoop *loop = [NSRunLoop currentRunLoop];
        [loop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [loop run];
        OOLog(@"loop2 结束");
    }
}

/** 场景三 在一定时间里定时触发事件 */
- (void)thirdTest {
    @autoreleasepool {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(lauchAction) userInfo:nil repeats:YES];
        NSRunLoop *loop = [NSRunLoop currentRunLoop];
        [loop addTimer:_timer forMode:NSRunLoopCommonModes];
        [loop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:30]];
        [_timer invalidate];
        OOLog(@"loop3 结束");
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.finish = YES;
}

- (void)lauchAction {
    static int i = 0;
    i ++;
    OOLog(@"定时第%d次3秒走一波", i);
}

- (void)dealloc {
    [_timer invalidate];
}
@end
