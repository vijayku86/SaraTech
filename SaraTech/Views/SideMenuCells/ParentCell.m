//
//  ParentCell.m
//  SaraTech
//
//  Created by iCoreTechnologies on 31/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import "ParentCell.h"

@implementation ParentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)arrowBtnAction:(id)sender{
    if ([self.delegate respondsToSelector:@selector(arrowButtonDidClicked:)]) {
        [self.delegate arrowButtonDidClicked:sender];
    }
}

@end
