//
//  SwizzlingViewController.m
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/9.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import "SwizzlingViewController.h"


@interface SwizzlingViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation SwizzlingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"方法交换";
    
    NSURL * url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    /**
     *  注意观看log日志  方法已交换
     *
     */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    
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
