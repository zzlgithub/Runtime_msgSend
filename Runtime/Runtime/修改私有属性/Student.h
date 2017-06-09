//
//  Student.h
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/9.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (nonatomic,copy)NSString * studentName;
//公有方法  学生共同学习
- (void)study;
@end
