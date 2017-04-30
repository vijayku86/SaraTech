//
//  BaseViewController.h
//  SaraTech
//
//  Created by iCoreTechnologies on 16/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

-(void)showInfoAlert:(NSString*)title
             message:(NSString*)message
         buttonTitle:(NSString*)btnTitle;

-(void)showInfoAlert:(NSString *)title
             message:(NSString *)message
         buttonTitle:(NSString *)btnTitle
    completionHander:(void(^)(void))completionHandler;
@end
