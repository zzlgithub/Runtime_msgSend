//
//  ViewController.m
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/3.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import "ViewController.h"
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];

}


/**
 *
 SecondViewController/ThirdViewController/FourViewController 三个类都能调用该类的方法  相当于这三个类都继承于ViewController类  类似C++中的多继承
 */

- (void)messageForwordTo{
    NSLog(@"通过其他类消息的转发调用  相当于实现了多继承");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
