//
//  ZPBaseScrollView.m
//  MangoCityTravel
//
//  Created by linzhipei on 15-3-22.
//  Copyright (c) 2015年 mangocity. All rights reserved.
//

//#import <SDWebImage/UIImageView+WebCache.h>
#import "OOBannerView.h"

#define ADHIGHT 155
#define PADDING 10 //差值
@interface OOBannerView() <UIScrollViewDelegate>
@property (weak, nonatomic)  UIScrollView *scrollView;
@property (weak, nonatomic)  UIPageControl *pageControl;
/** 定时器 */
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation OOBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *scr = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView = scr;
        scr.delegate = self;
        scr.pagingEnabled = YES;
        scr.showsVerticalScrollIndicator = NO;
        scr.showsHorizontalScrollIndicator = NO;
        [self addSubview:scr];
        
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height - 30, frame.size.width, 30)];
        _pageControl = pageControl;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = ColorMain;
        [self addSubview:pageControl];
        // 开启定时器
        [self startTimer];
        
    }
    return self;
}



/**
 *  根据图片名数据做一些操作
 */
- (void)setDataSource:(NSArray *)dataSource
{
    // 防止崩溃
    if (dataSource.count == 0) return;
    NSMutableArray *mDataSource = [dataSource mutableCopy];
    // 复制最后一个对象插入第0下标
    [mDataSource insertObject:[mDataSource lastObject] atIndex:0];
    // 复制第一个对象插入最后下标
    [mDataSource addObject:mDataSource[1]];
    
    _dataSource = mDataSource;
    
    // 先移除所有的imageView
    // 让self.scrollView.subviews数组中的所有对象都执行removeFromSuperview方法
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 根据图片名数据创建对应的imageView
    for (int i = 0; i<_dataSource.count; i++) {
        OOBannerModel *model = _dataSource[i];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContent:)];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
//        [imageView sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:DWDDefault_infoPhotoImage];
        imageView.image = [UIImage imageNamed:model.imageName];//test
        imageView.frame = CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_WIDTH/375.0 * ADHIGHT);
        imageView.backgroundColor = ColorBackgroud;
        [imageView addGestureRecognizer:tap];
        [self.scrollView addSubview:imageView];
    }
    
    // 设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(_dataSource.count * SCREEN_WIDTH, 0);
    
    // 设置总页数
    self.pageControl.numberOfPages = _dataSource.count - 2;
    
    //设置初始滑动到实际的第一张图位置
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
    [self.scrollView setContentSize:CGSizeMake(_dataSource.count*self.scrollView.frame.size.width, self.frame.size.height)];
}

#pragma mark - 定时器相关
- (void)startTimer
{
    // 返回一个自动开始执行任务的定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage:) userInfo:nil repeats:YES];
    
    // 修改NSTimer在NSRunLoop中的模式：NSRunLoopCommonModes
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

// 程序一启动就会创建一条主线程

/**
 *  显示下一页
 */
- (void)nextPage:(NSTimer *)timer
{
    int x =  self.scrollView.contentOffset.x/SCREEN_WIDTH;
    x++;
    if (x>self.dataSource.count) {
        x = 1;
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*x, 0) animated:NO];
    }
    
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*x, 0) animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x>((self.dataSource.count-1)*SCREEN_WIDTH-PADDING)) {
        [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
    }else if (scrollView.contentOffset.x<PADDING){
        [scrollView setContentOffset:CGPointMake(((self.dataSource.count-2)*SCREEN_WIDTH), 0) animated:NO];
    }
    self.pageControl.currentPage = (scrollView.contentOffset.x + SCREEN_WIDTH*.5)/SCREEN_WIDTH-1;
    
}

/**
 *  当用户即将开始拖拽scrollView时，停止定时器
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

/**
 *  当用户已经结束拖拽scrollView时，开启定时器
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

- (void)tapContent:(UITapGestureRecognizer *)sender {
    !self.clickImageBlock ?: self.clickImageBlock(self.dataSource[sender.view.tag]);
}

@end



@implementation OOBannerModel
@end
