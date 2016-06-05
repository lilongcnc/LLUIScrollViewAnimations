//
//  ViewController.m
//  LLUIScrollViewAnimations
//
//  Created by 李龙 on 16/6/4.
//  Copyright © 2016年 lauren. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:flag];
    self.tableView.tableFooterView = [UIView new];
}



#pragma mark UITableViewDataSource
static NSString *flag = @"cell";
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:flag];
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flag forIndexPath:indexPath];

    cell.textLabel.text = @"哈喽";
    return cell;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
