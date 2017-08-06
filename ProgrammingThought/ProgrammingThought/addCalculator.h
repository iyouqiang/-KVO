//
//  addCalculator.h
//  编程思想
//
//  Created by Yochi·Kung on 2017/8/5.
//  Copyright © 2017年 Yochi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface addCalculator : NSObject

@property (nonatomic, assign) NSInteger sumresult;

- (addCalculator * (^)(NSInteger sumresult))add;

@end
