//
//  BaseNetworkCall.m
//  Project
//
//  Created by Heinrich Dahms on 2015/07/31.
//  Copyright (c) 2015 Malcolmnmobile. All rights reserved.
//

#import "BaseNetworkCall.h"
#import "UtilitiesHelper.h"

@implementation BaseNetworkCall


+ (void) doCallWithType: (BaseNetworkCallType)callType
               endPoint: (NSString *)endPoint
             parameters: (NSDictionary *)parameters
             requestTag: (NSInteger)requestTag
               delegate: (id<APIProtocol>)delegate
{
    [BaseNetworkCall doCallWithType:callType endPoint:endPoint parameters:parameters requestTag:requestTag delegate:delegate withBaseNetworkInstance:BaseNetworkInstanceMain];
}

+(NSMutableDictionary *)includeTimeZoneInParameters:(NSDictionary *)parameters
{
    NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
    //NSLog(@"currentTimeZone %@",currentTimeZone);
    //NSLog(@"currentTimeZone %ld",(long)currentTimeZone.secondsFromGMT);
    
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [d setValue:[NSNumber numberWithInteger:currentTimeZone.secondsFromGMT/(60*60)] forKey:@"time_zone"];
    //NSLog(@"d : %@",d);
    return d;
}

+ (void) doCallWithType: (BaseNetworkCallType)callType
               endPoint: (NSString *)endPoint
             parameters: (NSDictionary *)parameters
             requestTag: (NSInteger)requestTag
               delegate: (id<APIProtocol>)delegate
withBaseNetworkInstance: (BaseNetworkInstance)baseNetworkInstance
{
    
    //jjk : include timezone in every network call
    parameters = [BaseNetworkCall includeTimeZoneInParameters:parameters];
    
    ServerInterface *sharedInstance;
    
    switch (baseNetworkInstance) {
        case BaseNetworkInstanceMain:
            sharedInstance = [ServerInterface sharedInstance];
            break;
            
        default:
            sharedInstance = [ServerInterface sharedInstance];
            break;
    }
    
    //Connection setup
    [sharedInstance setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [sharedInstance setResponseSerializer:[AFJSONResponseSerializer serializer]];
    //    sharedInstance.requestSerializer.timeoutInterval = CONNECTION_TIMEOUT;
    
    sharedInstance.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    [sharedInstance.requestSerializer setTimeoutInterval:20];
    
    __block ResponseObject *returnedResponseObject = [[ResponseObject alloc]init];
    returnedResponseObject.requestTag = requestTag;
    
    if (![AFNetworkReachabilityManager sharedManager].reachable) {
        
        returnedResponseObject.success = false;
        returnedResponseObject.error = BaseNetworkErrorNoInternet;
        
        [delegate onFail:returnedResponseObject];
        
        return;
    }
    
    void (^_onSuccess)(NSURLSessionDataTask *, id) = ^void(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"error_code"] integerValue] == 1 && requestTag != 124)
        {
            [[UtilitiesHelper sharedManager] authFailReturnToLanding];
        }
        else if ([responseObject[@"error_code"] integerValue] == 2)// Blocked
        {
            [[UtilitiesHelper sharedManager] userBlockedPopUp];
        }
        else if ([responseObject[@"error_code"] integerValue] == 3)// Deleted
        {
            [[UtilitiesHelper sharedManager] userDeletedPopUp];
        }
        else
        {
            returnedResponseObject.success = true;
            returnedResponseObject.message = responseObject;
            [delegate onSuccess:returnedResponseObject];
        }
    };
    
    void (^_onFail)(NSURLSessionDataTask *, NSError *) = ^void(NSURLSessionDataTask *task, NSError *error) {
        
        if (error.code == NSURLErrorTimedOut)
        {
            returnedResponseObject.error = BaseNetworkErrorConnectionTimeout;
        }
        
        returnedResponseObject.success = false;
        
        NSError *jsonError;
        
        //        NSDictionary *errordict = error;
        
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:[error.userInfo[NSLocalizedDescriptionKey] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&jsonError];
        //        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:[error.userInfo[@"NSDebugDescription"] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&jsonError];
        
        if (jsonError == nil) {
            returnedResponseObject.message = responseJSON;
        } else {
            returnedResponseObject.message = error.userInfo[NSLocalizedDescriptionKey];
        }
        
        [delegate onFail:returnedResponseObject];
    };
    
    
    switch (callType) {
        case BaseNetworkCallTypePOST:
        {
            [sharedInstance POST:endPoint
                      parameters:parameters
                        progress:nil
                         success:_onSuccess
                         failure:_onFail];
            
            break;
        }
            
        default:
        case BaseNetworkCallTypeGET:
        {
            [sharedInstance GET:endPoint
                     parameters:parameters
                       progress:nil
                        success:_onSuccess
                        failure:_onFail];
            break;
        }
            
        case BaseNetworkCallTypeDELETE:
        {
            [sharedInstance DELETE:endPoint
                        parameters:parameters
                           success: _onSuccess
                           failure: _onFail];
            break;
        }
            
        case BaseNetworkCallTypePUT:
        {
            [sharedInstance PUT:endPoint
                     parameters:parameters
                        success: _onSuccess
                        failure: _onFail];
            break;
        }
    }
    
}

@end
