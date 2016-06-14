//
//  AnimationViewController3.m
//  LLUIScrollViewAnimations
//
//  Created by 李龙 on 16/6/12.
//  Copyright © 2016年 lauren. All rights reserved.
//

#import "AnimationViewController3.h"
#import "UIImage+ImageEffects.h"
#import "Math.h"
#import "UIView+SetRect.m"
#import "MoreInfoView.h"

static int viewTag = 0x11;

@interface AnimationViewController3 ()<UIScrollViewDelegate>

@property (nonatomic, strong) Math          *onceLinearEquation;
@property (nonatomic, strong) NSArray       *picturesArray;
@property (nonatomic, strong) UIScrollView  *scrollView;

@end


@implementation AnimationViewController3

-(void)viewDidLoad{
    [super viewDidLoad];
    
    MATHPoint pointA = MATHPointMake(0, -50);
    MATHPoint pointB = MATHPointMake(self.view.width, self.view.width - 50);
    
    self.onceLinearEquation = [Math mathOnceLinearEquationWithPointA:pointA PointB:pointB];
    
    
    // Init pictures data.
    self.picturesArray = @[[UIImage imageNamed:@"beauty"],
                           [[UIImage imageNamed:@"beauty"] blurImage],
                           [[UIImage imageNamed:@"beauty"] blurImageWithMask:[UIImage imageNamed:@"1"]],
                           [[UIImage imageNamed:@"beauty"] blurImageWithRadius:50],
                           [[UIImage imageNamed:@"beauty"] blurImageAtFrame:CGRectMake(0, 64, 100, 100)],
                           [[UIImage imageNamed:@"beauty"] scaleWithFixedWidth:50],
                           [[UIImage imageNamed:@"beauty"] scaleWithFixedHeight:50],
                           [[UIImage imageNamed:@"beauty"] croppedImageAtFrame:CGRectMake(0, 64, 100, 100)],
                           [[UIImage imageNamed:@"beauty"] grayScale]];
    
    // Init scrollView.
    CGFloat height = self.view.height;
    CGFloat width  = self.view.width;
    
    [self.scrollView removeFromSuperview];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -StatusBarAndNavigationBarHeight, width, height+StatusBarAndNavigationBarHeight)];
    self.scrollView.delegate                       = self;
    self.scrollView.pagingEnabled                  = YES;
    self.scrollView.backgroundColor                = [UIColor blackColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces                        = NO;
    self.scrollView.contentSize                    = CGSizeMake(self.picturesArray.count * width, height);
    [self.view addSubview:self.scrollView];
    
    // Init moreInfoViews.
    for (int i = 0; i < self.picturesArray.count; i++) {
        
        MoreInfoView *show     = [[MoreInfoView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
        show.imageView.image   = self.picturesArray[i];
        show.layer.borderWidth = 0.25f;
        show.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f].CGColor;
        show.tag               = viewTag + i;
        
        [self.scrollView addSubview:show];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat X = scrollView.contentOffset.x;
    for (int i = 0; i < self.picturesArray.count; i++) {
        
        MoreInfoView *show = [scrollView viewWithTag:viewTag + i];
        //_onceLinearEquation.k = 1
        show.imageView.x   = _onceLinearEquation.k * (X - i * self.view.width) + _onceLinearEquation.b;
    }
}



@end
