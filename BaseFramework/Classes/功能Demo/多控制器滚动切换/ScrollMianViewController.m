//
//  ScrollMianViewController.m
//  BaseFramework
//
//  Created by Gatlin on 16/10/27.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "ScrollMianViewController.h"

#import "ScrollSubOneViewController.h"
#import "ScrollSubTwoViewController.h"
#import "ScrollSubThreeViewController.h"

#import "OOSegmentedControl.h"
@interface ScrollMianViewController ()<UIScrollViewDelegate,OOSegmentedControlDelegate>
@property (nonatomic, strong) UIViewController *currentVC;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) OOSegmentedControl *seg;

@property (nonatomic, strong) NSArray *vc_array;
@end

@implementation ScrollMianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.seg];
    [self.view addSubview:self.scrollView];
    
  
    ScrollSubOneViewController *one = [[ScrollSubOneViewController alloc] init];
    one.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TOPBARHEIGHT - 40);
    [self.scrollView addSubview:one.view];
    
    ScrollSubTwoViewController *two = [[ScrollSubTwoViewController alloc] init];
    two.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TOPBARHEIGHT - 40);
    [self.scrollView addSubview:two.view];
   
    [self addChildViewController:one];
    [self addChildViewController:two];
}



#pragma mark - Getter
- (UIScrollView *)scrollView{
    if (!_scrollView) {
         _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT - 40)];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, _scrollView.height);
    }
    return _scrollView;
}

- (OOSegmentedControl *)seg{
    if (!_seg) {
        _seg = [OOSegmentedControl segmentedControlWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) Titles:@[@"已报名",@"已奖励"] index:0];
        _seg.delegate = self;
    }
    return _seg;
}

#pragma mark  - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger itemTag = scrollView.contentOffset.x / SCREEN_WIDTH;
    [self.seg setupSelectButtonIndex:itemTag];
}
#pragma mark - OOSegmentedControl Delegate
- (void)segmentedControlIndexButtonView:(OOSegmentedControl *)indexButtonView lickBtnAtTag:(NSInteger)tag{
    if (tag == 0) {
        [self.scrollView setContentOffset:CGPointMake(0, 0)  animated:YES];
    }else{
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)  animated:YES];
    }
}
@end
