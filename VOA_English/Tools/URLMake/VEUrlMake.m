//
//  VEUrlMake.m
//  VOA_English
//
//  Created by 王强 on 17/3/7.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "VEUrlMake.h"

@implementation VEUrlMake

+ (VEUrlMake *)shareTool{
    
    
    static VEUrlMake *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[VEUrlMake alloc] init];
        }
    });
    return manager;
}
@end
