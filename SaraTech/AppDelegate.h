//
//  AppDelegate.h
//  SaraTech
//
//  Created by iCoreTechnologies on 16/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contants.h"
#import <MFSideMenu.h>
#import "NSMutableDictionary+UserData.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic)   UIWindow *window;
@property (assign, nonatomic)   BOOL internetReachablility;
@property (strong, nonatomic)   NSMutableDictionary* userData;

+ (AppDelegate*) sharedAppDelegate;
- (void) logoutApplication:(void(^)(void)) CompletionHandler;
- (void) sideMenuWithDashboard;
@end

