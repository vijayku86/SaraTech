//
//  DashboardViewController.m
//  SaraTech
//
//  Created by iCoreTechnologies on 19/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import "DashboardViewController.h"
#import <MFSideMenu.h>
#import "UITextField+Validations.h"
#import "InputCell.h"
#import "Contants.h"
#import "ContactButtonCell.h"
#import <JTProgressHUD.h>
#import <AFNetworking.h>
#import "AppDelegate.h"
#import "DashboardDetailVC.h"
@interface DashboardViewController ()<QueryBtnDelegate>
-(IBAction)quickChatAction:(id)sender;
@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"USer =%@",[AppDelegate sharedAppDelegate].userData);
    arrDropDown = [NSArray arrayWithObjects:[[AppDelegate sharedAppDelegate].userData userName],@"Change Password",@"Logout", nil];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    UIImage *image = [UIImage imageNamed:@"nav_title.png"];
    UIImageView * titleView = [[UIImageView alloc] initWithImage:image];
    [titleView setFrame:CGRectMake(0, 0, 118, 32)];
    self.navigationItem.titleView = titleView;
    
    dropDown = [[MKDropdownMenu alloc] initWithFrame:CGRectMake(0, 0, 44 , 44)];
    dropDown.dataSource = self;
    dropDown.delegate = self;
    dropDown.backgroundDimmingOpacity = -0.67;
    
    UIImage *indicator = [UIImage imageNamed:@"user"];
    dropDown.disclosureIndicatorImage = indicator;
    dropDown.disclosureIndicatorSelectionRotation= 0;
    dropDown.dropdownBouncesScroll = NO;
    dropDown.rowSeparatorColor = [UIColor lightGrayColor];
    dropDown.rowTextAlignment = NSTextAlignmentCenter;
    dropDown.dropdownRoundedCorners = UIRectCornerAllCorners;
    dropDown.useFullScreenWidth = YES;
    dropDown.fullScreenInsetLeft = 100;
    dropDown.fullScreenInsetRight = 20;
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:dropDown];
    
//    self.view.backgroundColor = [UIColor cyanColor];
    
    //[scrollViewC setContentSize:CGSizeMake(self.view.bounds.size.width+100, 850)];
    
    cellIdentifier = @"InputCellIdentifier";
    buttonCellIdentifier = @"ContactButtonCellIdentifier";
    
    tblViewContactUs.backgroundColor = [UIColor clearColor];
    [tblViewContactUs registerNib:[UINib nibWithNibName:@"InputCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
    [tblViewContactUs registerNib:[UINib nibWithNibName:@"ContactButtonCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:buttonCellIdentifier];
    
    fullName = [tblViewContactUs dequeueReusableCellWithIdentifier:cellIdentifier];
    emailId = [tblViewContactUs dequeueReusableCellWithIdentifier:cellIdentifier];
    phoneNum = [tblViewContactUs dequeueReusableCellWithIdentifier:cellIdentifier];
    btnSubmit = [tblViewContactUs dequeueReusableCellWithIdentifier:buttonCellIdentifier];
    
    btnSubmit.delegate = self;
    
    [fullName.txtField setPlaceHolder:@"Full Name" color:[UIColor lightGrayColor]];
    [emailId.txtField setPlaceHolder:@"Email ID" color:[UIColor lightGrayColor]];
    [phoneNum.txtField setPlaceHolder:@"Phone Number" color:[UIColor lightGrayColor]];
    
    [fullName.txtField setTextColor:[UIColor darkGrayColor]];
    [emailId.txtField setTextColor:[UIColor darkGrayColor]];
    [phoneNum.txtField setTextColor:[UIColor darkGrayColor]];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)showLeftMenuButton:(id)sender{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

-(IBAction)userProfile:(id)sender{
    
    
}

-(IBAction)dashboardMenuButtons:(id)sender{
    UIButton* button = (UIButton*)sender;
    NSString* linkname = @"";
    NSString* linkURL = @"";
    
    switch (button.tag) {
        case 101:
            linkname = @"Cloud Services";
            linkURL = @"http://saratechnologies.com/-IOS-Cloud-Services.aspx";
            break;
        case 102:
            
            linkname = @"Web Apps Development";
            linkURL = @"http://saratechnologies.com/-IOS-Web-Apps-Development.aspx";
            break;
        case 103:
            linkname = @"Cloud Apps Development";
            linkURL = @"http://saratechnologies.com/-IOS-Cloud-Apps-Development.aspx";
            break;
        case 104:
            linkname = @"IT Support";
            linkURL = @"http://saratechnologies.com/-IOS-IT-Support.aspx";
            break;
        case 105:
            linkname = @"Business Process Management";
            linkURL = @"http://saratechnologies.com/-IOS-Business-Process-Management.aspx";
            break;
        case 106:
            linkname = @"Mobile Apps Development";
            linkURL = @"http://saratechnologies.com/-IOS-Mobile-Apps-Development.aspx";
            break;
        case 107:
            linkname = @"Citrix Support Services";
            linkURL = @"http://saratechnologies.com/-IOS-Citrix-Support-Services.aspx";
            break;
        case 108:
            linkname = @"Consulting";
            linkURL = @"http://saratechnologies.com/-IOS-Consulting.aspx";
            break;
        case 109:
            linkname = @"Data Processing";
            linkURL = @"http://saratechnologies.com/-IOS-Data-Processing.aspx";
            break;
            
        default:
            break;
    }
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    DashboardDetailVC * detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DashboardDetailVC"];
    detailVC.linkName = linkname;
    detailVC.linkURL = linkURL;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


-(void)submitQueryClicked:(UIButton *)sender {
    
}

-(IBAction)quickChatAction:(id)sender {
    
}

#pragma mark- UITextFieldDelegate 
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [tblViewContactUs scrollRectToVisible:textField.frame animated:YES];
    return TRUE;
}

#pragma mark- UItableViewDelegate 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 44;
    }
    else if (indexPath.row == 1) {
        return 44;
    }
    else if (indexPath.row == 2) {
        return 44;
    }
    else if (indexPath.row == 3) {
        return 85;
    }
    return 44;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return fullName;
    }
    else if (indexPath.row == 1) {
        return emailId;
    }
    else if (indexPath.row == 2) {
        return phoneNum;
    }
    else if (indexPath.row == 3) {
        return btnSubmit;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor clearColor];
}

#pragma mark- MKDropDownDataSource & Delegate

- (CGFloat)dropdownMenu:(MKDropdownMenu *)dropdownMenu rowHeightForComponent:(NSInteger)component{
    return 30;
}


- (NSInteger)numberOfComponentsInDropdownMenu:(MKDropdownMenu *)dropdownMenu{
    return 1;
}
- (NSInteger)dropdownMenu:(MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component{
    return [arrDropDown count];
}

//- (NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    return [arrDropDown objectAtIndex:row];
//}

- (UIView *)dropdownMenu:(MKDropdownMenu *)dropdownMenu viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(10, 3, 120, 30)];
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:customView.frame];
    titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:13];
    titleLabel.textColor = [UIColor darkGrayColor];
    titleLabel.text = [arrDropDown objectAtIndex:row];
    [customView addSubview:titleLabel];
    return customView;
}



- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (row == 0) {
        [self performSegueWithIdentifier:@"EditViewController" sender:nil];
    }
    else if(row == 1){
        [self performSegueWithIdentifier:@"ChangePasswordVC" sender:nil];
    }else if(row == 2){
        [JTProgressHUD show];
        [[AppDelegate sharedAppDelegate] logoutApplication:^{
            [JTProgressHUD hide];
        }];
        
    }
   [dropDown closeAllComponentsAnimated:NO];
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
