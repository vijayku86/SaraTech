//
//  DashboarDetailVC.m
//  SaraTech
//
//  Created by iCoreTechnologies on 26/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import "DashboardDetailVC.h"
#import <JTProgressHUD.h>
#import <MFSideMenu.h>
#import "Contants.h"

@interface DashboardDetailVC ()

@end

@implementation DashboardDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated {
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:FONT_SEMI_BOLD size:20.0]}];
    self.title = self.linkName;
    
    [JTProgressHUD show];
    [webViewC loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.linkURL]]];
    
    webViewC.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Register-bg.png"]];
    
}

-(IBAction)leftBarButtonAction:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        
    }];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [JTProgressHUD hide];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [JTProgressHUD hide];
    [self showInfoAlert:@"Error" message:[error debugDescription] buttonTitle:@"Ok"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
