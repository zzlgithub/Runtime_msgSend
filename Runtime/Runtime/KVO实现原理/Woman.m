//
//  Woman.m
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/10.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import "Woman.h"

@implementation Woman
@synthesize name = _name;
- (instancetype)init{
    self = [super init];
    if (self) {
        _name = @"苍井空";
    }
    return self;
}

@end

