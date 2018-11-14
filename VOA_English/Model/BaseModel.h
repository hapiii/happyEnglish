//
//  BaseModel.h
//  VOA_English
//
//  Created by 王强 on 17/3/6.
//  Copyright © 2017年 王强. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ProStr(str) @property (nonatomic,copy)NSString *str;
#define ProNum(str) @property (nonatomic,copy)NSNumber *num;
#define ProDic(str) @property(nonatomic,strong)NSDictionary *dic;
#define ProArr(arr) @property (nonatomic,strong)NSArray *arr;


@interface BaseModel : NSObject






@end
