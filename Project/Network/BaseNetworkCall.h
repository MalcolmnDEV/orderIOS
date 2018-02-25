//
//  BaseNetworkCall.h
//  Project
//
//  Created by Malcolmn Roberts on 2016/10/05.
//  Copyright (c) 2016 Malcolmn Roberts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "ServerInterface.h"
#import "ResponseObject.h"
#import "APIProtocol.h"
#import "NetworkEnums.h"

static NSInteger const CONNECTION_TIMEOUT = 30;

@interface BaseNetworkCall : AFHTTPSessionManager

@property (nonatomic, weak) id<APIProtocol> delegate;

+ (void) doCallWithType: (BaseNetworkCallType)callType
               endPoint: (NSString *)endPoint
             parameters: (NSDictionary *)parameters
             requestTag: (NSInteger)requestTag
               delegate: (id<APIProtocol>)delegate;

// Uncomment if there is more than one server

//+ (void) doCallWithType: (BaseNetworkCallType)callType
//               endPoint: (NSString *)endPoint
//             parameters: (NSDictionary *)parameters
//             requestTag: (NSNumber *)requestTag
//               delegate: (id<APIProtocol>)delegate
//withBaseNetworkInstance: (BaseNetworkInstance)baseNetworkInstance;

@end
