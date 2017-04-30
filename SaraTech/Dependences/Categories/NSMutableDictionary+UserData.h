//
//  NSMutableDictionary+UserData.h
//  SaraTech
//
//  Created by iCoreTechnologies on 27/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (UserData)

-(void) setUserID:(NSString*) userId;
-(void) setUserEmail:(NSString*) email;
-(void) setUserName:(NSString*) name;
-(void) setPhoneNumber:(NSString*) number;

-(NSString*) userID;
-(NSString*) userEmail;
-(NSString*) userName;
-(NSString*) userPhoneNumber;

@end
