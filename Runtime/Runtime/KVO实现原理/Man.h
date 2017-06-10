//
//  Man.h
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/10.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Man : NSObject
@property (nonatomic,copy,nullable)NSString * name;
@end

#pragma mark      ----- 模仿下KVO的实现  ----

/**
 *  KVO底层动态生成 Man 的子类 NSKVONotifying_Man
 */
@interface NSKVONotifying_Man : Man

@end

@interface NSObject (Man)
- (void)zzl_addObserver:(nonnull NSObject *)observer forKeyPath:(nonnull NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;
@end
