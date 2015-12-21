//
//  AutoScroll.h
//  AutoScrollView
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 朱明科. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoScroll : UIView

@property(nonatomic,copy)NSArray *picUrl;//点击滚动视图跳转页面所学要的连接
@property(nonatomic)UIViewController *viewController;//跳转页

-(id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray;
@end
