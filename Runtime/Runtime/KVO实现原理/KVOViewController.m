//
//  KVOViewController.m
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/10.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import "KVOViewController.h"
#import "CustomKVOViewController.h"
#import <objc/runtime.h>
#import "Woman.h"

@interface KVOViewController ()

@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"KVO实现原理";
}

- (IBAction)systemKVO:(id)sender {
    //观察者被整个周期变化过程
    [self dynamicChangeClassInfo];
}

- (IBAction)myKVO:(id)sender {
    CustomKVOViewController * customeKVOVC = [[CustomKVOViewController alloc] init];
    [self.navigationController pushViewController:customeKVOVC animated:YES];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{

     NSLog(@"观察到名字变化后:   %@",[change objectForKey:@"new"]);
}


#pragma mark  --------  动态分析观察者执行过程 --------

//获取添加观察者前后  类信息的动态变化过程
- (void)dynamicChangeClassInfo{
    Woman * woman = [[Woman alloc] init];

    NSLog(@"添加观察者之前的类%@,添加观察者之前的类信息%@ 添加观察者之前woman的名字:  %@",woman,object_getClass(woman),woman.name);
    
    [woman addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    NSLog(@"添加观察者之后的类%@,添加观察者之后的类信息 %@",woman,object_getClass(woman));

     /**  注意 ：：：
      *   woman->name 直接访问 没走set方法 不会触发观察者
      */
          //woman->name = @"xiao ze ma li ya";
    
    woman.name = @"cang jing kong bian le";
    
    NSLog(@"改变属性后的类%@,改变属性后的类信息%@ ",woman,object_getClass(woman));
    
    [woman removeObserver:self forKeyPath:@"name"];
    NSLog(@"移除观察者后的类%@,移除观察者后的类信息%@",woman,object_getClass(woman));
    
    
    
}
//   根据方法  dynamicChangeClassInfo  获取的日志分析
/**
 2017-06-10 13:59:42.864 Runtime[12926:626441] 添加观察者之前的类<Woman: 0x608000428ee0>,添加观察者之前的类信息Woman
 2017-06-10 13:59:42.866 Runtime[12926:626441] 添加观察者之后的类<Woman: 0x608000428ee0>,添加观察者之后的类信息 NSKVONotifying_Woman
 2017-06-10 13:59:42.866 Runtime[12926:626441] zzz {
 kind = 1;
 new = "cang lao shi shi shi jie de";
 }
 2017-06-10 13:59:42.867 Runtime[12926:626441] 改变属性后的类<Woman: 0x608000428ee0>,改变属性后的类信息NSKVONotifying_Woman
 2017-06-10 13:59:42.867 Runtime[12926:626441] 移除观察者后的类<Woman: 0x608000428ee0>,移除观察者后的类信息Woman
 */



/**
 *  注意看:在给对象添加观察者之前，对象的class、runtime真实class和isa指针都是Woman 对象，这很正常，但是增加观察者之后class还是Woman ,但是isa指针和runtime的getclass暴露了一切，已经变了一个子类NSKVONotifying_Woman ,这里对外隐藏了一切类信息，就连直接打印class都被重写了，还是返回原本的父类，但是内在确确实实被动态改变了，当我们监听的属性改变的时候，其实就是监听到set方法的调用，重写动态创建那个子类的set方法，然后由子类通知观察者，我已经被改变
 */


@end
