//
//  archiveTool.h
//  VOA_English
//
//  Created by 王强 on 17/3/10.
//  Copyright © 2017年 王强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface archiveTool : NSObject

+ (archiveTool *)shareTool;

- (BOOL)encodeArchiveObject:(DocumentModel *)model withKey:(NSString *)key andPath:(NSString *)path;

//- (NSArray *)getTheArchiveObject:(id)object withKey:(NSString *)key andPath:(NSString *)path;

@end
