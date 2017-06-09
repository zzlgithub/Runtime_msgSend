//
//  RootViewController.m
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/7.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray * dataSource;
@end

static NSString * const identifier = @"TableViewCell";

@implementation RootViewController

- (NSArray *)dataSource{
    if (nil == _dataSource) {
        _dataSource = [NSArray arrayWithObjects:
                       @"消息转发",
                       @"动态添加属性",
                       @"方法交换",
                       @"字典转模型",
                       @"获取私有属性和方法",
                       @"修改私有属性",
                       @"归档/解档",nil];
    }
    return _dataSource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 50;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
}

#pragma mark    ------  UITableViewDataSource -------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark    ------  UITableViewDelegate ----
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray * viewControllers = @[@"FirstViewController",@"OneViewController",@"SwizzlingViewController",@"DicMoldelViewController",@"MethodAndPropertyViewController",@"ModifyPrivatePropertyController",@"SerializationController"];
    [self.navigationController pushViewController:[NSClassFromString(viewControllers[indexPath.row]) new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }


@end
