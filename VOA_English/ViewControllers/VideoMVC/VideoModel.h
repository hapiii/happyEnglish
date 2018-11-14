//
//  VideoModel.h
//  VOA_English
//
//  Created by 王强 on 2017/3/23.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "BaseModel.h"

@interface VideoModel : BaseModel
ProStr(VideoUrl)
ProStr(ImgUrl)
ProStr(VideoDes)
ProArr(relatedArr)//相关推荐ArticalListModel
@end
