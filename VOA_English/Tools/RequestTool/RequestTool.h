//
//  RequestTool.h
//  VOA_English
//
//  Created by 王强 on 17/3/6.
//  Copyright © 2017年 王强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFHpple.h"
#import "BaseModel.h"
@interface RequestTool : NSObject
//单例创建
+ (RequestTool *)shareTool;

@property (nonatomic,copy)NSString *mp3Url;

@property (nonatomic,copy)NSString *contentStr;
//相关推荐的数组,里面存放dic 
//相关推荐的前缀:http://www.51voa.com/Voa_English_Learning/
@property (nonatomic,strong)NSMutableArray *RelatedArticles;


- (BaseModel *)getTheDetailFromTheUrl:(NSString *)ur;


@end
