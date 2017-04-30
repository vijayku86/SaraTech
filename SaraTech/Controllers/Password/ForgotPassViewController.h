//
//  ForgotPassViewController.h
//  SaraTech
//
//  Created by iCoreTechnologies on 16/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import "BaseViewController.h"
@class InputCell,ButtonCell;
@interface ForgotPassViewController : BaseViewController
{
    InputCell*   email;
    ButtonCell*  btnSubmit;
    
    NSString* inputCellIdentifier;
    NSString* buttonCellIdentifier;
    
    IBOutlet UITableView* tblViewResetPass;
    
}
@end
