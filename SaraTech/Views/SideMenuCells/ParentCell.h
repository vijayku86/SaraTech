//
//  ParentCell.h
//  SaraTech
//
//  Created by iCoreTechnologies on 31/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ParentCellDelegate <NSObject>
-(void)arrowButtonDidClicked:(UIButton*)sender;


@end

@interface ParentCell : UITableViewCell
@property(nonatomic,strong) IBOutlet UIButton* btnArrow;
@property(nonatomic,strong) IBOutlet UILabel* lblTitle;
@property(unsafe_unretained) id<ParentCellDelegate>delegate;
-(IBAction)arrowBtnAction:(id)sender;
@end
