//
//  EditViewController.h
//  SaraTech
//
//  Created by iCoreTechnologies on 25/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface EditViewController : BaseViewController
{
    IBOutlet UITextField* tfname;
    IBOutlet UITextField* tfContactNo;
    IBOutlet UIButton* btnSubmit;
}
@end
