//
//  InputCell.m
//  SaraTech
//
//  Created by iCoreTechnologies on 17/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import "InputCell.h"
#import "UITextField+Validations.h"
#import "Contants.h"

@implementation InputCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.txtField setBorderColor:TXT_FLD_BORDERCOLOR.CGColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
