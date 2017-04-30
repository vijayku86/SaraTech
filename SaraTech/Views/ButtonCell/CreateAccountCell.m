//
//  CreateAccountCell.m
//  SaraTech
//
//  Created by iCoreTechnologies on 18/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import "CreateAccountCell.h"

@implementation CreateAccountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)buttonAction:(id)sender{
    if ([self.delegate respondsToSelector:@selector(createAccountClicked:)]) {
        [self.delegate createAccountClicked:self.button];
    }
}

@end
