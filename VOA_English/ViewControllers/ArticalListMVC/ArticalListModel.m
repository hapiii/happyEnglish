//
//  ArticalListModel.m
//  VOA_English
//
//  Created by 王强 on 17/3/9.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "ArticalListModel.h"

@implementation ArticalListModel

// 归档方法
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.articalTitle forKey:@"articalTitle"];
    
    [aCoder encodeObject:self.ArticalUrl forKey:@"ArticalUrl"];
}

// 反归档方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self != nil) {
        self.articalTitle = [aDecoder decodeObjectForKey:@"articalTitle"];
        self.ArticalUrl = [aDecoder decodeObjectForKey:@"ArticalUrl"];
    }
    
    return self;
}

@end
