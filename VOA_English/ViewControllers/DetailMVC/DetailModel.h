//
//  DetailModel.h
//  VOA_English
//
//  Created by 王强 on 17/3/9.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "BaseModel.h"

@interface DetailModel : BaseModel

ProStr(mp3Url)//音频地址
ProStr(contentsStr)//内容
ProArr(relatedArr)//相关推荐
ProDic(relatedDic)//

@end
