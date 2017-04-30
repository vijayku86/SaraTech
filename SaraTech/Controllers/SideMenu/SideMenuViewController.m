//
//  SideMenuViewController.m
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import "SideMenuViewController.h"
#import "MFSideMenu.h"
#import "DashboardViewController.h"
#import "AppDelegate.h"
#import <AFNetworking.h>
#import <JTProgressHUD.h>
#import "Contants.h"
#import "Menu.h"
#import "DetailsViewController.h"
#import "ParentCell.h"
#import "ChildCell.h"
@interface SideMenuViewController() <ParentCellDelegate>

@end

@implementation SideMenuViewController

#pragma mark -
-(void)viewDidLoad {
    [super viewDidLoad];
    
    topItems = [[NSMutableArray alloc] init];
    currentExpandedIndex = -1;
 
    parentCellIdentifier = @"ParentCellIdentifier";
    childCellIdentifier  = @"ChildCellIdentifier";
    
//    [tableViewMenu registerNib:[UINib nibWithNibName:@"ParentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:parentCellIdentifier];
//    [tableViewMenu registerNib:[UINib nibWithNibName:@"ChildCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:childCellIdentifier];
    
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    homeVC = [storyboard instantiateViewControllerWithIdentifier:@"DashboardViewController"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadHomePage) name:@"loadHomePage" object:nil];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [topItems removeAllObjects];
    [self performSelector:@selector(getMenuItems) withObject:nil afterDelay:1];
}

-(void)getMenuItems {
    
    if ([AppDelegate sharedAppDelegate].internetReachablility) {
        //send request
        
        [JTProgressHUD show];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSString* urlString = [NSString stringWithFormat:@"%@%@",BASE_URL,GET_LINKS_API];
        NSDictionary *parameters = @{};
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:parameters error:nil];
        
        
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                NSLog(@"response =%@,  responseObject=%@", response, responseObject);
                
                NSDictionary* defualtDict = [NSDictionary dictionaryWithObjectsAndKeys:@"-1",@"downline",@"-1",@"linkid",@"Home",@"linkname",@"-1",@"parentid",@"-1",@"sno",@"-1",@"url", nil];
                Menu* m = [[Menu alloc] initWithDict:defualtDict];
                m.subMenu = [NSMutableArray new];
                [topItems addObject:m];
                
                NSArray* arrResponse = (NSArray*)responseObject;
                NSLog(@"arrresponse = %@",arrResponse);
                
                NSString* filter = @"%K CONTAINS[cd] %@";
                NSPredicate* predicate = [NSPredicate predicateWithFormat:filter, @"parentid", @"0"];
                NSArray* filteredData = [arrResponse filteredArrayUsingPredicate:predicate];
                NSLog(@"filetered = %@",filteredData);
                
                for (int index=0; index < [filteredData count]; index++) {
                    NSDictionary* dic = [filteredData objectAtIndex:index];
                    NSString* linkId = [dic valueForKey:@"linkid"];
                    NSPredicate* predicate = [NSPredicate predicateWithFormat:filter, @"parentid", linkId];
                    NSArray* subMenuItems = [arrResponse filteredArrayUsingPredicate:predicate];
                    
                    NSLog(@"secondlvl =%@",subMenuItems);
                    
                    Menu *menu = [[Menu alloc] initWithDict:dic];
                    menu.subMenu = [NSMutableArray new];
                    for (int i=0; i<[subMenuItems count]; i++) {
                        NSDictionary* subDict = [subMenuItems objectAtIndex:i];
                        SubMenu* sub = [[SubMenu alloc] initWithDict:subDict];
                        [menu.subMenu addObject:sub];
                    }
                    [topItems addObject:menu];
                }
                
                [tableViewMenu reloadData];
            }
            
            [JTProgressHUD hide];
        }];
        [dataTask resume];
        
    }else{
        //show alert
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"" message:CONNECTION_ERROR_MSG preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* done = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:done];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
}

-(void)loadHomePage{
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    NSArray *controllers = [NSArray arrayWithObject:homeVC];
    navigationController.viewControllers = controllers;
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}

#pragma mark- ParentCellDelegate
-(void)arrowButtonDidClicked:(UIButton *)sender {
    
    [tableViewMenu beginUpdates];
    
    if (currentExpandedIndex == sender.tag) {
        [self collapseSubItemsAtIndex:currentExpandedIndex];
        currentExpandedIndex = -1;
    }
    else {
        
        BOOL shouldCollapse = currentExpandedIndex > -1;
        
        if (shouldCollapse) {
            [self collapseSubItemsAtIndex:currentExpandedIndex];
        }
        currentExpandedIndex = (shouldCollapse && sender.tag > currentExpandedIndex) ? (int)sender.tag - (int)[[[topItems objectAtIndex:currentExpandedIndex] subMenu]  count] : (int)sender.tag;
        [self expandItemAtIndex:currentExpandedIndex];
    }
    [tableViewMenu endUpdates];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [topItems count] + ((currentExpandedIndex > -1) ? [[[topItems objectAtIndex:currentExpandedIndex] subMenu]  count] : 0);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ParentCellIdentifier = @"ParentCell";
    static NSString *ChildCellIdentifier = @"ChildCell";
    
    BOOL isChild =
    currentExpandedIndex > -1
    && indexPath.row > currentExpandedIndex
    && indexPath.row <= currentExpandedIndex + [[[topItems objectAtIndex:currentExpandedIndex] subMenu]  count];
    
    UITableViewCell *cell;
    
    
    if (isChild) {
        cell = [tableView dequeueReusableCellWithIdentifier:ChildCellIdentifier];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:ParentCellIdentifier];
    }
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ParentCellIdentifier] ;
    }
    
    if (isChild) {
        NSString* sublinkname = [NSString stringWithFormat:@"   %@",((SubMenu*)[[[topItems objectAtIndex:currentExpandedIndex] subMenu]   objectAtIndex:indexPath.row - currentExpandedIndex - 1]).linkname];
        cell.detailTextLabel.text = sublinkname;

        cell.detailTextLabel.font = [UIFont fontWithName:FONT_MEDIUM_BOLD size:15.0];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        
//        cell.detailTextLabel.font = [UIFont fontWithName:FONT_MEDIUM_BOLD size:15.0];
//        cell.detailTextLabel.textColor = [UIColor whiteColor];
    }
    else {
        int topIndex = (currentExpandedIndex > -1 && indexPath.row > currentExpandedIndex)
        ? (int)indexPath.row - (int)[[[topItems objectAtIndex:currentExpandedIndex] subMenu] count]
        : (int)indexPath.row;
        
        cell.textLabel.text = [((Menu*)[topItems objectAtIndex:topIndex]).linkname uppercaseString];
        cell.textLabel.font = [UIFont fontWithName:FONT_SEMI_BOLD size:17.0];
        
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.text = @"";
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
        cell.tintColor = [UIColor whiteColor];
        
//        UIButton * disclosureButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [disclosureButton setFrame:CGRectMake(8, 12, 13, 18)];
//        [disclosureButton setImage:[UIImage imageNamed:@"arrow_right.png"] forState:UIControlStateNormal];
//        [disclosureButton setImage:[UIImage imageNamed:@"arrow_down.png"] forState:UIControlStateSelected];
//        [disclosureButton addTarget:self action:@selector(arrowButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
//        disclosureButton.tag = topIndex;
//        cell.accessoryView = disclosureButton;
//        cell.editingAccessoryType = UITableViewCellAccessoryDetailDisclosureButton;
//        ((ParentCell*)cell).lblTitle.text = [((Menu*)[topItems objectAtIndex:topIndex]).linkname uppercaseString];
//        ((ParentCell*)cell).lblTitle.font = [UIFont fontWithName:FONT_SEMI_BOLD size:17.0];
//        ((ParentCell*)cell).delegate = self;
//        ((ParentCell*)cell).btnArrow.tag = topIndex;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor clearColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isChild =
    currentExpandedIndex > -1
    && indexPath.row > currentExpandedIndex
    && indexPath.row <= currentExpandedIndex + [[[topItems objectAtIndex:currentExpandedIndex] subMenu]  count];
    
    if (indexPath.row == 0) {
        
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:homeVC];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }else{
        if (isChild) {
            
            NSLog(@"A child was tapped, do what you will with it");
            
            SubMenu* submenu = ((SubMenu*)[[[topItems objectAtIndex:currentExpandedIndex] subMenu]   objectAtIndex:indexPath.row - currentExpandedIndex - 1]);
            
            detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
            detailVC.linkName = submenu.linkname;
            detailVC.linkUrl = submenu.url;
            
            
            UINavigationController *detailNavigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"detailNavigationController"];
            
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:detailVC];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            
            return;
        }
        
//        [tableViewMenu beginUpdates];
//        
//        if (currentExpandedIndex == indexPath.row) {
//            [self collapseSubItemsAtIndex:currentExpandedIndex];
//            currentExpandedIndex = -1;
//        }
//        else {
//            
//            BOOL shouldCollapse = currentExpandedIndex > -1;
//            
//            if (shouldCollapse) {
//                [self collapseSubItemsAtIndex:currentExpandedIndex];
//            }
//            currentExpandedIndex = (shouldCollapse && indexPath.row > currentExpandedIndex) ? (int)indexPath.row - (int)[[[topItems objectAtIndex:currentExpandedIndex] subMenu]  count] : (int)indexPath.row;
//            [self expandItemAtIndex:currentExpandedIndex];
//        }
//        [tableViewMenu endUpdates];
        Menu* menu = [topItems objectAtIndex:indexPath.row];
        
        detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
        detailVC.linkName = menu.linkname;
        detailVC.linkUrl = menu.url;
        
        UINavigationController *detailNavigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"detailNavigationController"];
        
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:detailVC];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
    
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    [tableViewMenu beginUpdates];
    
    if (currentExpandedIndex == indexPath.row) {
        [self collapseSubItemsAtIndex:currentExpandedIndex];
        currentExpandedIndex = -1;
    }
    else {
        
        BOOL shouldCollapse = currentExpandedIndex > -1;
        
        if (shouldCollapse) {
            [self collapseSubItemsAtIndex:currentExpandedIndex];
        }
        currentExpandedIndex = (shouldCollapse && indexPath.row > currentExpandedIndex) ? (int)indexPath.row - (int)[[[topItems objectAtIndex:currentExpandedIndex] subMenu]  count] : (int)indexPath.row;
        [self expandItemAtIndex:currentExpandedIndex];
    }
    [tableViewMenu endUpdates];
    
}

- (void)expandItemAtIndex:(int)index {
    NSMutableArray *indexPaths = [NSMutableArray new];
    NSArray *currentSubItems = [[topItems objectAtIndex:currentExpandedIndex]  subMenu];
    int insertPos = index + 1;
    for (int i = 0; i < [currentSubItems count]; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:insertPos++ inSection:0]];
    }
    [tableViewMenu insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    [tableViewMenu scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

- (void)collapseSubItemsAtIndex:(int)index {
    NSMutableArray *indexPaths = [NSMutableArray new];
    for (int i = index + 1; i <= index + [[[topItems objectAtIndex:index] subMenu] count]; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    [tableViewMenu deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    
}



 


@end
