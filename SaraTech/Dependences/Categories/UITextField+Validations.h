//
//  UITextField+Validations.h
//  SaraTech
//
//  Created by iCoreTechnologies on 16/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Validations)

-(void)setBorderColor:(CGColorRef)color;
-(void)setPlaceHolder:(NSString*)placeHolder color:(UIColor*)color;
-(void)securedTextExtry;
-(BOOL)validEmail:(NSString*)email ;
@end
