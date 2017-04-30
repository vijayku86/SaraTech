//
//  DetailsViewController.h
//  SaraTech
//
//  Created by iCoreTechnologies on 22/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import "ViewController.h"
#import "BaseViewController.h"
@interface DetailsViewController : BaseViewController<UIWebViewDelegate>

@property(nonatomic, strong) IBOutlet UIWebView* webViewDetail;
@property(nonatomic, strong) NSString* linkName;
@property(nonatomic, strong) NSString* linkUrl;

@end
