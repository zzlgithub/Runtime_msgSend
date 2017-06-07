//
//  ThirdViewController.m
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/3.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import "ThirdViewController.h"
#import <objc/message.h>
#import "FirstViewController.h"

@interface ThirdViewController ()
@property (nonatomic,strong)FirstViewController * thirdVc;

@end

@implementation ThirdViewController

- (FirstViewController *)thirdVc{
    if (nil == _thirdVc) {
        _thirdVc = [[FirstViewController alloc] init];
    }
    return _thirdVc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 20)];
    lable.text = @"观看打印日志";
    [self.view addSubview:lable];
    
    /**
     *  发送消息
     */
    objc_msgSend(self,@selector(messageForwordTo));
    // Do any additional setup after loading the view.
}


#pragma mark   -----  runtime消息转发 -------



/**
 * 1. 对象在接收到未知的消息时，首先会调用所属类的类方法+resolveInstanceMethod:(实例方法)或者+resolveClassMethod:(类方法),在这个方法中，我们有机会为该未知消息新增一个”处理方法”“。不过使用该方法的前提是我们已经实现了该”处理方法”，只需要在运行时通过class_addMethod函数动态添加到类里面就可以了
 */

void funcForMethod(id self, SEL _cmd)
{
    NSLog(@"动态添加方法");
}


+ (BOOL)resolveInstanceMethod:(SEL)sel{

    /*
     此时如果还未处理  既没有动态添加方法  则会调用
     - (id)forwardingTargetForSelector:(SEL)aSelector
     仍然有机会转发消息
     
     */
    
//    NSString * selectorString = NSStringFromSelector(sel);
//    if ([selectorString isEqualToString:@"messageForwordTo"])
//    {
//        BOOL result = class_addMethod(self,sel,(IMP)funcForMethod,"v@:");
//        if (result) {
//            NSLog(@"动态添加方法成功");
//        }
//        return YES;
//    }
    return [super resolveInstanceMethod:sel];
}

#pragma mark   ----------------不处理第 1 步 动态添加方法 会执行 2.重定向-----------

/**
 * 2. 重定向 消息转发机制执行前，Runtime 系统允许我们替换消息的接收者为其他对象
 
 动态方法解析无法处理消息，则会走备用接受者。这个备用接受者只能是一个新的对象，不能是self本身，否则就会出现无限循环。如果我们没有指定相应的对象来处理aSelector，则应该调用父类的实现来返回结果。
 */

- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSString * selectorString = NSStringFromSelector(aSelector);
    // 将消息交给要转发的对象来处理
    if ([selectorString isEqualToString:@"messageForwordTo"]) {
        
        NSLog(@"没有处理1.动态添加方法  执行第二步 消息重定向转发机制");
        //此时在SecViewController会调用 messageForwordTo 方法  相当于  ViewController类继承了  SecViewController 这类
        return _thirdVc;
    }
    
    
    return [super forwardingTargetForSelector:aSelector];
}




#pragma mark   ----------------处理第 2 步 后不会执行第3步 的消息转发


/**
 *  3.转发
 
 当动态方法解析不做处理返回 NO 时，则会触发消息转发机制。这时 forwardInvocation: 方法会被执行，我们可以重写这个方法来自定义我们的转发逻辑：
 如果动态方法解析和重定向 都没有处理这个消息，那么就会走完整消息转发：
 */



//methodSignatureForSelector用来生成方法签名，这个签名就是给forwardInvocation中的参数NSInvocation调用的
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    
    NSString * selectorString = NSStringFromSelector(aSelector);
    //判断要转发的方法
    if ([selectorString isEqualToString:@"messageForwordTo"]) {
        
        //为转发的方法手动生成签名
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}


- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL selector = [anInvocation selector];
    // self.secVC需要转发消息的对象
    if ([self.thirdVc respondsToSelector:selector]) {
        
        //唤醒这个方法
        [anInvocation invokeWithTarget:self.thirdVc];
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
