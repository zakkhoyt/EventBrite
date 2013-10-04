//
//  VWWAppDelegate.m
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "VWWAppDelegate.h"

@implementation VWWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setSettings];
    [self setupAppearance];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call orVWWS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark Custom methods
-(void)setSettings{
    
    NSString* server = [VWWUserDefaults server];
    if(server == nil || [server isEqualToString:@""] || [server isKindOfClass:[NSNull class]]){
        [VWWUserDefaults setServer:VWW_EVENT_BRITE_SERVER];
    }
    
    NSLog(@"Debug mode enabled: %@", [VWWUserDefaults debugMode] ? @"YES": @"NO");
}


-(void)setupAppearance{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    
//    //    [[UIToolbar appearance] setTintColor:[UIColor whiteColor]];
//    //    [[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:@"back_top_bar.png"] forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
//    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
//        [[UIToolbar appearance] setBarTintColor:[UIColor smileBrownColor]];
//    }
//    
//    NSDictionary *d = @{UITextAttributeTextColor : [UIColor whiteColor]};
//    [[UINavigationBar appearance] setTitleTextAttributes:d];
//    
//    //    [[UINavigationBar appearance] setBackgroundColor:[UIColor smileBrownColor]];
//    //    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"back_top_bar.png"] forBarMetrics:UIBarMetricsDefault];
//    
//    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
//        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//        [[UINavigationBar appearance] setBarTintColor:[UIColor smileBrownColor]];
//    }
//    else{
//        [[UINavigationBar appearance] setTintColor:[UIColor smileBrownColor ]];
//    }
//    
//    
//    [[UITabBar appearance] setTintColor:[UIColor smileBrownColor]];
//    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"bottom_nav_bg.png"]];
//    //    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -20)];
//    //    [[UITabBar appearance] setSelectedImageTintColor:[UIColor smileGreenColor]];
//    //        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
//    //        [[UITabBar appearance] setBarTintColor:[UIColor smileBrownColor]];
//    //    }
//    
//    
//    //    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor smileGreenColor]} forState:UIControlStateSelected];
}

@end
