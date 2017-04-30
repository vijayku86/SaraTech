//
//  AppDelegate.m
//  SaraTech
//
//  Created by iCoreTechnologies on 16/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworking.h>
#import "ViewController.h"
#import <JTProgressHUD.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

+(AppDelegate*)sharedAppDelegate{
    return ((AppDelegate*) [UIApplication sharedApplication].delegate);
}

-(void)logoutApplication:(void(^)(void))CompletionHandler{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"User"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.userData = nil;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"UINavigationControl"];
    self.window.rootViewController = navigationController;
}

-(void)sideMenuWithDashboard{
    [JTProgressHUD show];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MFSideMenuContainerViewController *container = [storyboard instantiateViewControllerWithIdentifier:@"MFSideMenuContainerViewController"];
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"navigationController"];
    UIViewController *leftSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"SideMenuViewController"];
    
    [container setLeftMenuViewController:leftSideMenuViewController];
    [container setCenterViewController:navigationController];
    
    self.window.rootViewController = container;
    [JTProgressHUD hide];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        self.internetReachablility = true;
        if ([AFStringFromNetworkReachabilityStatus(status) caseInsensitiveCompare:@"Not Reachable"] == NSOrderedSame) {
            NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
            self.internetReachablility = false;
        }
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary* dict = [defaults objectForKey:@"User"];
    if (dict != nil) {
        self.userData = dict;
        NSLog(@"Dict= %@",[AppDelegate sharedAppDelegate].userData);
        
        [self sideMenuWithDashboard];
    }
    
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
