//
//  ZZScrollView.m
//  5_AutoScrollView
//
//  Created by liuweizhen on 15/9/6.
//  Copyright (c) 2015年 勇敢的心. All rights reserved.
//

#import "ZZScrollView.h"

@interface ZZScrollView () <UIScrollViewDelegate>

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIImageView *leftImageView;
@property (nonatomic) UIImageView *centerImageView;
@property (nonatomic) UIImageView *rightImageView;
@property (nonatomic) NSInteger centerPage;

@property (nonatomic) UIPageControl *pageControl;
@end

@implementation ZZScrollView

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self setUp];
    [self startTimer];
}

- (void)startTimer {
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
}

- (void)timerAction:(NSTimer *)timer {
    // 代码让scrollView滚动
    CGPoint offset = self.scrollView.contentOffset;
    offset.x += self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:offset animated:YES];
    // 这个方法会触发代理方法：- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
}

// 012345
// - - -
// 5 0 1
- (void)setUp {
    // 加一个scrollView, 把3张imageView对象加在这个scrollView上面
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.delegate = self; // 当滚动结束时，调代理方法，我们在代理方法中调整偏移量等事项
    _scrollView.pagingEnabled = YES;
    // _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    _scrollView.showsHorizontalScrollIndicator = NO; // 隐藏水平滚动条
    [self.scrollView setContentSize:CGSizeMake(3*self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.scrollView];
    
    CGRect frame = self.bounds;
    self.leftImageView = [[UIImageView alloc] initWithFrame:frame];
    
    frame.origin.x += self.frame.size.width;
    self.centerImageView = [[UIImageView alloc] initWithFrame:frame];
    
    frame.origin.x += self.frame.size.width;
    self.rightImageView = [[UIImageView alloc] initWithFrame:frame];
    
    [_scrollView addSubview:_leftImageView];
    [_scrollView addSubview:_centerImageView];
    [_scrollView addSubview:_rightImageView];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-40, self.frame.size.width, 40)];
    // self.pageControl.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.6];
    self.pageControl.numberOfPages = self.imageArray.count;
    [self addSubview:_pageControl];
    
    self.centerPage = 0; // 当前应该显示的是数组self.imageArray[0]这张图片
}

// 012345
- (void)setCenterPage:(NSInteger)centerPage {
    // centerPage -> 中间的imageView
    // leftPage -> 左侧的imageView
    // rightPage -> 右侧的iamgeView
    _centerPage = centerPage;
    if (_centerPage < 0) {
        _centerPage = self.imageArray.count - 1;
    }
    if (_centerPage > self.imageArray.count - 1) {
        _centerPage = 0; // 450
    }
    
    // _centerPage 0
    // 5 0 1
    NSInteger leftPage = _centerPage - 1 < 0 ? self.imageArray.count-1 : _centerPage - 1;
    
    // 4 5 0
    NSInteger rightPage = _centerPage + 1 > self.imageArray.count - 1 ? 0 : _centerPage + 1;
    self.leftImageView.image   = self.imageArray[leftPage];
    self.centerImageView.image = self.imageArray[_centerPage];
    self.rightImageView.image  = self.imageArray[rightPage];
    
    // 显示中间那一页
    [self.scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];

    // 设置pageControl的页码
    self.pageControl.currentPage = _centerPage;
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 如果显示下一页，页码+1
    if (scrollView.contentOffset.x > scrollView.frame.size.width) { // 向一张
        self.centerPage++;
    } else if (scrollView.contentOffset.x < scrollView.frame.size.width) { // 上一张
        self.centerPage--;
    }
}

// 能过代码让scrollView滚动结束时才会调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.centerPage++;
}

@end
