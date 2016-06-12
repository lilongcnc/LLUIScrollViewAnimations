//
//  AnimationViewController1.h
//  LLUIScrollViewAnimations
//
//  Created by 李龙 on 16/6/12.
//  Copyright © 2016年 lauren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreInfoView.h"
#import "UIView+SetRect.h"
#import "Math.h"
#import "LxDBAnything.h"

@interface AnimationViewController1 : UIViewController<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray       *picturesArray;
@property (nonatomic, strong) UIScrollView  *scrollView;


@end
