//
//  ContactButtonCell.h
//  SaraTech
//
//  Created by iCoreTechnologies on 23/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QueryBtnDelegate <NSObject>
-(void)submitQueryClicked:(UIButton*)sender;
@end

@interface ContactButtonCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UIButton* button;
@property(unsafe_unretained)id<QueryBtnDelegate>delegate;
-(IBAction)submitQuery:(id)sender;
@end
