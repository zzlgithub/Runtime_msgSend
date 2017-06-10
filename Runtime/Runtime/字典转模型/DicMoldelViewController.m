//
//  DicMoldelViewController.m
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/9.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import "DicMoldelViewController.h"
#import "Person.h"


@interface DicMoldelViewController ()

@end

@implementation DicMoldelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"字典转模型";
    NSDictionary *dic = @{@"name":@"张三",
                          @"sex":@"男",
                          @"age":@25,
                          @"hobby":@"女"
                          };
    Person * person = [Person modelWithDict:dic];
    NSLog(@"name:%@  sex:%@ age:%@ hobby:%@ ",person.name,person.sex,person.age,person.hobby);
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
