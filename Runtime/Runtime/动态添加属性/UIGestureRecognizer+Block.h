//
//  UIGestureRecognizer+Block.h
//  Runtime
//
//  Created by zhangzhenglong on 2017/6/9.
//  Copyright © 2017年 zhangzhenglong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MMGestureBlock)(id gestureRecognizer);
@interface UIGestureRecognizer (Block)
+ (instancetype)gestureRecognizerWithActionBlock:(MMGestureBlock)block;
@end
