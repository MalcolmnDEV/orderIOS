//
//  ShareObject.h
//
//  Created by Malcolmn Roberts on 2017/03/02.
//  Copyright © 2017 Malcolmnmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface ShareObject : NSObject

+ (ShareObject*)parseObject:(NSString *)shareTitle SharingURL:(NSURL *)shareURL ShareBody:(NSString *)shareBody SharingImage:(UIImage *)shareImage HashTag:(NSString *)hashTag;

@property (nonatomic, strong) NSString                  *title;
@property (nonatomic, strong) NSString                  *hashTag;
@property (nonatomic, strong) NSURL                     *shareURL;
@property (nonatomic, strong) NSString                  *body;
@property (nonatomic, strong) UIImage                   *shareImage;
@property (nonatomic, strong) FBSDKSharePhotoContent    *fbSharePhotoContent; // Used for Photo and Hashtage etc NB!! Photo must be a FBSDKSharePhoto
@property (nonatomic, strong) FBSDKShareLinkContent     *fbShareLinkContent; // Used for Photo and Hashtage etc


@end
