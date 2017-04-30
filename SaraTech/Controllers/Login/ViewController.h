//
//  ViewController.h
//  SaraTech
//
//  Created by iCoreTechnologies on 16/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class InputCell,ButtonCell,ForgotPassCell,CreateAccountCell;
@interface ViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    InputCell*      email;
    InputCell*      password;
    ButtonCell*     btnSubmit;
    ForgotPassCell*     btnForgotPass;
    CreateAccountCell*     btnCreateAccount;
    IBOutlet UITableView*    tblViewSignIn;
    NSString*       txtCellIdentifier;
    NSString*       buttonCellIdentifier;
    NSString*       transButtonIdentifier;
    NSString*       createAccountButtonIdentifier;
    
    
}

@end

