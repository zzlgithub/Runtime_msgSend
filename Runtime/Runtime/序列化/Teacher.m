//
//  Teacher.m
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/9.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import "Teacher.h"
#import <objc/runtime.h>


@implementation Teacher
- (void)encodeWithCoder:(NSCoder *)encoder {
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        id value = [self valueForKey:nameStr];
        [encoder encodeObject:value forKey:nameStr];
    }
    free(ivars);
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i ++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            id value = [decoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _age = 28;
        _name = @"李四";
        _numPhone = @"188000099999";
        _sex = @"女";
        _hobby = @"男";
        _address = @"中国北京中南海";
        _no = 999.0;
        _weight = 140.0;
        _height = 180.0;
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"age: %ld name: %@ numPhone: %@ sex: %@ hobby: %@ address: %@ no: %lf weight: %lf height: %lf",self.age,self.name,self.numPhone,self.sex,self.hobby,self.address,self.no,self.weight,self.height];
}

@end
