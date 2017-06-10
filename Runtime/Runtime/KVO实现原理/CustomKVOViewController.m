//
//  CustomKVOViewController.m
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/10.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import "CustomKVOViewController.h"
#import "Man.h"

@interface CustomKVOViewController ()

@end

@implementation CustomKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义观察者";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 根据分析观察者动态变化过程 自实现 观察者
    [self myKVO_Observer];

}

#pragma mark  -----  自实现观察者 ------
- (void)myKVO_Observer{
    Man * man = [[Man alloc] init];
    NSLog(@"观察之前man的名字:  %@",man.name);
    
    [man zzl_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    man.name = @"guan xi bian le";

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"观察到名字变化后:   %@",[change objectForKey:@"change"]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
