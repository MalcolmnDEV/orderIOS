//
//  ResponseObject.m
//
//  Created by Malcolmn Roberts on 2016/10/05.
//  Copyright (c) 2016 Malcolmn Roberts. All rights reserved.
//

#import "ResponseObject.h"

@implementation ResponseObject

- (NSString *)description
{
    return [NSString stringWithFormat:@"Success: %d, Message: %@", self.success, self.message];
}

@end
