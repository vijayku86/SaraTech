//
//  ViewController.m
//  SaraTech
//
//  Created by iCoreTechnologies on 16/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+Validations.h"
#import "Contants.h"
#import "InputCell.h"
#import "ButtonCell.h"
#import "ForgotPassCell.h"
#import "CreateAccountCell.h"
#import "AppDelegate.h"
#import <AFNetworking.h>
#import <JTProgressHUD.h>

@interface ViewController ()<UITextFieldDelegate,ButtonDelegate,ForgotPassCellDelegate,CreateAccountCellDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    txtCellIdentifier = @"InputCellIdentifier";
    buttonCellIdentifier = @"ButtonCellIdentifier";
    transButtonIdentifier = @"ForgotPassCellIdentifier";
    createAccountButtonIdentifier = @"CreateAccountCellIdentifier";
    
    tblViewSignIn.backgroundColor = [UIColor clearColor];
    [tblViewSignIn registerNib:[UINib nibWithNibName:@"InputCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:txtCellIdentifier];
    [tblViewSignIn registerNib:[UINib nibWithNibName:@"ButtonCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:buttonCellIdentifier];
    [tblViewSignIn registerNib:[UINib nibWithNibName:@"ForgotPassCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:transButtonIdentifier];
    [tblViewSignIn registerNib:[UINib nibWithNibName:@"CreateAccountCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:createAccountButtonIdentifier];
    
    
    email = [tblViewSignIn dequeueReusableCellWithIdentifier:txtCellIdentifier];
    password = [tblViewSignIn dequeueReusableCellWithIdentifier:txtCellIdentifier];
    btnSubmit = [tblViewSignIn dequeueReusableCellWithIdentifier:buttonCellIdentifier];
    btnForgotPass = [tblViewSignIn dequeueReusableCellWithIdentifier:transButtonIdentifier];
    btnCreateAccount = [tblViewSignIn dequeueReusableCellWithIdentifier:createAccountButtonIdentifier];
    
    btnSubmit.delegate = self;
    btnForgotPass.delegate = self;
    btnCreateAccount.delegate = self;
    
    [email.txtField setPlaceHolder:@"Email ID" color:TXT_FLD_PLACEHOLDER_COLOR];
    [password.txtField setPlaceHolder:@"Password" color:TXT_FLD_PLACEHOLDER_COLOR];
    [password.txtField securedTextExtry];
    
    [btnSubmit.button setTitle:@"SIGN IN" forState:UIControlStateSelected];
    [btnSubmit.button setTitle:@"SIGN IN" forState:UIControlStateNormal];
    
    [btnForgotPass.button setTitle:@"Forgot Password?" forState:UIControlStateSelected];
    [btnForgotPass.button setTitle:@"Forgot Password?" forState:UIControlStateNormal];
    
    [btnCreateAccount.button setTitle:@"Not Registered? Create an account." forState:UIControlStateSelected];
    [btnCreateAccount.button setTitle:@"Not Registered? Create an account." forState:UIControlStateNormal];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- ButtonDelegates
-(void)buttonDidClicked:(UIButton *)sender{
    
    if ([AppDelegate sharedAppDelegate].internetReachablility) {
        //send request
        
        if (email.txtField.text.length <= 0 || ![email.txtField validEmail:email.txtField.text]) {
            
            [self showInfoAlert:@"" message:@"Please enter a valid Email ID" buttonTitle:@"Ok"];
            return;
        }
        else if(password.txtField.text.length <= 3){
            [self showInfoAlert:@"" message:@"Please enter a valid Password" buttonTitle:@"Ok"];
            return;
        }
        
        [JTProgressHUD show];
        
        NSString* strEmail = email.txtField.text;
        NSString* strPass =  password.txtField.text;
        
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSString* urlString = [NSString stringWithFormat:@"%@%@",BASE_URL,LOGIN_API];
        NSDictionary *parameters = @{@"email": strEmail, @"password": strPass};
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:parameters error:nil];

        
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
                [self showInfoAlert:@"ERROR" message:[error debugDescription] buttonTitle:@"Ok"];
            } else {
                NSLog(@"response =%@,  responseObject=%@", response, responseObject);
                NSDictionary* responsedict  = [responseObject objectAtIndex:0];
                NSNumber * result = [responsedict valueForKey:@"result"];
                 if (result.integerValue == 1){
                     //save details
                     
                     NSNumber* uID = [responsedict valueForKey:@"ID"];
                     NSString* strUid = [NSString stringWithFormat:@"%ld",uID.longValue];
                     NSString* uname = [responsedict valueForKey:@"name"];
                     NSString* strEmail = [responsedict valueForKey:@"EmailId"];
                     
                     [AppDelegate sharedAppDelegate].userData = [NSMutableDictionary new];
                     [[AppDelegate sharedAppDelegate].userData setUserID:strUid];
                     [[AppDelegate sharedAppDelegate].userData setUserName:uname];
                     [[AppDelegate sharedAppDelegate].userData setUserEmail:strEmail];
                     
                     [[NSUserDefaults standardUserDefaults] setObject:[AppDelegate sharedAppDelegate].userData forKey:@"User"];
                     [[NSUserDefaults standardUserDefaults] synchronize];
                     
                    [[AppDelegate sharedAppDelegate] sideMenuWithDashboard]; 
                    
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

-(void)ForgotPassClicked:(UIButton *)sender{
 
    [self performSegueWithIdentifier:@"ForgotPasswordSegue" sender:nil];
}

-(void)createAccountClicked:(UIButton *)sender{
    [self performSegueWithIdentifier:@"RegisterViewControllerSegue" sender:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 44;
    }
    else if (indexPath.row == 1){
        return 44;
    }
    else if (indexPath.row == 2){
        return 25;
    }
    else if (indexPath.row == 3){
        return 44;
    }
    else if (indexPath.row == 4){
        return 25;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return email;
    }
    else if (indexPath.row == 1) {
        return password;
    }
    else if (indexPath.row == 2) {
        return btnForgotPass;
    }
    else if (indexPath.row == 3) {
        return btnSubmit;
    }
    else if (indexPath.row == 4) {
        return btnCreateAccount;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor clearColor];
}


@end
