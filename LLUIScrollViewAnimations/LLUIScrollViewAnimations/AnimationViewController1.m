//
//  AnimationViewController1.m
//  LLUIScrollViewAnimations
//
//  Created by 李龙 on 16/6/12.
//  Copyright © 2016年 lauren. All rights reserved.
//

#import "AnimationViewController1.h"
#import "MoreInfoView.h"
#import "UIView+SetRect.h"
#import "Math.h"

static int type    = 0;
static int viewTag = 0x11;

@interface AnimationViewController1 ()<UINavigationControllerDelegate>

@property (nonatomic, strong) Math          *onceLinearEquation;

@end

@implementation AnimationViewController1


-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    self.navigationController.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    MATHPoint pointA;
    MATHPoint pointB;
    
    // Type.
    if (type % 4 == 0) {
        
        pointA = MATHPointMake(0, -50);
        pointB = MATHPointMake(self.view.width, 270 - 80);
        
    } else if (type % 4 == 1) {
        
        pointA = MATHPointMake(0, -50);
        pointB = MATHPointMake(self.view.width, 270 - 20);
        
    } else if (type % 4 == 2) {
        
        pointA = MATHPointMake(0, -50);
        pointB = MATHPointMake(self.view.width, 270 + 20);
        
    } else if (type % 4 == 3) {
        
        pointA = MATHPointMake(0, -50);
        pointB = MATHPointMake(self.view.width, 270 + 80);
    }
    
    self.onceLinearEquation = [Math mathOnceLinearEquationWithPointA:pointA PointB:pointB];
    
    type++;
    
    // Init pictures data.
    self.picturesArray = @[[UIImage imageNamed:@"1"],
                           [UIImage imageNamed:@"2"],
                           [UIImage imageNamed:@"3"],
                           [UIImage imageNamed:@"4"],
                           [UIImage imageNamed:@"5"]];
    
    // Init scrollView.
    CGFloat height = self.view.height;
    CGFloat width  = self.view.width;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -StatusBarAndNavigationBarHeight, width, height+StatusBarAndNavigationBarHeight)];
    _scrollView.delegate                       = self;
    _scrollView.pagingEnabled                  = YES;
    _scrollView.backgroundColor                = [UIColor blackColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces                        = NO;
    _scrollView.contentSize                    = CGSizeMake(self.picturesArray.count * width, height);
    [self.view addSubview:_scrollView];
    
    // Init moreInfoViews.
    for (int i = 0; i < self.picturesArray.count; i++) {
        
        MoreInfoView *show   = [[MoreInfoView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
        show.imageView.image = self.picturesArray[i];
        show.tag             = viewTag + i;
        
        [_scrollView addSubview:show];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat X = scrollView.contentOffset.x;
    
    for (int i = 0; i < self.picturesArray.count; i++) {
        
        MoreInfoView *show = [scrollView viewWithTag:viewTag + i];
        show.imageView.x   = _onceLinearEquation.k * (X - i * self.view.width) + _onceLinearEquation.b;
    }
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
