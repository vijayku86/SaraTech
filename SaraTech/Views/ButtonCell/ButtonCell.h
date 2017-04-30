//
//  ButtonCell.h
//  SaraTech
//
//  Created by iCoreTechnologies on 17/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ButtonDelegate <NSObject>
-(void)buttonDidClicked:(UIButton*)sender;

@end

@interface ButtonCell : UITableViewCell
@property(nonatomic,strong) IBOutlet UIButton* button;
@property(unsafe_unretained) id<ButtonDelegate>delegate;
-(IBAction)buttonAction:(id)sender;
@end
