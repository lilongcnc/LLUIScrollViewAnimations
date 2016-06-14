//
//  AnimationViewController4.m
//  LLUIScrollViewAnimations
//
//  Created by 李龙 on 16/6/14.
//  Copyright © 2016年 lauren. All rights reserved.
//

#import "AnimationViewController4.h"
#import "UIView+SetRect.h"
#import "ScrollComputingValue.h"
#import "ScrollTitleView.h"
#import "LxDBAnything.h"

@interface AnimationViewController4 ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView         *scrollView;
@property (nonatomic, strong) UIView               *redView;
@property (nonatomic, strong) UIView               *titlesview;

@property (nonatomic, strong) NSMutableArray       *computingValuesArray;
@property (nonatomic, strong) NSArray              *titles;
@property (nonatomic, strong) NSArray              *pictures;

@end


typedef enum : NSUInteger {
    
    kTitleViewTag = 1000,
    kPictureTag   = 2000,
    
} EScrollViewAnimationControllerValue;


@implementation AnimationViewController4

-(void)viewDidLoad{
    [super viewDidLoad];

    self.scrollView                                = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize                    = CGSizeMake(self.view.width * 3, self.view.height);
    self.scrollView.pagingEnabled                  = YES;
    self.scrollView.bounces                        = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate                       = self;
    self.scrollView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.scrollView];

    self.titlesview                        = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, TabbarHeight)];
    self.titlesview.backgroundColor        = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    self.titlesview.userInteractionEnabled = NO;//这个属性很重要:When set to NO, user events—such as touch and keyboard—intended for the view are ignored and removed from the event queue.从事件队列中移除或者忽略掉
    self.titlesview.bottom                 = self.view.height;
    [self.view addSubview:self.titlesview];

    self.redView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width / 3.f, 3.f)];
    self.redView.backgroundColor = [UIColor redColor];
    [self.titlesview addSubview:self.redView];

    self.computingValuesArray = [NSMutableArray array];
    self.titles               = @[@"Google", @"DeepMind", @"AlphaGo"];
    self.pictures             = @[@"1", @"2", @"3"];
    for (int i = 0; i < self.titles.count; i++) {
        
        // Setup pictures.
        UIImageView *imageView        = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        imageView.image               = [UIImage imageNamed:_pictures[i]];
        imageView.contentMode         = UIViewContentModeScaleAspectFill;
        imageView.tag                 = kPictureTag + i;
        imageView.layer.masksToBounds = YES;
        [self.view addSubview:imageView];
        
        // Setup TitleViews.
        ScrollTitleView *titleView = [[ScrollTitleView alloc] initWithFrame:CGRectMake(i * Width / 3.f, 0, Width / 3.f, self.titlesview.height)];
        titleView.title            = self.titles[i];
        titleView.tag              = kTitleViewTag + i;
        [titleView buildSubViews];
        [self.titlesview addSubview:titleView];
        
        // Init values.设置选中状态
        if (i == 0) {
            
            titleView.inputValue = 1.f;
            imageView.alpha      = 1.f;
            
        } else {
            
            titleView.inputValue = 0.f;
            imageView.alpha      = 0.f;
        }
        
        // Setup ScrollComputingValues.
        ScrollComputingValue *value = [ScrollComputingValue new];
        value.startValue            = -Width + i * Width;
        value.midValue              = 0      + i * Width;
        value.endValue              = +Width + i * Width;
        [value makeTheSetupEffective];
        [self.computingValuesArray addObject:value];
    }

    [self.view bringSubviewToFront:self.titlesview];


}


//UIImageView并不是放到UIScrollView上,UIScrollView的作用是为了让我们获取到和UIScrollView同样的滑动的效果或者说是获取到scrollView.contentOffset.x.我们这里想,用touchBegin等这些方法也可以做到,但是UIScrollView有一个属性pagingEnabled,这个属性对于我们当前动画要实现的效果,不容小觑.不信,你可以把pagingEnabled=YES,然后稍用力滑动下屏幕试试
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    _redView.x      = offsetX / 3.f;
    for (int i = 0; i < _titles.count; i++) {
        
        ScrollTitleView      *titleView = [_titlesview viewWithTag:kTitleViewTag + i];
        UIImageView          *imageView = [self.view viewWithTag:kPictureTag + i];
        ScrollComputingValue *value     = _computingValuesArray[i];
        
        value.inputValue     = offsetX; //这个就是我们title标题和UIImageView的变化的先线性值,这个值得在[0,1]
        NSLog(@"----------------------- %d -----------------------",i);
        LxDBAnyVar(value.outputValue);
        
        titleView.inputValue = value.outputValue;
        imageView.alpha      = value.outputValue;
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
                view.alpha = 0.3;
                
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
