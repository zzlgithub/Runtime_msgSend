//
//  MethodAndPropertyViewController.m
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/9.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import "MethodAndPropertyViewController.h"
#import <objc/runtime.h>
#import "MethodAndPropertyCell.h"



static NSString * const identifer = @"MethodAndPropertyCell";
@interface MethodAndPropertyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray<NSMutableArray *> * dataSource;

/**
 *  要获取的属性和方法的类
 */
@property (nonatomic,strong)Class className;
@end

@implementation MethodAndPropertyViewController

#pragma mark   ----- ------
- (NSMutableArray<NSMutableArray *> *)dataSource{
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark   ----- life cycle ------
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"获取类的属性和方法";
    self.className = [UIViewController class];
    
    
    [self requestData];
    //    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //需要设置估值高度 只设置 UITableViewAutomaticDimension 没有效果
    self.tableView.estimatedRowHeight = 80;
    [self.tableView registerNib:[UINib nibWithNibName:@"MethodAndPropertyCell" bundle:nil] forCellReuseIdentifier:identifer];
    
}

- (void)requestData{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [self getAllIvar];
        [self getAllMethods];
    });
}

#pragma mark ------获取属性---------
- (void)getAllIvar{
    unsigned int count = 0;
    NSMutableArray * tempArrs = [NSMutableArray array];
    Ivar * ivars = class_copyIvarList(self.className, &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        NSString * ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString * ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        NSString * str = [NSString stringWithFormat:@"属性名字:%@   属性类型%@",ivarName,ivarType];
        [tempArrs addObject:str];
    }
    
    [self.dataSource addObject:tempArrs.copy];
}


#pragma mark  -----获取方法---------
- (void)getAllMethods{
    unsigned int count = 0;
    NSMutableArray * tempArrs = [NSMutableArray array];
    
    Method * methods  = class_copyMethodList(self.className, &count);
    for (int i = 0; i < count; i ++) {
        SEL address = method_getName(methods[i]);
        NSString * methodName = [NSString stringWithCString:sel_getName(address) encoding:NSUTF8StringEncoding];
        [tempArrs addObject:methodName];
    }
    [self.dataSource addObject:tempArrs.copy];
    

    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.tableView reloadData];
    });

}


#pragma mark   -------UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MethodAndPropertyCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    cell.textLable.text = self.dataSource[indexPath.section][indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource[section].count;
}

#pragma mark   -------UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UILabel * onelLable = [[UILabel alloc] initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,30)];
        onelLable.text = [NSString stringWithFormat:@"%@所有属性",self.className];;
        onelLable.backgroundColor = [UIColor cyanColor];
        return onelLable;
    }else{
        
        UILabel * twoLable = [[UILabel alloc] initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,30)];
        twoLable.text = [NSString stringWithFormat:@"%@所有方法",self.className];
        twoLable.backgroundColor = [UIColor greenColor];
        return twoLable;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
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
