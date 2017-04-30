//
//  EditViewController.m
//  SaraTech
//
//  Created by iCoreTechnologies on 25/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import "EditViewController.h"
#import "UITextField+Validations.h"
#import "Contants.h"
#import <AFNetworking.h>
#import <JTProgressHUD.h>
#import "AppDelegate.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [tfname setPlaceHolder:@"Your Name" color:TXT_FLD_PLACEHOLDER_COLOR];
    [tfContactNo setPlaceHolder:@"Email ID" color:TXT_FLD_PLACEHOLDER_COLOR];
    
    [tfname setBorderColor:TXT_FLD_BORDERCOLOR.CGColor];
    [tfContactNo setBorderColor:TXT_FLD_BORDERCOLOR.CGColor];
    
    btnSubmit.layer.cornerRadius = 15.0f;
    btnSubmit.layer.masksToBounds = TRUE;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)submitButtonAction:(id)sender {
    
    if (tfname.text.length <= 0 ) {
        
        [self showInfoAlert:@"" message:@"Please enter valid name" buttonTitle:@"Ok"];
        return;
    }
    else if (tfContactNo.text.length <= 0) {
        
        [self showInfoAlert:@"" message:@"Please enter a valid contact no." buttonTitle:@"Ok"];
        return;
    }
    if ([AppDelegate sharedAppDelegate].internetReachablility) {
        //send request
        
        [JTProgressHUD show];
        
        NSString* strName = tfname.text;
        NSString* strContact =  tfContactNo.text;
        NSString* strLoginID =  [[AppDelegate sharedAppDelegate].userData userID]; // Id saved at login
        NSString* strEmail = [[AppDelegate sharedAppDelegate].userData userEmail]; //saved email id
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSString* urlString = [NSString stringWithFormat:@"%@%@",BASE_URL,EDIT_PROFILE_API];
        NSDictionary *parameters = @{@"email": strEmail, @"id": strLoginID, @"name":strName};
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
                    [self showInfoAlert:@"" message:@"Failed to update profile details, Please try later. " buttonTitle:@"Ok"];
                }else if(result.integerValue == 1){
                    //Email registered successfully
                    [self showInfoAlert:@"" message:@"Details updated successfully" buttonTitle:@"Ok" completionHander:^{
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
