//
//  LaunchViewController.m
//  BaseFramework
//
//  Created by Gatlin on 16/10/18.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "LaunchViewController.h"

#define DWDScreenW [UIScreen mainScreen].bounds.size.width
#define DWDScreenH [UIScreen mainScreen].bounds.size.height
#define DWDRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]// RGB色
@interface LaunchViewController ()<UIScrollViewDelegate, UITabBarControllerDelegate>
@property (nonatomic, strong) UIImageView *imageView0;
@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIImageView *imageView3;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *endButton;
@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubView];
    
}

#pragma mark - private method
- (void)addSubView {
    [self.view addSubview:self.imageView0];
    [self.view insertSubview:self.imageView1 belowSubview:self.imageView0];
    [self.view insertSubview:self.imageView2 belowSubview:self.imageView1];
    [self.view insertSubview:self.imageView3 belowSubview:self.imageView2];
    
    [self.view insertSubview:self.scrollView aboveSubview:self.imageView0];
    [self.view insertSubview:self.pageControl aboveSubview:self.scrollView];
    
    [self.scrollView addSubview:self.endButton];
    self.endButton.center = CGPointMake(DWDScreenW * 3.5, DWDScreenH - 50);
    
}

- (void)calculateImagesAlphaWithPoint:(CGFloat)pointX {
    
    CGFloat imgEnd = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat currentX = 0;
    if (pointX < imgEnd && pointX >= 0) {
        //        0 ~ 320
        self.pageControl.currentPage = 0;
        currentX = pointX;
        //imgeView0
        self.imageView0.alpha = 1 - currentX / imgEnd;
    } else if (pointX < imgEnd * 2 && pointX >= imgEnd) {
        //        320 ~ 640
        self.pageControl.currentPage = 1;
        currentX = pointX - imgEnd;
        //imgeView1
        self.imageView1.alpha = 1 - currentX / imgEnd;
        
    } else if (pointX < imgEnd * 3 && pointX >= imgEnd * 2) {
        //        640 ~ 960
        self.pageControl.currentPage = 2;
        currentX = pointX - imgEnd * 2;
        //imgeView2
        self.imageView2.alpha = 1 - currentX / imgEnd;
    } else if (pointX == imgEnd * 3) {
        self.pageControl.currentPage = 3;
    }else if (pointX > (imgEnd * 3 + 10)) {
        [self endButtonClick];
    }
}

- (void)endButtonClick {
    //do something
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //4张图
    [self calculateImagesAlphaWithPoint:scrollView.contentOffset.x];
}

#pragma mark - setter / getter

- (UIButton *)endButton {
    if (!_endButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [button setTitle:@"立即体验" forState:UIControlStateNormal];
        NSMutableDictionary *attrsDictionary = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:13]
                                                                                  forKey:NSFontAttributeName];
        [attrsDictionary setObject:DWDRGBColor(221, 81, 239) forKey:NSForegroundColorAttributeName];
        NSAttributedString *titleStr = [[NSAttributedString alloc] initWithString:@"立即体验" attributes:attrsDictionary];
        [button setAttributedTitle:titleStr forState:UIControlStateNormal];
        
        button.frame = CGRectMake(DWDScreenW/2-100/2, DWDScreenH - 100, 100, 30);
        UIImage *buttonImage = [UIImage imageNamed:@"btn_come_in"];
        buttonImage = [buttonImage resizableImageWithCapInsets:UIEdgeInsetsMake(buttonImage.size.height * 0.5, buttonImage.size.width * 0.5, buttonImage.size.height * 0.5, buttonImage.size.width * 0.5) resizingMode:UIImageResizingModeStretch];
        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(endButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        _endButton = button;
    }
    return _endButton;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 4, [UIScreen mainScreen].bounds.size.height);
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.backgroundColor = [UIColor clearColor];
        
        scrollView.delegate = self;
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        pageControl.numberOfPages = 4;
        pageControl.pageIndicatorTintColor = DWDRGBColor(188, 235, 253);
        pageControl.currentPageIndicatorTintColor = DWDRGBColor(15, 181, 245);
        //        pageControl.frame.size = [pageControl sizeForNumberOfPages:4];
        //        [pageControl sizeToFit];
        pageControl.center = CGPointMake(DWDScreenW / 2.0, DWDScreenH - 22);
        
        _pageControl = pageControl;
    }
    return _pageControl;
}

- (UIImageView *)imageView0 {
    if (!_imageView0) {
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"one"]];
        view.frame = [UIScreen mainScreen].bounds;
        _imageView0 = view;
    }
    
    return _imageView0;
}

- (UIImageView *)imageView1 {
    if (!_imageView1) {
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"two"]];
        view.alpha = 1.00;
        view.frame = [UIScreen mainScreen].bounds;
        _imageView1 = view;
    }
    
    return _imageView1;
}

- (UIImageView *)imageView2 {
    if (!_imageView2) {
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"three"]];
        view.alpha = 1.00;
        view.frame = [UIScreen mainScreen].bounds;
        _imageView2 = view;
    }
    
    return _imageView2;
}

- (UIImageView *)imageView3 {
    if (!_imageView3) {
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"four"]];
        view.alpha = 1.00;
        view.frame = [UIScreen mainScreen].bounds;
        _imageView3 = view;
    }
    
    return _imageView3;
}


@end
