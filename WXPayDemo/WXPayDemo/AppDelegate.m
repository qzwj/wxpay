//
//  AppDelegate.m
//  WXPayDemo
//
//  Created by wjl on 2017/8/14.
//  Copyright © 2017年 wjl. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [WXApi registerApp:@"我是微信开放平台中应用的APPID"];
    return YES;
}
    
//微信SDK自带的方法，处理从微信客户端完成操作后返回程序之后的回调方法,显示支付结果的
- (void) onResp:(BaseResp*)resp
    {
        //启动微信支付的response
        NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        if([resp isKindOfClass:[PayResp class]]){
            //支付返回结果，实际支付结果需要去微信服务器端查询
            switch (resp.errCode) {
                case 0:
                payResoult = @"支付结果：成功！";
                break;
                case -1:
                payResoult = @"支付结果：失败！";
                break;
                case -2:
                payResoult = @"用户已经退出支付！";
                break;
                default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
            }
            //        [[NSNotificationCenter defaultCenter] postNotificationName:@"wxResult" object:@(resp.errCode)];
        }
        NSLog(@"result === %@", payResoult);
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
