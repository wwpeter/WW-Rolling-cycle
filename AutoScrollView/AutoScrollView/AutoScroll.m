//
//  AutoScroll.m
//  AutoScrollView
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 朱明科. All rights reserved.
//

#import "AutoScroll.h"
#import "ShowViewController.h"

@interface AutoScroll()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    NSTimer *_timer;
    UIImageView *_leftImageView;
    UIImageView *_centerImageView;
    UIImageView *_rightImageView;
    UILabel *_leftLabel;
    UILabel *_centerLabel;
    UILabel *_rightLabel;
    NSArray *_imageArray;//显示的图片
    NSArray *_titleArray;//显示标题
    UIPageControl *_pageController;
    
}
@end
@implementation AutoScroll
-(id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray{
    if (self = [super initWithFrame:frame]) {
        _imageArray = imageArray;
        _titleArray = titleArray;
        if (_imageArray.count <= 1) {
            return self;
        }
        [self createScrollView];
        [self createContentViews];
        [self createPageController];
        [self createTitle];
        [self startTimer];
    }
    return  self;
}

-(void)createScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(3*self.frame.size.width, self.frame.size.height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) ];
    [self addSubview:_scrollView];
    
}
//显示三张
-(void)createContentViews{
    _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _leftImageView.tag = _imageArray.count-1;
    _leftImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    [_leftImageView addGestureRecognizer:tap1];
    _leftImageView.image = [_imageArray objectAtIndex:_leftImageView.tag];
    
    _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    _centerImageView.tag = 0;
    _centerImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    [_centerImageView addGestureRecognizer:tap2];
    _centerImageView.image = [_imageArray objectAtIndex:_centerImageView.tag];
    
    _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*2, 0, self.frame.size.width, self.frame.size.height)];
    _rightImageView.tag = 1;
    _rightImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    [_rightImageView addGestureRecognizer:tap3];
    _rightImageView.image = [_imageArray objectAtIndex:_rightImageView.tag];
    
    [_scrollView addSubview:_leftImageView];
    [_scrollView addSubview:_centerImageView];
    [_scrollView addSubview:_rightImageView];

}
//页码控制器
-(void)createPageController{
    _pageController = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    _pageController.center = CGPointMake(self.frame.size.width-50, self.frame.size.height);
    _pageController.numberOfPages = _imageArray.count;
    _pageController.pageIndicatorTintColor = [UIColor whiteColor];
    _pageController.currentPageIndicatorTintColor = [UIColor redColor];
    [self addSubview:_pageController];
}

//点击触发的事件
-(void)handleGesture:(UITapGestureRecognizer *)tap{
    ShowViewController *showController = [[ShowViewController alloc]init];
    if (tap.view.tag > _imageArray.count) {
        return;
    }
    showController.str = self.picUrl[tap.view.tag];
    [self.viewController presentViewController:showController animated:YES completion:nil];
}
-(void)createTitle{
    _leftLabel = [[UILabel alloc]init];
    _centerLabel = [[UILabel alloc]init];
    _rightLabel = [[UILabel alloc]init];
    UIColor *labelColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    _leftLabel.backgroundColor = _rightLabel.backgroundColor = _centerLabel.backgroundColor = labelColor;
    CGRect frame = CGRectMake(0, self.frame.size.height-30, self.frame.size.width, 30);
    _leftLabel.frame = _centerLabel.frame = _rightLabel.frame = frame;
    _leftLabel.textAlignment = _centerLabel.textAlignment = _rightLabel.textAlignment = NSTextAlignmentLeft;
    UIFont *font = [UIFont fontWithName:nil size:13];
    UIColor * textColor = [UIColor whiteColor];
    _leftLabel.font = _centerLabel.font = _rightLabel.font = font;
    _leftLabel.textColor = _centerLabel.textColor = _rightLabel.textColor = textColor;
    _leftLabel.numberOfLines = _centerLabel.numberOfLines = _rightLabel.numberOfLines = 0;
    _leftLabel.text = _titleArray[0];
    _centerLabel.text = _titleArray[1];
    _rightLabel.text = _titleArray[2];
    [_leftImageView addSubview:_leftLabel];
    [_centerImageView addSubview:_centerLabel];
    [_rightImageView addSubview:_rightLabel];
}
-(void)startTimer{
    if (_imageArray.count <= 1) {
        return;
    }
    [self stopTimer];
    _timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}
-(void)stopTimer{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}
-(void)nextPage{
    if (_scrollView.contentOffset.x != 0) {
        [_scrollView setContentOffset:CGPointMake(self.frame.size.width*2, 0) animated:YES];
    }
}
-(void)updateContent{
    if (_scrollView.contentOffset.x > self.frame.size.width) {
        _leftImageView.tag = _centerImageView.tag;
        _centerImageView.tag = _rightImageView.tag;
        _rightImageView.tag = (_rightImageView.tag + 1)%_imageArray.count;
    }else if(_scrollView.contentOffset.x <self.frame.size.width){
        _rightImageView.tag = _centerImageView.tag;
        _centerImageView.tag = _leftImageView.tag;
        if (_leftImageView.tag == 0) {
            _leftImageView.tag = _imageArray.count-1;
        }else{
            _leftImageView.tag = (_leftImageView.tag -1)%_imageArray.count;
        }
    }
    _leftImageView.image = [_imageArray objectAtIndex:_leftImageView.tag];
    _centerImageView.image = [_imageArray objectAtIndex:_centerImageView.tag];
    _rightImageView.image = [_imageArray objectAtIndex:_rightImageView.tag];
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    _pageController.currentPage = _centerImageView.tag;
}
#pragma mark - scroll
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self updateContent];
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self updateContent];
}

@end
