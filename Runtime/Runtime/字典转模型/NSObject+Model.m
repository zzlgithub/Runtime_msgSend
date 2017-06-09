//
//  NSObject+Model.m
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/9.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/runtime.h>


const char * propertyListKey = "propertyListKey";

@implementation NSObject (Model)

- (NSArray *)get_objcProperties{
     NSArray * ptList = objc_getAssociatedObject(self, propertyListKey);
    if (ptList) {
        return ptList;
    }
    
    NSMutableArray * temAr = [NSMutableArray array];
    unsigned int count = 0;
    objc_property_t * propertyList = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t proterty = propertyList[i];
        const char * propertyName_C = property_getName(proterty);
        
        //转为OC串
        NSString * propertyName_OC = [NSString stringWithCString:propertyName_C encoding:NSUTF8StringEncoding];
        [temAr addObject:propertyName_OC];
    }
    
    objc_setAssociatedObject(self, propertyListKey, temAr.copy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    free(propertyList);
    return temAr.copy;
}


+ (instancetype)modelWithDict:(NSDictionary *)dict{
    id objc = [[self alloc] init];
    NSArray *propertyList = [self  get_objcProperties];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([propertyList containsObject:key]) {
            [objc setValue:obj forKey:key];
        }
    }];
    return objc;
}
@end
