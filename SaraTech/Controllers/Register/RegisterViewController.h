//
//  RegisterViewController.h
//  SaraTech
//
//  Created by iCoreTechnologies on 16/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@class InputCell,ButtonCell;

@interface RegisterViewController : BaseViewController
{
    InputCell *  userName;
    InputCell *  email;
    InputCell *  password;
    ButtonCell*  btnSignUp;
    NSString *   cellIdentifier;
    NSString *   buttonCellIdentifier;
    
    IBOutlet UITableView* tblViewRegister;
    
}
@end
