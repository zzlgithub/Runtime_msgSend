//
//  SerializationController.m
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/9.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import "SerializationController.h"
#import "Teacher.h"


@interface SerializationController ()

@end

@implementation SerializationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"序列化";
    
    NSString * filePath = [self setArchvePath];
    
    Teacher * teacher = [[Teacher alloc] init];
    BOOL result = [NSKeyedArchiver archiveRootObject:teacher toFile:filePath];
    if (result) {
        NSLog(@"归档成功");
    }else{
        NSLog(@"归档失败");
    }
    
    //解归档
    Teacher * teach = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"%@",teach);
}

- (NSString *)setArchvePath{
    NSString *documentPath = ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]);
    NSString * filePath = [documentPath stringByAppendingPathComponent:@"teacher.data"];
    NSLog(@"归档路径 %@",filePath);
    return filePath;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
