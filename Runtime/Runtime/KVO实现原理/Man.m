//
//  Man.m
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/10.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import "Man.h"
#import <objc/runtime.h>


@implementation Man
- (instancetype)init{
    self = [super init];
    if (self) {
        _name = @"冠希";
    }
    return self;
}
@end


@implementation NSKVONotifying_Man
- (Class)class{
    return [Man class];
}


- (void)setName:(NSString *)name{
    //调用父类
    [super setName:name];
    
    // 根据关联字段拿出关联的观察者
    id obj = objc_getAssociatedObject(self, "myObserve");
    
    // 子类最终通知调用观察者的observer方法
    [obj observeValueForKeyPath:@"name" ofObject:self change:@{@"change":name} context:nil];
}
@end

@implementation NSObject (Man)
- (void)zzl_addObserver:(nonnull NSObject *)observer forKeyPath:(nonnull NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context
{
    // 修改调用者的isa指针为动态创建的子类，能让set方法改变的时候，去子类进行操作
    object_setClass(self, [NSKVONotifying_Man class]);

    // 动态给对象关联观察者
    objc_setAssociatedObject(self, "myObserve", observer, OBJC_ASSOCIATION_RETAIN);
}

@end
