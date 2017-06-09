//
//  FirstViewController.m
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/7.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"


@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息发送过程";
    // Do any additional setup after loading the view from its nib.
}



/**
 *
 SecondViewController/ThirdViewController/FourViewController 三个类都能调用该类的方法  相当于这三个类都继承于FirstViewController类  类似C++中的多继承
 */

- (void)messageForwordTo{
    NSLog(@"通过其他类消息的转发调用  相当于实现了多继承");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -------  action  ------
- (IBAction)dynamicAddMethod:(id)sender {
    SecondViewController * vc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)messageRedirect:(id)sender {
    ThirdViewController * vc = [[ThirdViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)messageForward:(id)sender {
    FourViewController * vc = [[FourViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}






@end
