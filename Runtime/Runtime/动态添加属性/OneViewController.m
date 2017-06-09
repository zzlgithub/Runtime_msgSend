//
//  OneViewController.m
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/9.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import "OneViewController.h"
#import "UIGestureRecognizer+Block.h"

#define K_SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define K_SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"动态添加属性";
    
    
    UIView *viewM = [[UIView alloc]initWithFrame:CGRectMake(100, 100, K_SCREENWIDTH/2,K_SCREENHEIGHT/2)];
    viewM.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:viewM];
    
    [viewM addGestureRecognizer:[UITapGestureRecognizer gestureRecognizerWithActionBlock:^(id gestureRecognizer) {
        NSLog(@"点击我干嘛");
    }]];
    
    
    
    
    UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(viewM.frame) +20, 200, 20)];
    lable.text = @"点击黄色区域";
    [self.view addSubview:lable];


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
