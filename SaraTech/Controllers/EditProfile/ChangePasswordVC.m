//
//  ChangePasswordVC.m
//  SaraTech
//
//  Created by iCoreTechnologies on 25/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import "ChangePasswordVC.h"
#import "UITextField+Validations.h"
#import <AFNetworking.h>
#import <JTProgressHUD.h>
#import "AppDelegate.h"
#import "Contants.h"

@interface ChangePasswordVC ()

@end

@implementation ChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [tfOldPassword setPlaceHolder:@"Old Password" color:TXT_FLD_PLACEHOLDER_COLOR];
    [tfNewPassword setPlaceHolder:@"New Password" color:TXT_FLD_PLACEHOLDER_COLOR];
    [tfConfirmPassword setPlaceHolder:@"Confirm Password" color:TXT_FLD_PLACEHOLDER_COLOR];
    
    [tfOldPassword setBorderColor:TXT_FLD_BORDERCOLOR.CGColor];
    [tfNewPassword setBorderColor:TXT_FLD_BORDERCOLOR.CGColor];
    [tfConfirmPassword setBorderColor:TXT_FLD_BORDERCOLOR.CGColor];
    
    btnUpdate.layer.cornerRadius = 15.0f;
    btnUpdate.layer.masksToBounds = TRUE;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)updateButtonAction:(id)sender{
 
    if (tfOldPassword.text.length <= 0 ) {
        
        [self showInfoAlert:@"" message:@"Please enter old password" buttonTitle:@"Ok"];
        return;
    }
    else if (tfNewPassword.text.length <= 0) {
        
        [self showInfoAlert:@"" message:@"Please enter new password" buttonTitle:@"Ok"];
        return;
    }
    else if (tfConfirmPassword.text.length <= 0) {
        
        [self showInfoAlert:@"" message:@"New password and confirm password do not match." buttonTitle:@"Ok"];
        return;
    }
    
    if ([AppDelegate sharedAppDelegate].internetReachablility) {
        //send request
        
        [JTProgressHUD show];
        
        NSString* strOldPass = tfOldPassword.text;
        NSString* strNewPass =  tfNewPassword.text;
        NSString* strEmail =  [[AppDelegate sharedAppDelegate].userData userEmail];//Email id at login
        
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSString* urlString = [NSString stringWithFormat:@"%@%@",BASE_URL,UPDATE_PASSWORD_API];
        NSDictionary *parameters = @{@"email": strEmail, @"oldpassword": strOldPass, @"newpassword":strNewPass};
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:parameters error:nil];
        
        
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
                [self showInfoAlert:@"ERROR" message:[error debugDescription] buttonTitle:@"Ok"];
                return ;
            } else {
                NSLog(@"response =%@,  responseObject=%@", response, responseObject);
                NSDictionary* responsedict  = [responseObject objectAtIndex:0];
                NSNumber * result = [responsedict valueForKey:@"result"];
                if (result.integerValue == 0) {
                    //Email already registered
                    [self showInfoAlert:@"" message:@"Incorrect old password" buttonTitle:@"Ok"];
                }else if(result.integerValue == 1){
                    //Email registered successfully
                    [self showInfoAlert:@"" message:@"Password updated successfully" buttonTitle:@"Ok" completionHander:^{
                        [self.navigationController popViewControllerAnimated:TRUE];
                    }];
                }
            }
            
            [JTProgressHUD hide];
        }];
        [dataTask resume];
        
    }else{
        //show alert
        [self showInfoAlert:@"Connection Error" message:CONNECTION_ERROR_MSG buttonTitle:@"Ok"];
    }


    
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
