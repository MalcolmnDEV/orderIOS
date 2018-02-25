//
//  APIProtocol.h
//  Project
//
//  Created by Malcolmn Roberts on 2016/10/05.
//  Copyright (c) 2016 Malcolmn Roberts. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ResponseObject;

@protocol APIProtocol;

@protocol APIProtocol <NSObject>

@optional
- (void) onStart;
- (void) onComplete;

@required
- (void) onSuccess: (ResponseObject *) responseObject;
- (void) onFail: (ResponseObject *) responseObject;

@end
