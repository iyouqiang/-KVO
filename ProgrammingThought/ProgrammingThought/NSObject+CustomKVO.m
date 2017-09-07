//
//  NSObject+CustomKVO.m
//  编程思想
//
//  Created by Yochi·Kung on 2017/8/6.
//  Copyright © 2017年 Yochi. All rights reserved.
//

#import "NSObject+CustomKVO.h"
#import <objc/message.h>
#import "Person.h"
@implementation NSObject (CustomKVO)

NSString *const observerKey = @"observerKey";
NSString *const keyPath = nil;

SEL setterMethod = nil;

-  (void)yochi_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;
{
    // 下面的代码实现了三个功能
    //1.创建指向当前类的子类
    //2.新的类加入set方法
    //3.新的类替换为当前类
    //4.保存观察者
    
    /** 获取当前调用者类名 */
    NSString *oldClassName = NSStringFromClass([self class]);
    
    /** 自定子类的类名 */
    NSString *subClassName = [NSString stringWithFormat:@"Yochi_%@", oldClassName];
    
    /** UTF8编码 */
    const char *newsubClassNmame = [subClassName UTF8String];
    
    /** 创建一个指向调用者父类的子类 */
    Class mysubClass = objc_allocateClassPair([self class], newsubClassNmame, 0);
    
    /** 子类注册 */
    objc_registerClassPair(mysubClass);
    
    u_int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char  *propertyName = property_getName(properties[i]);
        const char  *attributes = property_getAttributes(properties[i]);
        NSString *str = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSString *attributesStr = [NSString stringWithCString:attributes encoding:NSUTF8StringEncoding];
        NSLog(@"propertyName : %@", str);
        NSLog(@"attributesStr : %@", attributesStr);
    }
    NSLog(@"类名 %@ 属性个数：%u", [self class],count);
    
    /** set方法名 setName:()xxx*/
    setterMethod = NSSelectorFromString([NSString stringWithFormat:@"set%@:", [keyPath capitalizedString]]);
    keyPath = keyPath;
    
    /** 子类重写set方法
     "    V     @   :   @   "  方法的写法，更多的自行查阅
     - (void)setName:(NSString*)name
     */
    class_addMethod(mysubClass, setterMethod, (IMP)setKeyPath, "V@:@");
    
    /** 将子类替换为当前类 */
    object_setClass(self, mysubClass);
    
    /** 子类属性值 */
    u_int countsub = 0;
    class_copyPropertyList([self class], &countsub);
    NSLog(@"新类名 %@ 属性个数：%u", self,countsub);
    
    /** 分类中保存属性的方式 */
    objc_setAssociatedObject(self, (__bridge const void *)(observerKey), observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/** 添加属性观察后，isa指向子类，现在外界调用的set方法，是子类的方法，也就是次方法 */
void setKeyPath(id self, SEL _cmd, NSString *keyPath)
{
    //NSLog(@"keyPath : %@", keyPath);
    
    /** 获取当前类 */
    id class = [self class];
    
    /** 父类和子类再次交互，改为父类类型 */
    object_setClass(self, class_getSuperclass(class));
    
    /** 此处报 Too many argument to function call, expected 0... 错误 */
    
    /**
     解决方法一：
     
     void* (*action)(id,SEL,NSString *) = (void* (*)(id,SEL,NSString *))objc_msgSend;
     
     action(self,sel,self.animationView);
     
     
     解决方法二：
     
     buildSetting -> Enable Strict Checking of objc_mesgSend Calls 设为NO
     */
    
    /** 调用父类set方法 */
    objc_msgSend(self, setterMethod,keyPath);
    
    /** 拿到观察者 */
    id object = objc_getAssociatedObject(self, (__bridge const void *)(observerKey));
    
    /** 通知观察者 */
    /**
     // 消除方法找不到的警告
     #pragma clang diagnostic push
     
     #pragma clang diagnostic ignored"-Wundeclared-selector"
     
     ...
     
     #pragma clang diagnostic pop
     */
#pragma clang diagnostic push
    
#pragma clang diagnostic ignored"-Wundeclared-selector"
    
    objc_msgSend(object, @selector(observeValueForKeyPath:ofObject:),keyPath, self);
    //- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
#pragma clang diagnostic pop
    
    /** 改回子类类型 */
   object_setClass(self, class);
}

@end
