//
//  VideoViewController.h
//  VOA_English
//
//  Created by 王强 on 2017/3/28.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "BaseViewController.h"
#import "ZFPlayer.h"
#import "VideoListTableView.h"
@interface VideoViewController : BaseViewController

@property(nonatomic,copy)NSString *videoTitle;
@property(nonatomic,copy)NSString *videoUrl;
@property (nonatomic,strong)VideoModel *model;

@property (strong, nonatomic)ZFPlayerView *playerView;
@property (strong,nonatomic)VideoListTableView *tb;
/** 离开页面时候是否在播放 */
@property (nonatomic, assign) BOOL isPlaying;


@end
