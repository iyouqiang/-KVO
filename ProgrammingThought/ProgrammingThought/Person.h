//
//  Person.h
//  编程思想
//
//  Created by Yochi·Kung on 2017/8/5.
//  Copyright © 2017年 Yochi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "addCalculator.h"

@interface Person : NSObject
{
    @public
    NSString *_name;
}

@property (nonatomic, assign) NSInteger result;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *age;

// 普通写法
- (void)eat;
- (void)sleep;

// 链式写法
- (Person *)eat1;
- (Person *)sleep1;

// block作为返回值
- (void (^)())eat2;
- (void(^)())sleep2;

//链式编程 带参数
- (Person *(^)(NSString *food))eat3;
- (Person *(^)(NSString *where))sleep3;

// 函数编程 返回对象，是为了方便获取所有属性
- (Person *)calculator:(NSInteger(^)(NSInteger result))block;

// 函数链式编程
- (Person *)makecalculator:(void (^)(addCalculator *addcalculator))block;

@end
