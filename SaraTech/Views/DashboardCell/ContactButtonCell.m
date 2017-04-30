//
//  ContactButtonCell.m
//  SaraTech
//
//  Created by iCoreTechnologies on 23/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import "ContactButtonCell.h"

@implementation ContactButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.button.layer.cornerRadius = 15.0f;
    self.button.layer.masksToBounds = TRUE;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)submitQuery:(id)sender {
    if ([self.delegate respondsToSelector:@selector(submitQueryClicked:)]) {
        [self.delegate submitQueryClicked:sender];
    }
}

@end
