//
//  RegisterViewController.m
//  SaraTech
//
//  Created by iCoreTechnologies on 16/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import "RegisterViewController.h"
#import "UITextField+Validations.h"
#import "AppDelegate.h"
#import "InputCell.h"
#import "ButtonCell.h"
#import <AFNetworking.h>
#import <JTProgressHUD.h>



@interface RegisterViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ButtonDelegate>

@end

const NSString* cellIdentifier = @"InputCellIdentifier";

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    cellIdentifier = @"InputCellIdentifier";
    buttonCellIdentifier = @"ButtonCellIdentifier";
    
    tblViewRegister.backgroundColor = [UIColor clearColor];
    [tblViewRegister registerNib:[UINib nibWithNibName:@"InputCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
    [tblViewRegister registerNib:[UINib nibWithNibName:@"ButtonCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:buttonCellIdentifier];
    
    userName = [tblViewRegister dequeueReusableCellWithIdentifier:cellIdentifier];
    email = [tblViewRegister dequeueReusableCellWithIdentifier:cellIdentifier];
    password = [tblViewRegister dequeueReusableCellWithIdentifier:cellIdentifier];
    [password.txtField securedTextExtry];
    
    btnSignUp = [tblViewRegister dequeueReusableCellWithIdentifier:buttonCellIdentifier];
    [btnSignUp.button setTitle:@"SIGN UP" forState:UIControlStateNormal];
    [btnSignUp.button setTitle:@"SIGN UP" forState:UIControlStateSelected];
    btnSignUp.delegate = self;
    
    [userName.txtField setPlaceHolder:@"Your Name" color:TXT_FLD_PLACEHOLDER_COLOR];
    [email.txtField setPlaceHolder:@"Email ID" color:TXT_FLD_PLACEHOLDER_COLOR];
    [password.txtField setPlaceHolder:@"Password" color:TXT_FLD_PLACEHOLDER_COLOR];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- IBAction
-(void)buttonDidClicked:(UIButton *)sender{
    //RegisterButtonAction
    if (userName.txtField.text.length <= 0 ) {
        
        [self showInfoAlert:@"" message:@"Name required" buttonTitle:@"Ok"];
        return;
    }
    else if (email.txtField.text.length <= 0 || ![email.txtField validEmail:email.txtField.text]) {
        
        [self showInfoAlert:@"" message:@"Please enter a valid Email ID" buttonTitle:@"Ok"];
        return;
    }
    else if(password.txtField.text.length <= 3){
        [self showInfoAlert:@"" message:@"Please enter a valid Password" buttonTitle:@"Ok"];
        return;
    }
    
    if ([AppDelegate sharedAppDelegate].internetReachablility) {
        //send request
        
        [JTProgressHUD show];
        
        NSString* strEmail = email.txtField.text;
        NSString* strPass =  password.txtField.text;
        NSString* uname =    userName.txtField.text;
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSString* urlString = [NSString stringWithFormat:@"%@%@",BASE_URL,REGISTER_API];
        NSDictionary *parameters = @{@"email": strEmail, @"password": strPass, @"name":uname};
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:parameters error:nil];
        
        
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
                [self showInfoAlert:@"ERROR" message:[error debugDescription] buttonTitle:@"Ok"];
            } else {
                NSLog(@"response =%@,  responseObject=%@", response, responseObject);
                NSDictionary* responsedict  = [responseObject objectAtIndex:0];
                NSNumber * result = [responsedict valueForKey:@"result"];
                if (result.integerValue == 0) {
                    //Email already registered
                    [self showInfoAlert:@"" message:EMAIL_ALREADY_REGISTERED buttonTitle:@"Ok"];
                }else if(result.integerValue == 1){
                    //Email registered successfully
                    [self showInfoAlert:@"Registered Successfully" message:REGISTRATION_SUCCESSFULL buttonTitle:@"Ok" completionHander:^{
                        [self.navigationController popViewControllerAnimated:TRUE];
                    }];
                }
                else if(result.integerValue == 2){
                    //Email already registered and pending for verfication
                    [self showInfoAlert:@"" message:EMAIL_ALREADY_REGISTERED_VERIFICATION_PENDING buttonTitle:@"Ok" completionHander:^{
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return userName;
    }
    else if (indexPath.row == 1) {
        return email;
    }
    else if (indexPath.row == 2) {
        return password;
    }
    else if (indexPath.row == 3) {
        return btnSignUp;
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
