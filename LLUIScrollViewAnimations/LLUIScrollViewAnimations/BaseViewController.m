//
//  BaseViewController.m
//  LLUIScrollViewAnimations
//
//  Created by 李龙 on 16/6/14.
//  Copyright © 2016年 lauren. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UINavigationControllerDelegate>

@end

@implementation BaseViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
}

//隐藏Navigation的背景视图
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //如果是当前控制器，则隐藏背景；如果不是当前控制器，则显示背景
    //_UINavigationBarBackground这个就是Navigation的背景视图
    if (viewController == self) {
        for (UIView *view in [self.navigationController.navigationBar subviews]) {
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
                
                //最好使用隐藏，指不定什么时候你又想让他出现
                view.hidden = YES;
                
                //如果不想让它一直出现，那么可以移除
                //                [view removeFromSuperview];
            }
        }
    } else {
        for (UIView *view in [self.navigationController.navigationBar subviews]) {
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
                view.hidden = NO;
            }
        }
    }
}

@end
