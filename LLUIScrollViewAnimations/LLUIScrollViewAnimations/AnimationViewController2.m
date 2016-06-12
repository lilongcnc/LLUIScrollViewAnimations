//
//  AnimationViewController2.m
//  LLUIScrollViewAnimations
//
//  Created by 李龙 on 16/6/12.
//  Copyright © 2016年 lauren. All rights reserved.
//

#import "AnimationViewController2.h"

static int viewTag = 0x11;


@implementation AnimationViewController2

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat X = scrollView.contentOffset.x;
    LxDBAnyVar(X);
    for (int i = 0; i < self.picturesArray.count; i++) {
        
        MoreInfoView *show = [scrollView viewWithTag:viewTag + i];
//        show.imageView.x   = (X - i * self.contentView.width)+ _onceLinearEquation.b;
        show.imageView.x   =  (X - i * self.view.width);
    }
}

@end
