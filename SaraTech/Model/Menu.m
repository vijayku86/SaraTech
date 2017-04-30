//
//  Menu.m
//  SaraTech
//
//  Created by iCoreTechnologies on 19/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import "Menu.h"

@implementation SubMenu
-(id)initWithDict:(NSDictionary*)data{
    if (self = [super init]) {
        self.downline = [data valueForKey:@"downline"];
        self.linkid = [data valueForKey:@"linkid"];
        self.linkname = [data valueForKey:@"linkname"];
        self.parentid = [data valueForKey:@"parentid"];
        self.sno = [data valueForKey:@"sno"];
        self.url = [data valueForKey:@"url"];
    }
    return self;
}
@end

@implementation Menu

@end
