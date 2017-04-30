//
//  Menu.h
//  SaraTech
//
//  Created by iCoreTechnologies on 19/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubMenu : NSObject
@property(nonatomic,strong)NSString* downline;
@property(nonatomic,strong)NSString* linkid;
@property(nonatomic,strong)NSString* linkname;
@property(nonatomic,strong)NSString* parentid;
@property(nonatomic,strong)NSString* sno;
@property(nonatomic,strong)NSString* url;
-(id)initWithDict:(NSDictionary*)data;
@end

@interface Menu : SubMenu
@property(nonatomic,strong)NSMutableArray* subMenu;
@end
