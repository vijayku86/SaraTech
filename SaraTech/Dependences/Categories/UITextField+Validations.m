//
//  UITextField+Validations.m
//  SaraTech
//
//  Created by iCoreTechnologies on 16/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import "UITextField+Validations.h"


@implementation UITextField (Validations)

-(void)setBorderColor:(CGColorRef)color {
    self.layer.borderColor = color;
    self.layer.borderWidth = 1.0f;
    
}

-(void)setPlaceHolder:(NSString*)placeHolder color:(UIColor*)color{
//    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolder attributes:[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName]];
}

-(void)securedTextExtry{
    [self setSecureTextEntry:TRUE];
}

-(BOOL)validEmail:(NSString*)email {
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
@end
