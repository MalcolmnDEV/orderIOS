//
//  ShareObject.m
//
//  Created by Malcolmn Roberts on 2017/03/02.
//  Copyright © 2017 Malcolmnmobile. All rights reserved.
//

#import "ShareObject.h"

@implementation ShareObject

+ (ShareObject*)parseObject:(NSString *)shareTitle SharingURL:(NSURL *)shareURL ShareBody:(NSString *)shareBody SharingImage:(UIImage *)shareImage HashTag:(NSString *)hashTag
{
    
    ShareObject *shareObject = [[ShareObject alloc] init];
    
    shareObject.title = shareTitle;
    shareObject.shareURL = shareURL;
    shareObject.body = shareBody;
    shareObject.hashTag = hashTag;
    shareObject.shareImage = shareImage;
    shareObject.fbSharePhotoContent = [self createFBPhotoContent:shareTitle ImageToShare:shareImage HashTag:hashTag ShareURL:shareURL];
    shareObject.fbShareLinkContent = [self createFBLinkContent:shareTitle HashTag:hashTag ShareURL:shareURL];
    
    return shareObject;
    
}

+(FBSDKSharePhotoContent *)createFBPhotoContent:(NSString *)Title ImageToShare:(UIImage *)shareImage HashTag:(NSString *)hashTag ShareURL:(NSURL *)shareURL
{
    
    FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
    FBSDKSharePhotoContent *photoObj = [[FBSDKSharePhotoContent alloc] init];
    
    photo.image = shareImage;
    
    [photoObj setPhotos:@[photo]];
    
    photoObj.hashtag = [FBSDKHashtag hashtagWithString:hashTag];
    
    return photoObj;
    
}

+(FBSDKShareLinkContent *)createFBLinkContent:(NSString *)Title HashTag:(NSString *)hashTag ShareURL:(NSURL *)shareURL
{

    FBSDKShareLinkContent *linkObj = [[FBSDKShareLinkContent alloc] init];
    
    [linkObj setContentTitle:Title];
    [linkObj setImageURL:shareURL];
    
    return linkObj;
    
}

@end
