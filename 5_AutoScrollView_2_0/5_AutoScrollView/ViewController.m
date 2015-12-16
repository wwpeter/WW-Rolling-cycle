//
//  ViewController.m
//  5_AutoScrollView
//
//  Created by liuweizhen on 15/9/6.
//  Copyright (c) 2015年 勇敢的心. All rights reserved.
//

#import "ViewController.h"
#import "ZZScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ZZScrollView *scrollView = [[ZZScrollView alloc] initWithFrame:CGRectMake(0, 0, 300, 500)];
    scrollView.center = self.view.center;
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSInteger i = 1; i <= 6; i++) {
        [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.png", i]]];
    }
    scrollView.imageArray = imageArray;
    [self.view addSubview:scrollView];
}

@end
