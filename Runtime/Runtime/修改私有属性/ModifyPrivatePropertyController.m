//
//  ModifyPrivatePropertyController.m
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/9.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import "ModifyPrivatePropertyController.h"
#import <objc/message.h>
#import "Student.h"

@interface ModifyPrivatePropertyController ()

@property (nonatomic,strong)Student * student;
@end

@implementation ModifyPrivatePropertyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"修改私有属性";
    
    [self modifyPrivateIvar];
    [self getAllMethods];
}

#pragma mark  修改私有变量
- (void)modifyPrivateIvar{
    Student * student = [[Student alloc] init];
    self.student = student;
    NSLog(@"修改私有变量前 %@",[student description]);
    
    unsigned int cout = 0;
    Ivar * ivars = class_copyIvarList([Student class], &cout);
    for (int i = 0;i < cout ; i ++) {
        Ivar ivar = ivars[i];
        const char * ivarName = ivar_getName(ivar);
        const char * ivarType = ivar_getTypeEncoding(ivar);
        NSLog(@"属性: %s 类型: %s",ivarName,ivarType);
    }
    
    //修改私有变量
    Ivar modify_age = ivars[1];
    object_setIvar(student, modify_age,@28);
    NSLog(@"修改私有变量后 : %@",[student description]);
}

#pragma mark   获取所有(私有)方法
- (void)getAllMethods{
    unsigned int count = 0;
    Method * methods = class_copyMethodList([Student class], &count);
    for (int i = 0; i < count; i++) {
        SEL methodsAddress = method_getName(methods[i]);
        NSString *methodName = [NSString stringWithCString:sel_getName(methodsAddress) encoding:NSUTF8StringEncoding];
        
        /**
         *  调用私有方法
         */
        if ([methodName isEqualToString:@"sleep"]) {
            objc_msgSend(self.student,@selector(sleep));
        }
        NSLog(@"方法 : %@",methodName);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
