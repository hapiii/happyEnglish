//
//  archiveTool.m
//  VOA_English
//
//  Created by 王强 on 17/3/10.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "archiveTool.h"

@implementation archiveTool

+ (archiveTool *)shareTool{
    
    static archiveTool *manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        if (manager == nil) {
            manager = [[archiveTool alloc] init];
        }
        
    });
    
    return manager;

}




- (BOOL )encodeArchiveObject:(DocumentModel *)model withKey:(NSString *)key andPath:(NSString *)path{
    
//    NSMutableData *data = [[NSMutableData alloc]init];
//    
//    NSKeyedArchiver*archive = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
//     //归档数据
//    [archive encodeObject:arr forKey:key];
//    //结束归档
//    [archive finishEncoding];
//    //将归档数据写入磁盘
    NSString*str = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents%@",path]];
    NSLog(@"%@",str);
    //[data writeToFile:str atomically:YES]; 论两个方法的优劣性
    BOOL isSuccess = [NSKeyedArchiver archiveRootObject:model toFile:str];
    
    return isSuccess;
   

}
//- (NSArray *)getTheArchiveObjectWithKey:(NSString *)key andPath:(NSString *)path{
//    
//    NSString*str = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents%@",path]];
//    
//    //NSData*data = [NSData dataWithContentsOfFile:str];
//    //NSKeyedUnarchiver*unarchive = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
//   // NSArray *arr = [unarchive decodeObjectForKey:key];
//    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:str];
//    return arr;
//
//    
//    
//}





@end
