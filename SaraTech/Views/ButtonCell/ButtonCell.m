//
//  ButtonCell.m
//  SaraTech
//
//  Created by iCoreTechnologies on 17/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import "ButtonCell.h"

@implementation ButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.button.layer.cornerRadius = 15.0f;
    self.button.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)buttonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(buttonDidClicked:)]) {
        [self.delegate buttonDidClicked:self.button];
    }
}
@end
