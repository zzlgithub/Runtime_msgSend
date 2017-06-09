//
//  Student.m
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/9.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import "Student.h"


@interface Student ()

//年龄私有 不对外提供操作
@property (nonatomic,assign) NSNumber * age;

//私有方法学生睡觉
- (void)sleep;
@end


@implementation Student

- (instancetype)init{
    self = [super init];
    if (self) {
        _studentName = @"张三";
        _age = @18;
    }
    return self;
}

- (void)study{
    NSLog(@"%ld 岁的 %@正在努力的学习",[self.age integerValue],self.studentName);
}
- (void)sleep{
    NSLog(@"%@ 正在睡觉请勿打扰",self.studentName);
}

- (NSString *)description{
    return [NSString stringWithFormat:@"学生姓名:%@  学生年龄:%ld",self.studentName,[self.age integerValue] ];
}
@end
