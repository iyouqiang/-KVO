//
//  NSObject+CustomKVO.h
//  编程思想
//
//  Created by Yochi·Kung on 2017/8/6.
//  Copyright © 2017年 Yochi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CustomKVO)

/** 添加观察属性 */
-  (void)yochi_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

/** 属性监听方法 在监听类中使用 */
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object;

@end
