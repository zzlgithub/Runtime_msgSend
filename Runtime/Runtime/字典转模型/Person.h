//
//  Person.h
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/9.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Model.h"

@interface Person : NSObject
@property (copy,nonatomic) NSString * name;
@property (copy,nonatomic) NSString * sex;
@property (copy,nonatomic) NSString * age;
@property (nonatomic,copy)NSString * hobby;
@end
