//
//  ShareHelper.h
//
//  Created by Malcolmn Roberts on 2016/02/18.
//  Copyright © 2016 Malcolmn Roberts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareObject.h"

@protocol ShareHelperDelegate;

@interface ShareHelper : NSObject<UIDocumentInteractionControllerDelegate,FBSDKSharingDelegate>

+ (ShareHelper *)sharedManager;

@property (nonatomic, weak) id<ShareHelperDelegate> delegate;
@property (retain) UIDocumentInteractionController * documentInteractionController;

-(void)openNativeSharing:(ShareObject *)shareObj viewControler:(UIViewController *)vc delegate: (id<ShareHelperDelegate>) delegate;

-(void)shareWithFB:(UIViewController *)vc SharingObj:(ShareObject *) obj;
-(void)shareWithTwitter:(UIViewController *)vc SharingObj:(ShareObject *) obj;
-(void)shareWithWhatsApp:(UIViewController *)vc SharingObj:(ShareObject *) obj;

@end

// Delegate to Return relevant info to the viewcontroller your current in

@protocol ShareHelperDelegate <NSObject>

@required
-(void)shareOptionNotAvailable:(NSString *)title body:(NSString *)bodyText AppName:(NSString *)appName;


@optional

-(void) completionWithItemsHandlerReturned:(NSString *)activityType completed:(BOOL) completed returnedItems:(NSArray *)returnedItems error:( NSError *)activityError;

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results;
- (void)sharerDidCancel:(id<FBSDKSharing>)sharer;
- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error;

@end
