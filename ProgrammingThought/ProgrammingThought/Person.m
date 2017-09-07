//
//  Person.m
//  编程思想
//
//  Created by Yochi·Kung on 2017/8/5.
//  Copyright © 2017年 Yochi. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)eat
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)sleep
{
    NSLog(@"%s", __FUNCTION__);
}

- (Person *)eat1
{
    NSLog(@"%s", __FUNCTION__);
    return self;
}

- (Person *)sleep1
{
    NSLog(@"%s", __FUNCTION__);
    return self;
}

- (void (^)())eat2
{
    return ^{
      
        NSLog(@"%s", __FUNCTION__);
    };
}

- (void(^)())sleep2
{
    return ^{
        
        NSLog(@"%s", __FUNCTION__);
    };
}

- (Person *(^)(NSString *food))eat3
{
    return ^(NSString *food) {
        
        NSLog(@"吃：%@ ",food);
        
        return self;
    };
}

- (Person *(^)(NSString *where))sleep3
{
    return ^(NSString *where) {
        
        NSLog(@"睡在：%@上",where);
        
        return self;
    };
}

- (Person *)calculator:(NSInteger(^)(NSInteger result))block
{
    _result = block(_result);
    
    return self;
}

- (Person *)makecalculator:(void (^)(addCalculator *addcalculator))block
{
    addCalculator *add = [[addCalculator alloc] init];
    if (block) {
        block(add);
    }
    
    self.result = add.sumresult;
    
    return self;
}

- (void)setName:(NSString *)name
{
    NSLog(@"我是原主");
    _name = name;
}

- (void)testabc
{
    NSLog(@"我是谁：%s",__func__);
}

- (void)setAge:(NSString *)age
{
    _age = age;
    NSLog(@"age:%@", _age);
}

@end
