//
//  DashboarDetailVC.h
//  SaraTech
//
//  Created by iCoreTechnologies on 26/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface DashboardDetailVC : BaseViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView* webViewC;
}
@property(nonatomic,strong)NSString* linkName;
@property(nonatomic,strong)NSString* linkURL;
@end
