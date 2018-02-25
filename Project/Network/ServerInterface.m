//
//  ServerInterface.m
//
//  Created by Malcolmn Roberts on 2016/10/05.
//  Copyright (c) 2016 Malcolmn Roberts. All rights reserved.
//

#import "ServerInterface.h"

@implementation ServerInterface

#pragma mark - Singleton


+ (instancetype)sharedInstance
{
    static ServerInterface *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ServerInterface alloc] initWithBaseURL:[NSURL URLWithString:[VariableManager sharedManager].SERVER_APP]];
        
        // Change the allowInvalidCertificates to yes when https has not been setup correctly
        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        policy.allowInvalidCertificates = NO;
        sharedInstance.securityPolicy = policy;
    });
    
    return sharedInstance;
}

@end
