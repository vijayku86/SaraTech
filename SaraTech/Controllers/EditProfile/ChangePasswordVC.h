//
//  ChangePasswordVC.h
//  SaraTech
//
//  Created by iCoreTechnologies on 25/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ChangePasswordVC : BaseViewController
{
    IBOutlet UITextField* tfOldPassword;
    IBOutlet UITextField* tfNewPassword;
    IBOutlet UITextField* tfConfirmPassword;
    IBOutlet UIButton* btnUpdate;
    
}
@end
