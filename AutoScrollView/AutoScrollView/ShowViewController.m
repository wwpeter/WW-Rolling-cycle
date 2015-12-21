//
//  ShowViewController.m
//  AutoScrollView
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 朱明科. All rights reserved.
//

#import "ShowViewController.h"

@interface ShowViewController ()

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
}
-(void)initUI{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 100)];
    label.text = self.str;
    label.font = [UIFont systemFontOfSize:30];
    label.textColor = [UIColor redColor ];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 300, self.view.frame.size.width-200, 50);
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
    [btn addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)dismiss:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
