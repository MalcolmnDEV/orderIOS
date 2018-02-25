//
//  ResponseObject.h
//
//  Created by Malcolmn Roberts on 2016/10/05.
//  Copyright (c) 2016 Malcolmn Roberts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkEnums.h"

@interface ResponseObject : NSObject

@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) id message;
@property (nonatomic, assign) NSInteger requestTag;
@property (nonatomic, assign) BaseNetworkError error;

@end
