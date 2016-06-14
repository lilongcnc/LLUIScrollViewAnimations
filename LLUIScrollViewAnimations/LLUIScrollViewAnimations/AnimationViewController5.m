//
//  AnimationViewController5.m
//  LLUIScrollViewAnimations
//
//  Created by 李龙 on 16/6/14.
//  Copyright © 2016年 lauren. All rights reserved.
//

#import "AnimationViewController5.h"
#import "UIView+SetRect.m"
#import "LxDBAnything.h"

@interface AnimationViewController5 ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) NSArray       *picturesArray;

@end

@implementation AnimationViewController5


-(void)viewDidLoad{
    [super viewDidLoad];
 
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
        
        LxDBAnyVar(width);
        // Setup pictures.
        UIImageView *imageView        = [[UIImageView alloc] initWithFrame:CGRectMake(i * width, 0, 320, self.view.height)];
        imageView.image               = _picturesArray[i];
        imageView.contentMode         = UIViewContentModeScaleAspectFill;//UIViewContentModeScaleAspectFill
        imageView.layer.masksToBounds = YES; //必须配合上边那个使用
//        imageView.tag                 = kPictureTag + i;
        [_scrollView addSubview:imageView];

    }
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_scrollView setContentOffset:CGPointMake(0, 100) animated:YES];
        
        
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5f
                         animations:^{
                             [_scrollView setContentOffset:CGPointMake(0, 200)];
                         }];
    });
    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    LxDBAnyVar(scrollView.contentOffset.x);
}




@end
