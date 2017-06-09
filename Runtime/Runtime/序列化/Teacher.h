//
//  Teacher.h
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/9.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Teacher : NSObject<NSCoding>
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * numPhone;
@property (nonatomic, copy) NSString * sex;
@property (nonatomic, copy) NSString * hobby;
@property (nonatomic, copy) NSString * address;
@property (nonatomic, assign)CGFloat  no;
@property (nonatomic, assign)CGFloat weight;
@property (nonatomic, assign)CGFloat height;
@end
