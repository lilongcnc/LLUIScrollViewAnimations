//
//  ViewController.m
//  LLUIScrollViewAnimations
//
//  Created by 李龙 on 16/6/4.
//  Copyright © 2016年 lauren. All rights reserved.
//

/**
 *  AnimationViewController1-AnimationViewController3:原作者地址:https://github.com/YouXianMing/Animations
 *
 */
#import "ViewController.h"
#import "AnimationViewController1.h"
#import "AnimationViewController2.h"
#import "AnimationViewController3.h"
#import "AnimationViewController4.h"

@interface ViewController (){
    NSArray *_titleArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleArray = @[@"UIScrollVIew视觉差效果动画",
                    @"UIScrollView视觉差效果动画2",
                    @"UIScrollView视差迷糊效果动画",
                    @"UIScrollView-UIImageView切换动画"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:flag];
    self.tableView.tableFooterView = [UIView new];
}



#pragma mark UITableViewDataSource
static NSString *flag = @"cell";
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flag forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Thin" size:13];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 取消选中状态
    NSLog(@"%zd",indexPath.row);
    
    switch (indexPath.row) {
        case 0:
        {
            
            AnimationViewController1 *animationVC1 = [[AnimationViewController1 alloc] init];
            [self.navigationController pushViewController:animationVC1 animated:YES];
            break;
        }
        case 1:
        {
            
            
            AnimationViewController2 *animationVC2 = [[AnimationViewController2 alloc] init];
            [self.navigationController pushViewController:animationVC2 animated:YES];
            break;
        }
        case 2:
        {
         
            AnimationViewController3 *animationVC3 = [[AnimationViewController3 alloc] init];
            [self.navigationController pushViewController:animationVC3 animated:YES];
            break;
        }
        case 3:
        {
            
            AnimationViewController4 *animationVC4 = [[AnimationViewController4 alloc] init];
            [self.navigationController pushViewController:animationVC4 animated:YES];
            break;
        }
            
        default:
            break;
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
