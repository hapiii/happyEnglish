//
//  VELeftViewController.h
//  VOA_English
//
//  Created by 王强 on 17/3/7.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger,CurrectPageType) {
    VOAStandardEnglish,//常速英语
    VOASpecialEnglish,//慢速英语
    VOAVideos,//voa视频
    VOAEnglishLearning
};

@interface VELeftViewController : BaseViewController

@property (copy, nonatomic) void(^selectCell)(NSInteger page);

@end
