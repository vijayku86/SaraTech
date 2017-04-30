//
//  TransparentCell.h
//  SaraTech
//
//  Created by iCoreTechnologies on 18/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ForgotPassCellDelegate <NSObject>

-(void)ForgotPassClicked:(UIButton*)sender;

@end

@interface ForgotPassCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UIButton* button;
@property(unsafe_unretained)id<ForgotPassCellDelegate>delegate;
-(IBAction)buttonAction:(id)sender;
@end
