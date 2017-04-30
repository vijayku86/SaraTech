//
//  ForgotPassViewController.m
//  SaraTech
//
//  Created by iCoreTechnologies on 16/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import "ForgotPassViewController.h"
#import "AppDelegate.h"
#import "UITextField+Validations.h"
#import "ButtonCell.h"
#import "InputCell.h"
#import <JTProgressHUD.h>
#import "AppDelegate.h"
#import <AFNetworking.h>

@interface ForgotPassViewController ()<UITableViewDelegate,UITableViewDataSource,ButtonDelegate>

@end

@implementation ForgotPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    inputCellIdentifier = @"InputCellIdentifier";
    buttonCellIdentifier = @"ButtonCellIdentifier";
    
    [tblViewResetPass registerNib:[UINib nibWithNibName:@"InputCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:inputCellIdentifier];
    [tblViewResetPass registerNib:[UINib nibWithNibName:@"ButtonCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:buttonCellIdentifier];
    
    email = [tblViewResetPass dequeueReusableCellWithIdentifier:inputCellIdentifier];
    btnSubmit = [tblViewResetPass dequeueReusableCellWithIdentifier:buttonCellIdentifier];
    
    [email.txtField setPlaceHolder:@"Email ID" color:TXT_FLD_PLACEHOLDER_COLOR];
    
    [btnSubmit.button setTitle:@"SUBMIT" forState:UIControlStateNormal];
    [btnSubmit.button setTitle:@"SUBMIT" forState:UIControlStateSelected];
    
    btnSubmit.delegate = self;
    btnSubmit.layer.cornerRadius = 15.0f;
    btnSubmit.layer.masksToBounds = TRUE;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- buttonDelegate
-(void)buttonDidClicked:(UIButton *)sender{
        //Submit
    
    if ([AppDelegate sharedAppDelegate].internetReachablility) {
        //send request
        
        if (email.txtField.text.length <= 0 || ![email.txtField validEmail:email.txtField.text]) {
            
            [self showInfoAlert:@"" message:@"Please enter a valid Email ID" buttonTitle:@"Ok"];
            return;
        }
        
        
        [JTProgressHUD show];
        
        NSString* strEmail = email.txtField.text;
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSString* urlString = [NSString stringWithFormat:@"%@%@",BASE_URL,FORGOT_PASS_API];
        NSDictionary *parameters = @{@"email": strEmail};
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
                if (result.integerValue == 1) {
                    [self showInfoAlert:@"" message:[responsedict valueForKey:@"message"] buttonTitle:@"Ok" completionHander:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                }else{
                    [self showInfoAlert:@"" message:[responsedict valueForKey:@"message"] buttonTitle:@"Ok"];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return email;
    }
    else if (indexPath.row == 1) {
        return btnSubmit;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor clearColor];
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
