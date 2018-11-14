//
//  EnglishPlayer.m
//  VOA_English
//
//  Created by 王强 on 17/3/14.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "EnglishPlayer.h"



@implementation EnglishPlayer



- (IBAction)but:(UIButton *)sender {
    if (!_musicURL) {
        
       
        [SVProgressHUD showInfoWithStatus:@"这个页面没有网址哦"];
        //提示加载还没完成
        return;
    }
    if (_musicURL.length>1000) {
       [SVProgressHUD showInfoWithStatus:@"网址无效"];
        //提示加载还没完成
        return;
    }
    
    sender.selected = !sender.selected;
    
    if (_audioPlayer) {
        if (_audioPlayer.isPlaying) {
           
            [_audioPlayer pause];
            
        }else{//继续bo fang

            [_audioPlayer seekToTime:_audioPlayer.progress];
            [_audioPlayer play];
            
        }
    }else{
        NSLog(@"音频地址:%@",_musicURL);
        _audioPlayer = [CCAudioPlayer audioPlayerWithContentsOfURL:[NSURL URLWithString:_musicURL]];
        _timeLabel.text = @"Loading..";
        
        
        [_audioPlayer trackPlayerProgress:^(NSTimeInterval progress) {
            
           
            _slider.value = progress/_audioPlayer.duration;
            _timeLabel.text= [self getTheTextLabelTextFrom:progress AndDurion:_audioPlayer.duration];
            
        } playerState:^(CCAudioPlayerState playerState) {

            NSLog(@"播放状态%ld\n",(long)playerState);
            
            
        }];
        
        [_audioPlayer play];

    }

    
    
       //[_audioPlayer seekToTime:1.0f];
    //self.timeLabel.text = [NSString stringWithFormat:@"%f",_audioPlayer.duration];
    
}
- (NSString *)getTheTextLabelTextFrom:(NSTimeInterval )progress AndDurion:(NSTimeInterval )duration{
    NSString *str = [NSString stringWithFormat:@"%@/%@",[self timeFormatted:progress],[self timeFormatted:duration]];
    
    return str;
    
}
- (NSString *)timeFormatted:(NSTimeInterval)totalSeconds
{
    int time = (int)totalSeconds;
    int seconds = time%60;
    int minutes = (time / 60) % 60;
    int hours = time / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
    
}
- (IBAction)sender:(UISlider *)sender {
    //跳到相应的播放时间
    
    [_audioPlayer seekToTime:sender.value/sender.maximumValue*_audioPlayer.duration];
    

}


@end
