//
//  addCalculator.m
//  编程思想
//
//  Created by Yochi·Kung on 2017/8/5.
//  Copyright © 2017年 Yochi. All rights reserved.
//

#import "addCalculator.h"

@implementation addCalculator

- (addCalculator * (^)(NSInteger sumresult))add
{
    return ^(NSInteger sumresult) {
      
        _sumresult += sumresult;
        
        return self;
    };
}

@end
