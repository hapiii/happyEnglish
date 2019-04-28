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

#pragma mark====获取详情
- (DetailModel *)getTheDetailFromTheUrl:(NSString *)ur{
    
    DetailModel *model = [DetailModel new];
    NSData *htmlData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:ur]];
    if (htmlData==nil) {
        [SVProgressHUD showErrorWithStatus:@"抱歉,请求出错"];
    }
    
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
        }
    }
    
    for (TFHppleElement *element in contentArr) {
        _contentStr = element.content;
        //_contentStr = element.raw;//因文字太多label无法显示，改为用WkwebView显示
    }
    
    //相关推荐的处理
    _RelatedArticles = [NSMutableArray new];
    
    for (TFHppleElement *element in RelatedArtArr) {
        if ([element.attributes[@"id"] isEqualToString:@"help"]) {
            //帮助不加
        }else{
            ArticalListModel *model = [[ArticalListModel alloc] init];
            model.articalTitle = element.content;
            model.ArticalUrl = element.attributes[@"href"];
            [_RelatedArticles addObject:model];
        }
    }
    
    
    model.mp3Url= _mp3Url;
    model.contentsStr = _contentStr;
    model.relatedArr= _RelatedArticles;
    return model;
    
}

#pragma mark====获取视频详情
- (VideoModel *)getTheVideoDetailFromTheUrl:(NSString *)ur{
    
    
    VideoModel *model = [VideoModel new];
    
    
    NSData *htmlData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:ur]];
    if (htmlData==nil) {
        [SVProgressHUD showErrorWithStatus:@"抱歉,请求出错"];
    }
    
    //解析html数据
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
    
    
    NSArray *contentArr = [xpathParser searchWithXPathQuery:@"//div[@id='content']"];
    //相关推荐
    NSArray *RelatedArtArr = [xpathParser searchWithXPathQuery:@"//a[@target='_blank']"];
    
    for (TFHppleElement *element in contentArr) {
        //_contentStr = element.content;
        _contentStr = element.raw;//因文字太多label无法显示，改为用WkwebView显示
        //根据标签来进行过滤
        NSArray *desArr = [element searchWithXPathQuery:@"//p"];//用来放描述
        //model.VideoDes = element.text;
        NSArray *imgArr = [element searchWithXPathQuery:@"//video"];//用来放图片
        NSArray *mp4Arr = [element searchWithXPathQuery:@"//video//source"];//用来放地址
        
        TFHppleElement *imgEle;
        if (imgArr[0]) {
            imgEle  = imgArr[0];
            model.ImgUrl = [NSString stringWithFormat:@"http://www.51voa.com/%@",imgEle.attributes[@"poster"]];
        }
        TFHppleElement *mp4Ele;
        if (mp4Arr) {
            mp4Ele = mp4Arr[0];
            model.VideoUrl = mp4Ele.attributes[@"src"];
            
        }
        
        TFHppleElement *desEle;
        if (desArr.count>0) {
            desEle = desArr[0];
            model.VideoDes = desEle.text;
        }else{
            model.VideoDes = @"暂无描述";
        }
        
    }
    //相关推荐的处理
    _RelatedArticles = [NSMutableArray new];
    
    for (TFHppleElement *element in RelatedArtArr) {
        if ([element.attributes[@"id"] isEqualToString:@"help"]) {
            //帮助不加
        }else{
            ArticalListModel *model = [[ArticalListModel alloc] init];
            model.articalTitle = element.content;
            model.ArticalUrl = element.attributes[@"href"];
            [_RelatedArticles addObject:model];
        }
    }
    
    model.relatedArr= _RelatedArticles;
    return model;
    
}

//获取list
- (NSMutableArray *)getTehListofTheUrlType:(NSString *)url{
    
    NSMutableArray *arr = [NSMutableArray new];
    NSData *htmlData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    //解析html数据
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
    //根据标签来进行过滤
    
    NSArray *mp3Arr = [xpathParser searchWithXPathQuery:@"//div[@id='list']"];
    
    for (TFHppleElement *element in mp3Arr) {
        
        NSArray *LiElementsArr = [element searchWithXPathQuery:@"//a[@target='_blank']"];
        
        for (TFHppleElement *tempAElement in LiElementsArr) {
            NSString *suffixStr = [tempAElement objectForKey:@"href"];
            
            NSString *urlStr = [NSString stringWithFormat:@"%@%@",VoaEnglish,suffixStr];
            ArticalListModel *model = [ArticalListModel new];
            model.ArticalUrl = urlStr;
            model.articalTitle = tempAElement.text;
            
            [arr addObject:model];
        }
        
    }
    
    
    return arr;
}

//获取目录
- (NSArray *)getTheDoucmentofTheHome{
    
    NSData *htmlData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:VoaEnglish]];
    //解析html数据
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
    //根据标签来进行过滤
    NSArray *documentArr = [xpathParser searchWithXPathQuery:@"//div[@id='left_nav']"];
    
    
    NSMutableArray *dataArr = [NSMutableArray new];    //最终返回的数组
    NSMutableArray *artical_arr = [NSMutableArray new];//容器
    NSMutableArray *titleArr = [NSMutableArray new];    //存放标题的数组
    NSMutableArray *listTitleArr = [NSMutableArray new];//存放每一组标题的数组
    
    for (TFHppleElement *element in documentArr) {
        
        //标题数组
        NSArray *TitleElementsArr = [element searchWithXPathQuery:@"//div[@class='left_nav_title']//a"];
        //小标题的容器数组
        NSArray *ArticalElementsArr = [element searchWithXPathQuery:@"//ul"];
        
        //移除相关推荐
        //        [ArticalArr removeLastObject];
        //标题 没有友情链接
        for (TFHppleElement *TitleElement in TitleElementsArr) {
            //每一个标题下的数组
            [titleArr addObject:TitleElement.text];
        }
        [titleArr addObject:@"友情链接"];
        
        //该标题下的文章
        for (TFHppleElement *articalElement in ArticalElementsArr){
            
            
            //每一个标题下的数组
            NSArray *ListArr = [articalElement searchWithXPathQuery:@"//li//a"];
            //清空数组
            [listTitleArr removeAllObjects];
            NSArray *arr = [NSArray new];
            
            for (TFHppleElement *listElement in ListArr) {
                
                ArticalListModel *model = [ArticalListModel new];
                model.articalTitle = listElement.text;
                model.ArticalUrl = listElement.attributes[@"href"];
                [listTitleArr addObject:model];
                arr = [NSArray arrayWithArray:listTitleArr];
                
            }
            [artical_arr addObject:arr];
        }
        
        if (titleArr.count==artical_arr.count) {
            
            for (int i = 0; i<titleArr.count; i++) {
                
                if (titleArr.count>=4) {
                    
                    if (i==4) {
                        //VOA节目介绍不添加
                        
                    }else{
                        
                        DocumentModel *model = [DocumentModel new];
                        model.documentTitle = titleArr[i];
                        //这里，模型套模型
                        model.documentList = artical_arr[i];
                        [dataArr addObject:model];
                        
                    }
                }
            }
        }
    }
    
    
    
    return dataArr;
}

@end
