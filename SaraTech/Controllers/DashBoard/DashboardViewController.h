//
//  DashboardViewController.h
//  SaraTech
//
//  Created by iCoreTechnologies on 19/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <MKDropdownMenu.h>

@class InputCell,ContactButtonCell;
@interface DashboardViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,MKDropdownMenuDataSource,MKDropdownMenuDelegate>
{
    IBOutlet UIScrollView* scrollViewC;
    IBOutlet UITableView*  tblViewContactUs;
    
    NSString* cellIdentifier ;
    NSString* buttonCellIdentifier ;
    
    InputCell* fullName;
    InputCell* emailId;
    InputCell* phoneNum;
    ContactButtonCell* btnSubmit;
    MKDropdownMenu* dropDown;
    
    NSArray* arrDropDown;
    
}


@end
