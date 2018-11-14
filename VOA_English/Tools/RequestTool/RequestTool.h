//
//  RequestTool.h
//  VOA_English
//
//  Created by 王强 on 17/3/6.
//  Copyright © 2017年 王强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFHpple.h"
#import "DocumentModel.h"//目录
#import "ArticalListModel.h"//文章列表
#import "DetailModel.h"//详情
#import "VideoModel.h"
//#import "archiveTool.h"//归档工具
@interface RequestTool : NSObject
//单例创建
+ (RequestTool *)shareTool;

@property (nonatomic,copy)NSString *mp3Url;

@property (nonatomic,copy)NSString *contentStr;
//相关推荐的数组,里面存放dic
//相关推荐的前缀:http://www.51voa.com/Voa_English_Learning/
@property (nonatomic,strong)NSMutableArray *RelatedArticles;

//获取目录
- (NSArray *)getTheDoucmentofTheHome;
//获取列表
- (NSMutableArray *)getTehListofTheUrlType:(NSString *)url;
//
- (DetailModel *)getTheDetailFromTheUrl:(NSString *)ur;
//获取视频的详细信息
- (VideoModel *)getTheVideoDetailFromTheUrl:(NSString *)ur;


@end
