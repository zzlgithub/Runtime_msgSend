//
//  NSURL+Swizzling.m
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/9.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import "NSURL+Swizzling.h"
#import <objc/runtime.h>


@implementation NSURL (Swizzling)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class selfClass = object_getClass([self class]);
        
        SEL origSEL = @selector(URLWithString:);
        Method origMethod = class_getInstanceMethod(selfClass, origSEL);
        
        SEL customSEL = @selector(my_URLWithString:);
        Method customMethod = class_getInstanceMethod(selfClass, customSEL);
        BOOL addMethodSuccess = class_addMethod(selfClass, origSEL, method_getImplementation(customMethod), method_getTypeEncoding(customMethod));
        if (addMethodSuccess) {
            class_replaceMethod(selfClass, customSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
        }else{
            method_exchangeImplementations(origMethod, customMethod);
        }
        
    });
}


//这里面可以对 url 的合法性 做自己的判断处理
+ (NSURL *)my_URLWithString:(NSString *)URLString{
    if (URLString.length < 1 | URLString == nil) {
        NSLog(@"URL 不合法或者为空");
        return nil;
    }
    NSLog(@"交换了方法");
    NSString * url =URLString;
    return [self my_URLWithString:url];
}
@end
