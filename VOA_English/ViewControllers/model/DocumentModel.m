//
//  DocumentModel.m
//  VOA_English
//
//  Created by 王强 on 17/3/9.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "DocumentModel.h"

@implementation DocumentModel

// 归档方法
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.documentTitle forKey:@"documentTitle"];
  
    [aCoder encodeObject:self.documentList forKey:@"documentList"];
}
// 反归档方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self != nil) {
        self.documentTitle = [aDecoder decodeObjectForKey:@"documentTitle"];
        self.documentList = [aDecoder decodeObjectForKey:@"documentList"];
    }
    
    return self;
}


@end
