//
//  SideMenuViewController.h
//  MFSideMenuDemoStoryboard
//
//  Created by Michael Frederick on 5/7/13.
//  Copyright (c) 2013 Michael Frederick. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailsViewController, DashboardViewController;
@interface SideMenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

{
    IBOutlet UITableView *tableViewMenu;
    NSMutableArray *topItems;
     // array of arrays
    NSString* parentCellIdentifier, *childCellIdentifier;
    int currentExpandedIndex;
    DetailsViewController* detailVC;
    DashboardViewController* homeVC;
    UIStoryboard *storyboard;
}
@end
