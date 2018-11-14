//
//  RequestTool.m
//  VOA_English
//
//  Created by 王强 on 17/3/6.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "RequestTool.h"

@implementation RequestTool

+ (RequestTool *)shareTool{
    
    
    static RequestTool *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[RequestTool alloc] init];
        }
    });
    return manager;
}


- (BaseModel *)getTheDetailFromTheUrl:(NSString *)ur{
    
    BaseModel *model = [BaseModel new];
    //获取html的NSData数据
    ur = @"http://www.51voa.com/Voa_English_Learning/remarks-president-trump-joint-address-congress-74159.html";
     NSData *htmlData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:ur]];
    //解析html数据
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
    //根据标签来进行过滤
    
    NSArray *mp3Arr = [xpathParser searchWithXPathQuery:@"//a[@id='mp3']"];
    
    NSArray *contentArr = [xpathParser searchWithXPathQuery:@"//div[@id='content']"];
    //相关推荐
    NSArray *RelatedArtArr = [xpathParser searchWithXPathQuery:@"//a[@target='_blank']"];

    //开始整理数据
    for (TFHppleElement *element in mp3Arr) {
      
        if (element.attributes[@"href"]) {
            _mp3Url = element.attributes[@"href"];
        }else{
            _mp3Url = @"http://downdb.51voa.com/201703/remarks-president-trump-joint-address-congress.mp3";
        }
        

    }
    
   
    for (TFHppleElement *element in contentArr) {
        _contentStr = element.content;
    }
    
    
    //相关推荐的处理
    _RelatedArticles = [NSMutableArray new];
    NSDictionary *RetArtDic = [NSDictionary new];
    
    for (TFHppleElement *element in RelatedArtArr) {
        
            if ([element.attributes[@"id"] isEqualToString:@"help"]) {
                //帮助不加
            }else{
                
                RetArtDic = @{@"title":element.text,
                              @"url":element.attributes[@"href"]
                              };
                
                
                 [_RelatedArticles addObject:RetArtDic];
            }
        
    }
    
  
    model.mp3Url= _mp3Url;
    model.contentsStr = _contentStr;
    model.relatedArr= _RelatedArticles;
 
    
  
    
    return model;
    

    
}

@end
