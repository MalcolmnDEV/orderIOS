//
//  VariableManager.h
//  Project
//
//  Created by Malcolmn Roberts on 2016/10/05.
//  Copyright (c) 2016 Malcolmn Roberts. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ApplicationEnvironment)
{
    EnvironmentProduction = 0,
    EnvironmentStage = 1,
    EnvironmentDevelopment = 2
    //,might need more
} ;

// App constants used to setup environments
// Example: IS_LIVE or IS_ENCRYPTED
static BOOL const IS_LIVE = false;

@interface VariableManager : NSObject

// Malcolmn Mobile Server Link
@property(nonatomic, strong) NSString *SERVER_APP;
@property(nonatomic, assign) ApplicationEnvironment environment;

// VariableManager Singleton
+ (VariableManager *)sharedManager;

@property (assign, nonatomic) CGFloat screenWidth;
@property (assign, nonatomic) CGFloat screenHeight;

@end
