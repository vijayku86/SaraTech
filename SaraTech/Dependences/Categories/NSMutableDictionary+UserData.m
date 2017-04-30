//
//  NSMutableDictionary+UserData.m
//  SaraTech
//
//  Created by iCoreTechnologies on 27/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import "NSMutableDictionary+UserData.h"

@implementation NSMutableDictionary (UserData)

-(void) setUserID:(NSString*) userId{
    [self setObject:userId forKey:@"ID"];
}
-(void) setUserEmail:(NSString*) email{
    [self setObject:email forKey:@"EmailId"];
}
-(void) setUserName:(NSString*) name{
    [self setObject:name forKey:@"UserName"];
}
-(void) setPhoneNumber:(NSString*) number{
    [self setObject:number forKey:@""];
}

-(NSString*) userID{
    return [self valueForKey:@"ID"];
}
-(NSString*) userEmail{
    return [self valueForKey:@"EmailId"];
}
-(NSString*) userName{
    return [self valueForKey:@"UserName"];
}
-(NSString*) userPhoneNumber{
    return [self valueForKey:@""];
}

@end
