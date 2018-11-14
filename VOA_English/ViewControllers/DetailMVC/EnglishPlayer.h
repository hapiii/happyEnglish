//
//  EnglishPlayer.h
//  VOA_English
//
//  Created by 王强 on 17/3/14.
//  Copyright © 2017年 王强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCAudioPlayer.h"
@interface EnglishPlayer : UIView

@property (nonatomic,copy)NSString *musicURL;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (nonatomic,strong) CCAudioPlayer *audioPlayer;//播放
@end
