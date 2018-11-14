//
//  ArticalListModel.h
//  VOA_English
//
//  Created by 王强 on 17/3/9.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "BaseModel.h"
//某一类文章列表的模型  3级
@interface ArticalListModel : BaseModel<NSCoding>
ProStr(articalTitle)//文章标题
ProStr(ArticalUrl)//文章地址

@end
