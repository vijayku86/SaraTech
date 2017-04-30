//
//  CreateAccountCell.h
//  SaraTech
//
//  Created by iCoreTechnologies on 18/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CreateAccountCellDelegate <NSObject>
-(void)createAccountClicked:(UIButton*)sender;

@end
@interface CreateAccountCell : UITableViewCell
@property(nonatomic,strong) IBOutlet UIButton* button;
@property(unsafe_unretained)id<CreateAccountCellDelegate>delegate;
-(IBAction)buttonAction:(id)sender;
@end
