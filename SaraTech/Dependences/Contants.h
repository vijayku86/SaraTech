//
//  Contants.h
//  SaraTech
//
//  Created by iCoreTechnologies on 16/03/17.
//  Copyright © 2017 iCore Technologies. All rights reserved.
//

#ifndef Contants_h
#define Contants_h

#define TXT_FLD_BORDERCOLOR      [UIColor colorWithRed:49/255.0 green:84/255.0 blue:158/255.0 alpha:1.0]
#define TXT_FLD_PLACEHOLDER_COLOR [UIColor whiteColor]

#define BASE_URL            @"http://saratechnologies.com/WebService.asmx"
#define LOGIN_API           @"/Login"
#define FORGOT_PASS_API     @"/ForgotPassword"
#define REGISTER_API        @"/Register"
#define GET_LINKS_API       @"/GetLinks"
#define EDIT_PROFILE_API    @"/EditProfile"
#define UPDATE_PASSWORD_API    @"/UpdatePassword"


#define CONNECTION_ERROR_MSG    @"Internet seems to be Disabled try again later!"
#define EMAIL_NOT_REGISTERED    @"Email ID not registered with us"
#define REGISTRATION_SUCCESSFULL    @"Please click on the link that has been sent to your email account to verify your email."
#define EMAIL_ALREADY_REGISTERED_VERIFICATION_PENDING    @"Email already registered but not yet verified"
#define EMAIL_ALREADY_REGISTERED    @"Email already registered with us."

#define FONT_SEMI_BOLD          @"AppleSDGothicNeo-Bold"
#define FONT_MEDIUM_BOLD        @"AppleSDGothicNeo-Medium"
#define FONT_REGULAR            @"AppleSDGothicNeo-Regular"
#endif /* Contants_h */
