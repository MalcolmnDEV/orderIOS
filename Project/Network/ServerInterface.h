//
//  ServerInterface.h
//
//  Created by Malcolmn Roberts on 2016/10/05.
//  Copyright (c) 2016 Malcolmn Roberts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "VariableManager.h"


@interface ServerInterface : AFHTTPSessionManager

+ (instancetype)sharedInstance;

// For ease of use, add a sharedInstance for each server (or each base URL)
//+ (instancetype)sharedInstanceEvents;

@end

