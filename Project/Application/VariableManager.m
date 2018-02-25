//
//  VariableManager.m
//  Project
//
//  Created by Malcolmn Roberts on 2016/10/05.
//  Copyright (c) 2016 Malcolmn Roberts. All rights reserved.
//

#import "VariableManager.h"

#define kEnvironmentBundleSetting @"environment_settings_bundle"

@implementation VariableManager


static VariableManager *sharedManager = nil;

+ (VariableManager *)sharedManager {
    if (sharedManager == nil) {
        sharedManager = [[super allocWithZone:NULL] init];
    }
    return sharedManager;
}

- (id) init {
    if (self = [super init]) {
        [self setApplicationEnvironmentVariables];
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        self.screenWidth = screenRect.size.width;
        self.screenHeight = screenRect.size.height;
        
    }
    return self;
}

-(void)setApplicationEnvironmentVariables
{
    NSString *environment = ([[NSUserDefaults standardUserDefaults] valueForKey:kEnvironmentBundleSetting] != nil) ? [[NSUserDefaults standardUserDefaults] valueForKey:kEnvironmentBundleSetting] : @"0";
    self.environment = [environment integerValue];
    
    switch (self.environment) {
        case EnvironmentProduction:
            self.SERVER_APP = @"https://varsitysportsapp.co.za/v1/index.php/";
            break;
        case EnvironmentStage:
            self.SERVER_APP = @"https://varsitysportsapp.co.za/staging/index.php/";
            break;
        case EnvironmentDevelopment:
            self.SERVER_APP = @"http://127.0.0.1:3000";
            break;
        default:
            NSAssert(false, @"Please set the Environment correctly!!!Please set the Environment!!!(VariableManager.environment)");
            break;
    }
}

@end
