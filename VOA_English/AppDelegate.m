//
//  AppDelegate.m
//  VOA_English
//
//  Created by 王强 on 17/3/6.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "AppDelegate.h"
#import <BmobSDK/Bmob.h>
#import "ViewController.h"
#import "MainWebController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Bmob registerWithAppKey:@"74db75d93c55aab62da3167b46db8979"];
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"GameScore"];
   
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor]; //给window设置一个背景色
   
    [bquery getObjectInBackgroundWithId:@"5e2ef34256" block:^(BmobObject *object,NSError *error){
        if (error){
            //进行错误处理
        }else{
            //表里有id为0c6db13c的数据
            if (object) {
               
                BOOL cheatMode = [[object objectForKey:@"cheatMode"] boolValue];
                if (cheatMode) {
                    self.window.rootViewController = [ViewController new];
                }else{
                    self.window.rootViewController = [MainWebController new];
                }
                [self.window makeKeyAndVisible];
                
            }
        }
        
    }];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
