//
//  UtilitiesHelper.h
//  Adv Clubs
//
//  Created by Malcolmn Roberts on 2016/04/05.
//  Copyright © 2016 Malcolmnmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtilitiesHelper : NSObject 

+ (UtilitiesHelper *)sharedManager;


-(void)authFailReturnToLanding;

-(void)userBlockedPopUp;
-(void)userDeletedPopUp;


@end
