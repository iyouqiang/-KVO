//
//  Person+KVO.m
//  编程思想
//
//  Created by Yochi·Kung on 2017/8/6.
//  Copyright © 2017年 Yochi. All rights reserved.
//

#import "Person+KVO.h"

@implementation Person (KVO)

- (void)setName:(NSString *)name
{
    NSLog(@"来到了分类的set方法");
    _name = name;
}

@end
